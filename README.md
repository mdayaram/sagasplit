sagasplit
=========

Collects and splits mini sagas per person.

### Installation
* `gem install bundler`
* `bundle install`
* If running in Chrome, download the [chromedriver](http://chromedriver.storage.googleapis.com/index.html) (version >= 2.8) and drop it somewhere in your PATH.
* `cp config/config_sample.yml config/config.yml`
* Edit the config.yml file with appropriate info.

### Config

##### Email and Password
You can choose to put your facebook email and password in the config file and
let the program take care of the rest.  If you feel uncomfortable putting your
credentials in a text file, you can set the `ui_login` option (true by
default).  This option will wait at the facebook login screen for you to input
your credentials directly on the facebook homepage.  This is the prefered login
method.

##### Directory Link
In order for the program to accurately only read posts that are mini-saga
threads, the permalink to the mini-saga directory post needs to be supplied.
You can get this link by click on the date of the particular post.

### Running
I made a bash script to run the command, just run that:

```bash
$ ./kapow
```

