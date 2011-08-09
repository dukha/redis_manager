require 'spec_helper'

describe "Whiteboards" do
  describe "GET /Whiteboards" do
    it "index pages exists" do
       visit whiteboards_path
       page.should have_content(I18n.t("headings.whiteboards"))
=begin
       #print html in terminal
       puts source

       puts page.has_xpath?( "//table[@id='whiteboard_table']" )
       puts page.has_xpath?( "//table[@id='whiteboard_table']/tr[@id='whiteboard_row1']/td[@id='whiteboard_cell_link1']/a[@id='whiteboard1']")
       puts page.has_xpath?( "//table/tr[2]/td[1]")
       
       puts page.has_xpath?( "//td")
       # below uses class as selector
       puts page.has_selector?('table tr td.whiteboardlink a')
       # below uses class and id as selectors
       puts page.has_selector?('table tr td.whiteboardlink a#whiteboard1')
       puts page.has_selector?("#whiteboard1")
       # below gives false: need # for id
       puts !page.has_selector?("whiteboard1")
       puts page.has_content?('under development')
       within(:xpath, "//table[tr[@id='whiteboard_row1']]") do
          within( "#whiteboard_row1") do
           within( "#whiteboard_cell_link1")  do
             click_link( "whiteboard1")
           end
         end
       end
=end
      # @class='whiteboard']/h:tr[@class='whiteboard']") do
         #page.should have_content("version")
       end
       #response.should  have_xpath(".//body/table[@name='whiteboards_table']")
       #within "#whiteboard_table" do
        # within "#whiteboard_row1" do
          # within "#whiteboard_cell_link1"  do
             #click_link "whiteboard1"
           #end
         #end
        #end  @id='whiteboard_row1'
       #end
       #response.status.should be(200)
       #have_xpath(".//body/table[@name='whiteboards_table']")
    end
  end
#end
