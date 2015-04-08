# Object Representing Coures in the Moddle Interface
# -----------------------------------------------------------------------------
# Authors: Nini Jewootah (njewootah@spartaglobal.com) & Danny Smith (dsmith@testingcircle.com)
# Date Modified: 2015-04-08
# -----------------------------------------------------------------------------

class Course
  attr_reader :fullname, :shortname, :summary, :reason, :id
  attr_accessor :tag

  @@courses = []

  def initialize(browser, params ={})
    raise "You must provide a fullname parameter" unless params[:fullname]

    details = {
      summary: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium.",
      tag: nil
    }

    # Merge details with parameters
    details.merge!(params)

    @browser = browser
    @fullname = details[:fullname]
    @shortname = generate_shortname(@fullname)
    @summary = details[:summary]
    @reason = details[:reason]
    @tag = details[:tag]

    # Login as teacher
    User.new(@browser, tag: 'teacher1').login

    # Visit Page
    @browser.goto EnvConfig.base_url + EnvConfig.course_request_url

    #fill/submit form
    @browser.text_field(id: 'fitem_id_fullname').set full_name
    @browser.text_field(id: 'fitem_id_shortname').set short_name
    @browser.element(id: 'id_summary_editoreditable').send_keys summary
    @browser.textarea(id: 'id_reason').set reason
    @browser.button(id: 'id_submitbutton').click

    Utilities.login_as_admin @browser

    # Visit Pending Page

    @browser.goto EnvConfig.base_url + EnvConfig.course_pending_url

    approve(@fullname)
    @id = @browser.url[/\d+/]

    Utilities.logout(@browser)
    @@courses << self
  end

  # Class Methods

  def self.all
    @@courses
  end

  def self.last
    @@courses.last
  end

  def self.find_by_id(id)
    @@courses.each do |course|
      return course if course.id == id
    end
  end

  def self.find_by_name(name)
    @@courses.each do |course|
      return course if course.name == name
    end
  end

  def self.find_by_tag(browser, tag)
    results = []
    @@courses.each do |course|
      results << course if (course.tag == tag)
    end
    results
  end

  # Instance Methods

  def delete!

  end


  private

  def generate_shortname(name)
    name[0..3] + rand(999).to_s
  end

  def approve(course_name)
    @browser.tbody.trs.each do |row|
      if row.tds[1].text == course_name
        row.input(ELEMENT[:approve]).click
        break
      end
    end
  end
end



