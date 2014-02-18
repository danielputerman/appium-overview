require 'eyes_selenium'

## 
# Based on Appium example script from Appium: https://github.com/appium/appium/tree/master/sample-code/examples/
#
# This script performs the same actions as the appium_example.rb script, but it also includes visual validation 
# which enables a *huge* amount of coverage with very little code addition, and without the need to include any
# "assert"/"veirfy" commands.
# You can learn more about visual validation suing Applitools at https://www.applitools.com

Applitools::Eyes.config[:apikey] = 'YOUR_API_KEY'  # The api key you are given when signing up to applitools.


desired_capabilities = {
    "device" => "Android",
    "version" => "4.2",
    "newCommandTimeout" => 300,
    "app" => "c:\\test\\NotesList.apk",
    "app-package" => "com.example.android.notepad",
    "app-activity" => ".NotesList"
  }

def create_note(text)
	@driver.find_element(:name, "New note").click
	@driver.find_element(:tag_name, "textfield").send_keys text
	@eyes.check_window("Note: #{text}")
	@driver.find_element(:name, "Save").click
end

def clear_note_by_text(text)
	@driver.find_element(:name, "#{text}").click
	@driver.find_element(:tag_name, "textfield").clear
	@driver.find_element(:name, "Save").click
end

@eyes = Applitools::Eyes.new
begin
	@driver = Selenium::WebDriver.for(:remote, :url => 'http://127.0.0.1:4723/wd/hub', :desired_capabilities => desired_capabilities)
	# Open a visual validation test on Applitools
	@driver = @eyes.open(app_name: 'Selenium Israel', test_name: 'Appium Notepad', driver: @driver)

	# Visual validation checkpoint
	@eyes.check_window("No notes")

	create_note "I didn't expect a kind of Spanish Inquisition!"
	create_note "Nobody expects the Spanish Inquisition!"
	@eyes.check_window("Two notes")

	clear_note_by_text "I didn't expect a kind of Spanish Inquisition!"
	@eyes.check_window("One note")

	# End visual validation test on Applitools.
	@eyes.close
	sleep 5
ensure
	@eyes.abort_if_not_closed
	@driver.quit
end
