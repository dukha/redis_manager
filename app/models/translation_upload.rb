class TranslationUpload < ActiveRecord::Base
  attr_accessible :applications_language_id, :description, :translation
  
  belongs_to :application_languages

  validates :applications_language_id,  :presence=>true
  validates_attachment_presence :translation



  has_attached_file :translation, #:styles => { :iso_code => "en" },
     :url => "/translations/translation/:id/:style/:basename.:extension",
     :path => ":rails_root/public/translations/translation/:id/:basename.:extension"
  # We are uploading yaml files with the name format <name>.<language_code>.yml
  def file_name_prefix
    return translation.path.split("/").last.split(".").first
  end

  def write_to_redis translation
    file = File.new translation.path
    parse_file_to_db file
  end

  def parse_file_to_db file
  listener = Psych::TreeBuilder.new
  parser   = Psych::Parser.new  listener
  parser.parse file
  tree = parser.handler.root
  dot_key_values_map = Hash.new
  dot_key_stack = Array.new
  traverse( tree, dot_key_stack,  Hash.new, dot_key_values_map, nil )
  puts @test_hash.to_s
  end

=begin
 Traverses the AST tree from the psych parser handler root, building a map of dot_keys and translations
 e.g. {"en.formtastic.labels.name" =>"Name", "en.formtastic.labels.dob"=>"Date of Birth"}
 from the yaml file parsed into a tree.
 Writes the dot_key and translation together with anchors and aliases to Translations objects and then to db.
 @param node takes a parser.handler.root in node
 @param dot_key_stack is an array of each partial key, removed as map etc is finished
 @param in_sequence is used as a boolean (=nil) and as a count of members of array
 @param container can be a map, array, however to initiate the recursive calls give a hash
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
def  traverse( node, dot_key_stack=Array.new, dot_key_values_map=Hash.new, container=Hash.new, in_sequence=nil)
  scalar_content =false
  node.children.each { |child|
    if child.is_a? Psych::Nodes::Stream then
      map = Hash.new
       traverse( child, dot_key_stack, dot_key_values_map, map, nil)
    elsif child.is_a? Psych::Nodes::Document then
      map = Hash.new
       traverse(  child, dot_key_stack, dot_key_values_map, map, nil)
    elsif child.is_a? Psych::Nodes::Mapping then
      map= Hash.new
      scalar_content = false
      in_sequence = nil
       traverse( child, dot_key_stack, dot_key_values_map, map, in_sequence)
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
        dot_key_values_map.store(dot_key, ((scalar_content and child.anchor) ? ("&" + child.anchor + " ") : "") + child.value)
        if container.is_a? Hash then
          # case of content into hash
          container.store(dot_key_stack.pop, child.value)
          write_translation_to_hash(  dot_key, nil, true, child.anchor)
        end
      end unless in_sequence
      if container.is_a? Array then
        # case of sequence
        container.push child.value
        dot_key = dot_key_stack.join(".") << "." + format_leading_zeros( container.length-1)
        dot_key_values_map.store(dot_key, ((scalar_content and child.anchor) ? ("&" + child.anchor + " ") : "") + child.value)
        write_translation_to_hash(  dot_key, child.value, true, child.anchor)
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
        dot_key_values_map.store(dot_key, "*" + child.anchor )
        write_translation_to_hash(  dot_key, nil, false, child.anchor)
        if in_sequence then
          in_sequence =+ 1
        else
          in_sequence = 0
        end
      else
        # must be a hash
        dot_key = dot_key_stack.join "."
        puts dot_key
        dot_key_values_map.store(dot_key, "*" + child.anchor)
        container.store(dot_key_stack.pop, child.anchor)
        write_translation_to_hash(  dot_key, nil, false, child.anchor)
        scalar_content= false
      end
    elsif child.is_a? Psych::Nodes::Sequence
      dot_key = dot_key_stack.join "."
      array = Array.new
      in_sequence = 0
       traverse( child, dot_key_stack,  dot_key_values_map, array, in_sequence)
      in_sequence =nil
      scalar_content=false
      container.store(dot_key_stack.pop, array)
    end
  }
  return
  end
  @test_hash = Hash.new
  @redis = Redis.new(:db=>0)
  def write_translation_to_hash(key, translation, translatable=true, anchor_or_alias=nil, tag=nil)
    #@redis.set(key, translation)
    @test_hash.store(key, translation)
  end
  def format_leading_zeros(num)
    return "%03d"  % num
  end

  def write_translation_to_redis( redis_connection, dot_key, translation)

  end
end
