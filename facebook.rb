class Facebook

  attr_reader :browser

  def initialize
    @browser = Watir::Browser.new :chrome
    #@browser.driver.manage.window.resize_to 1240,768
  end

  def close
    @browser.close if CLOSE_BROWSER
  end

  def login
    @browser.goto 'https://www.facebook.com/'
    if !UI_LOGIN
      @browser.text_field(:id, "email").set USERNAME
      @browser.text_field(:id, "pass").set PASSWORD
      @browser.button(:type, "submit").click
    else
      # Wait for the user to input the login info.
      Watir::Wait.until {
        !@browser.text_field(:id, "pass").exists?
      }
    end
    while !@browser.li(:id, "navHome").exists? do
      if @browser.form(:class, "checkpoint").exists?
        continue = @browser.button(:value, "Continue")
        if continue.exists?
          continue.click
        end
        itsok = @browser.button(:value, "This is Okay")
        if itsok.exists?
          itsok.click
        end
      end
    end
  end

  def collect_days
    @browser.goto DIRECTORY_URL
    day = 1
    links = {}
    while @browser.p(:text, "Day #{day}:").exists?
      link = @browser.p(:text, "Day #{day}:").element(:xpath => './following-sibling::p').link.href
      links[day] = link
      day += 1
    end
    links
  end

  def collect_sagas(links={})
    sagas = {}
    links.each_pair do |day, link|
      @browser.goto link
      @browser.wait(5)
      # Get the Director's saga first.
      director = @browser.div(:class => "userContentWrapper").h5.text
      rawpost = @browser.div(:class => "userContent").text
      sagas[director] ||= {}
      sagas[director][day] ||= []
      sagas[director][day] << rawpost

      # Get the sagas from the comments
      @browser.divs(:class => "UFICommentContent").each do |div|
        seemore = div.link(:text, /See More/)
        if seemore.exists? && seemore.visible?
          seemore.click
        end
        author = div.link(:class, "UFICommentActorName").text
        sagas[author] ||= {}
        # It's possible that the same person comments multiple times on a thread.
        # Since we don't know which is the saga, save all of them.
        sagas[author][day] ||= []
        sagas[author][day] << div.text.sub("#{author} ", "")
      end
    end
    sagas
  end
end
