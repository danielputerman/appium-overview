This is the example code for the Appium overview presentation I've given on the Selenium Israel meetup.

http://www.meetup.com/Selenium-Israel/events/163313472/

The examples where for automating the Notes application for Android, and was based on the examples given on the appium repository:
https://github.com/appium/appium/tree/master/sample-code/examples/

There are two scripts:
* `appium_example.rb`: A scripts which creates two notes, then edits a note and clears it.
* `appium_eyes_example.rb`: Same as appium_example.rb, but also includes visual validation using Applitools eyes. Notice in order for this script to work you need to have *a valid API key* from Applitools (http://www.applitools.com).



