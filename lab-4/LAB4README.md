# OSU Student Grader Assignment Web Application

This program allows students, instructors, and administrators at Ohio
State to interact with each other by submitting applications and
recommendations for grading positions in the CSE department.

## Prerequisites
- Ruby
- Ruby on Rails
- PostGresql
- Yarn package manager
- Firefox
- Geckodriver

## Setup
To get started, you will need to perform a few steps before the
program will be ready to run. To start with, open your terminal and
use the ``cd`` command to navigate to the folder containing the web
scraper, e.g. ``cd ~/seven/lab-3/web-scraper``. Next, run these
commands:
```bash
    $ bundle install
    $ yarn install
    $ rails db:migrate
```
You will also need to make sure you have Geckodriver installed. To
check if you do, run the command ``which geckodriver``. This will
tell you the location of your installation. If you do not have it,
download it and install using tar, then add it to your ``$PATH$``
environment variable or move it to your ``/usr/local/bin`` directory.

## Rails Server
Using the rails server created a local web server which you can view
and interact with in your browser. In your computer's terminal, enter
the following commands from the ``lab-4`` directory:
```bash
    $ cd /web_scraper
    $ rails server
```
If you are in a directory other than the one containing this Readme
file, you will need to specify an absolute filepath for the first
command. Once these steps done, open Firefox and type
``http://localhost:3000/`` into the URL bar at the top of the window.

On this page you can select your role from the list of possible roles, as specified below.

## Roles
There are three possible roles that a user can have in this web
application:
1. Student
2. Instructor
3. Administrator

### Student
Students have only a few capabilities. They can see the courses
that are being offered in the upcoming semester and they can submit
applications for grading positions. A student may only have one
active application at a time, so if they have submitted one they
can only modify it, not submit more.

### Instructors
Course instructors are able to both see the table of submitted
student applications for grading positions and also submit forms
of their own that specify their recommendations for students. An
instructor can submit as many recommendations as they like.

### Administrator
Administrators have the most capabilities of any role. They can see
the courses that are being offered, view all student grader
applications, and view all instructors' recommendations. They have
the authority to assign graders to sections by clicking "Edit" in
the courses table and adding graders' names. Administrators can
also use their view of the instructors' recommendations to gather
information about students. This information can then be
cross-referenced with the grader applications to make informed
decisions when assigning graders.


***A note about scraping: the courses table uses a web scraper
that communicates with the courses website in real time, meaning that it sometimes a few moments to gather data. This is normal and should not be interupted.***