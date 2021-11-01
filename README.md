## 🗃Log Parser Test Task
[![Tests](https://github.com/miseinen/log-parser/actions/workflows/tests.yml/badge.svg)](https://github.com/miseinen/log-parser/actions/workflows/tests.yml)

### 📋Description:<br/>
- **Write a ruby script that:**<br/>
- [x] Receives a log as an argument (webserver.log is provided): e.g.: `./parser.rb webserver.log`
- [x] Returns formatted logs as the following:<br/>
<pre>
  > list of webpages with most page views ordered from most pages views to less page views
      /home 90 visits
      /index 80 visits etc…
   > list of webpages with most unique page views also ordered
      /about/2 8 unique views
      /index 5 unique views etc…`
</pre>
- **Cover by unit tests**<br/>

### 📥Installation: <br/>
- Clone this repo
- Install Ruby v3.0.2. Click the button for instructions => [![image](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/en/documentation/installation/)
- Open a terminal and navigate to the folder containing the cloned repo
- Run ```bundle install```
- Run ```./lib/parser.rb ./lib/webserver.log```🎉

### 🔨Testing:
To enjoy green🟢tests navigate to the root repo folder in the terminal and run:

- unit tests with the help of [**Rspec**](https://github.com/rspec) => ```bundle exec rspec -fd```
- code style tests with the help of [**Rubocop**](https://github.com/rubocop/rubocop) => ```bundle exec rubocop```

### 🔬Approach:
- _**DefaultFileValidator**_ validates given log file's existence, extension (_.log_, _.txt_) and data (_has file any data?_)
- _**DefaultVisitorsList**_ is used to create list containing data from provided webserver.log file about visitors of every page. This class collects pages and visitors from log line using specific patterns (regular expressions).
- _**ViewsExtractor**_ retrieves and sorts list of pages and visitors composed with the help of _VisitorsList_ using as a dependency injection (that provides ability to use different solutions for _VisitorsList_ for different log patterns). _FileValidator_ is used as a dependency injection to validate given file before retrieving any data.
- _**Printer**_ is a class that helps to print information in a specific format.
- _**Parser**_ is a script that uses previously described classes to parse log file and display information in the terminal.

### 🛠Customization:<br/>
Feel free to make custom _VisitorsList_, _FileValidator_ or _Printer_ using the same interfaces. You can change _file_validator_, _visitors_list_, _printer_ in parser.rb with links to your custom solutions if you have logs with different formats.
