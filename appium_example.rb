require 'selenium-webdriver'

## 
# Based on Appium example script from Appium: https://github.com/appium/appium/tree/master/sample-code/examples/

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
	@driver.find_element(:name, "Save").click
end

def clear_note_by_text(text)
	@driver.find_element(:name, "#{text}").click
	@driver.find_element(:tag_name, "textfield").clear
	@driver.find_element(:name, "Save").click
end

begin
	@driver = Selenium::WebDriver.for(:remote, :url => 'http://127.0.0.1:4723/wd/hub', :desired_capabilities => desired_capabilities)

	create_note "I didn't expect a kind of Spanish Inquisition!"
	sleep 70
	create_note "Nobody expects the Spanish Inquisition!"
	clear_note_by_text "I didn't expect a kind of Spanish Inquisition!"

	sleep 5
ensure
	@driver.quit
end