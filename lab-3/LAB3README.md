# OSU Courses Web Scraper

This collection of programs allows you to view the courses that are
being offered at Ohio State during the Spring 2022 term and see
information that can help you find the perfect section to match your
needs!

## Prerequisites
- Ruby
- Ruby on Rails
- PostGresql
- Yarn package manager
- Firefox
- Geckodriver

## Setup
To get started, you will need to perform a few steps before the program will be ready to run. To start with, open your terminal and use the ``cd`` command to navigate to the folder containing the web scraper, e.g. ``cd ~/seven/lab-3/web-scraper``. Next, run these commands:
```
    $ bundle install
    $ yarn install
    $ rails db:migrate

```
You will also need to make sure you have Geckodriver installed. To check if you do, run the command ``which geckodriver``. This will tell you the location of your installation. If you do not have it, download it and install using tar, then add it to your ``$PATH$`` environment variable or move it to your ``/usr/local/bin`` directory.

## Modes
For your convenience, there are multiple unique ways to get the course information you need. All options will require using your computer's terminal to enter commands.

### Rails Server
Using the rails server created a local web server which you can view and interact with in your browser. In your computer's terminal, enter the following commands from the ``lab-3`` directory:
```
    $ cd /web_scraper
    $ rails server
```
If you are in a directory other than the one containing this Readme file, you will need to specify an absolute filepath for the first command. Once these steps done, open Firefox and type ``http://localhost:3000/`` into the URL bar at the top of the window. On this page you will find the view for the web scraper. You can click the "Clear Table" button to erase previously-scraped course data, and click "Scrape" to get fresh course information. Be aware that there are a lot of courses to scan through, so this could take a while (no more than a minute).

### TODO: HUNTER'S SOLUTION

### Kimurai Spider
The spider uses Kimurai, a Ruby gem, to create a file on your computer with the information that is scraped from the course website. This data is formatted as a CSV file. To use this option, use the following commands in the terminal from the ``lab-3`` directory:
```
    $ cd /course_scraper
    $ kimurai crawl courses_scraper
```
This will take a few moments to run, then create a file called ``scraped_courses.csv``, which contains all of the course entries and their properties separated by commas. This can be viewed in external programs such as Microsoft Excel, or you can view it in its raw form in the terminal by typing:
```
    $ cat scraped_courses.csv
```
You can move or delete this file, as it will be created/overwitten each time the program is run. This option allows you to save the course data and review it later without spending the time to spin up an entire local server.

### Help
For help using this web scraper, please contact one of the developers.