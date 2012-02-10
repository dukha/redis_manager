class Upload < ActiveRecord::Base
  include Validations
  attr_accessible :language_id, :upload, :description #, :translation
  
  belongs_to :language
  #has_many :uploads_redis_databases
  #has_many :redis_databases, :through => :uploads_redis_databases

  validates :language_id,  :presence=>true
  validates :language_id, :existence => true
  validates_attachment_presence :upload

=begin
  def save
    super
    write_file_to_db
  end
=end
  has_attached_file :upload, #:styles => { :iso_code => "en" },
     :url => "/uploads/upload/:id/:style/:basename.:extension",
     :path => ":rails_root/public/uploads/uploads/:id/:basename.:extension"
  # We are uploading yaml files with the name format <name>.<language_code>.yml
  def file_name_prefix
    return upload.path.split("/").last.split(".").first
  end
  #@@test_hash = Hash.new
  #@redis = Redis.new(:db=>0)
  def write_file_to_db 
    @data_hash = Hash.new
    debugger
    file = File.new upload.path
    parse_file_to_db file
  end
  def write_to_redis redis_db=nil
    @data_hash = Hash.new
    debugger
    file = File.new upload.path
    parse_file_to_db file
    if redis_db then
      redis = Redis.new( :db=> redis_db.redis_db_index, :password=>redis_db.password, :port=>redis_db.port, :host=> redis_db.host)
      @data_hash.each{ |key, value|
        redis.set(key, value)
      }
    end
  end

  def parse_file_to_db file
  puts "start"
  listener = Psych::TreeBuilder.new
  parser   = Psych::Parser.new  listener
  parser.parse file
  tree = parser.handler.root
  dot_key_values_map = Hash.new
  dot_key_stack = Array.new
  anchors= Hash.new
  puts "before traverse"
  return traverse_yaml( tree)  #, dot_key_stack,  Hash.new, dot_key_values_map,anchors, nil )
  #debugger
  #puts @@data_hash.to_s
  end

=begin
 Traverses the AST tree from the psych parser handler root, building a map of dot_keys and translations
 e.g. {"en.formtastic.labels.name" =>"Name", "en.formtastic.labels.dob"=>"Date of Birth"}
 from the yaml file parsed into a tree.
 Writes the dot_key and translation together with anchors and aliases to Translations objects and then to db.
 @param node takes a parser.handler.root in node
 @param dot_key_stack is an array of each partial key, removed as map etc is finished
 @param dot_key_values_map If given then this will provide a way of recreating the yaml file
 @param in_sequence is used as a boolean (=nil) and as a count of members of array
 @param container can be a map, array, however to initiate the recursive calls give a hash
 @param anchors Hash containing the keys and value for any anchors in the yaml file. Used for translating aliases.
 @param dot_key_values_map is a hash of dot_keys with values (including anchors and aliases)


 Note that in a translation file it is not possible to have a hash nested in an array (no dot_key possible), although this would be possible in yaml
 This method will not deal with that possibility
 Use like this
 > listener= Psych::TreeBuilder.new
 > parser   = Psych::Parser.new  listener
 > parser.parse File.new "test/fixtures/yaml_file_parsing/yaml_test.yml"                 # default.en.yml"                 #{}tree_print.yml"   #{}yaml_test.yml"          #{}
 > tree = parser.handler.root
 > container = Hash.new
 > dot_key_values_map = Hash.new
 > traverse language_id, tree, Array.new,  dot_key_values_map, container, nil
 > puts dot_key_values_map.to_s
=end
def  traverse_yaml( node, dot_key_stack=Array.new, dot_key_values_map = nil,  container=Hash.new, anchors = Hash.new, in_sequence=nil )
  puts node.to_s
 
  scalar_content =false
  node.children.each { |child|
    debugger
    if child.is_a? Psych::Nodes::Stream then
      map = Hash.new
      traverse_yaml( child, dot_key_stack, dot_key_values_map, map,anchors, nil)
    elsif child.is_a? Psych::Nodes::Document then
      map = Hash.new
      puts child
      traverse_yaml(  child, dot_key_stack, dot_key_values_map, map, anchors, nil)
    elsif child.is_a? Psych::Nodes::Mapping then
      map= Hash.new
      scalar_content = false
      in_sequence = nil
      traverse_yaml( child, dot_key_stack, dot_key_values_map, map, anchors, in_sequence)
      if container.is_a? Hash then
        if dot_key_stack.length > 0 then
          key = dot_key_stack.pop
        else
          key= "document"
        end
        container.store(key, map)
      else
        raise Exception.new( "Error in parsing file. Trying to insert into " + container.class + ". Only Array and Map are allowed by Calm. Problem data is " + map.to_s)
      end
    elsif child.is_a? Psych::Nodes::Scalar then
      scalar_content = true if in_sequence
      unless scalar_content then
        dot_key_stack.push child.value
      end
      if scalar_content then
        dot_key = dot_key_stack.join "."
        if dot_key_values_map then
          dot_key_values_map.store(dot_key, ((scalar_content and child.anchor) ? ("&" + child.anchor + " ") : "") + child.value)
        end
        if child.anchor then
          anchors.store(child.anchor, child.value)
        end
        if container.is_a? Hash then
          # case of content into hash
          container.store(dot_key_stack.pop, child.value)
          write_translation_to_hash(  dot_key, child.value) #, true, child.anchor)
        end
      end unless in_sequence
      if container.is_a? Array then
        # case of sequence
        container.push child.value
        dot_key = dot_key_stack.join(".") << "." + format_leading_zeros( container.length-1)
        if dot_key_values_map then
          dot_key_values_map.store(dot_key, ((scalar_content and child.anchor) ? ("&" + child.anchor + " ") : "") + child.value)
        end
        if child.anchor then
          anchors.store(child.anchor, child.value)
        end
        if in_sequence then
          in_sequence =+ 1
        else
          in_sequence = 0
        end
      end
      scalar_content = !scalar_content unless in_sequence
    elsif child.is_a? Psych::Nodes::Alias
      if container.is_a? Array then
        # case of sequence
        container.push child.anchor
        dot_key = dot_key_stack.join(".") << "." + format_leading_zeros( container.length-1)
        if dot_key_values_map then
          dot_key_values_map.store(dot_key, "*" + child.anchor )
        end
        if in_sequence then
          in_sequence =+ 1
        else
          in_sequence = 0
        end
      else
        # must be a hash
        dot_key = dot_key_stack.join "."
        puts dot_key
        if dot_key_values_map then
          dot_key_values_map.store(dot_key, "*" + child.anchor)
        end
        container.store(dot_key_stack.pop, child.anchor)
        write_translation_to_hash(  dot_key, anchors[child.anchor]) #, false, child.anchor)
        scalar_content= false
      end
    elsif child.is_a? Psych::Nodes::Sequence
      dot_key = dot_key_stack.join "."
      array = Array.new
      in_sequence = 0
      traverse_yaml( child, dot_key_stack,  dot_key_values_map, array, anchors,  in_sequence)
      in_sequence =nil
      scalar_content=false
      container.store(dot_key_stack.pop, array)
      write_translation_to_hash(dot_key, array.to_s) #, false, child.anchor)
    end
  }
  return container
  end

  
  def write_translation_to_hash(key, translation ) #, translatable=true, anchor_or_alias=nil, tag=nil)
    #@redis.set(key, translation)
    @data_hash.store(key, translation)
  end
  def format_leading_zeros(num)
    return "%03d"  % num
  end

end

# == Schema Information
#
# Table name: uploads
#
#  id                       :integer         not null, primary key
#  language_id              :integer         not null
#  upload_file_name         :string(255)     not null
#  upload_file_content_type :string(255)
#  upload_file_size         :integer
#  upload_file_updated_at   :datetime
#  description              :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

