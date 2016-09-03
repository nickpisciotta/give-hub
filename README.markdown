# GiveHub

## About

GiveHub provides a common space for local charities to list current needs for their recipients.  We envision registered users accessing our application to donate to a particular charity they have in mind, or a specific cause of his or her interest. The user can navigate through our site to find a charity, find a recipient, and donate to this charity based on the recipient's needs.

[GiveHub](http://give-hub.herokuapp.com/) is a shop that unites local charities and allows users to donate to their recipients directly.  This site exercises the concepts of multitenancy, extensive seed files, rails-app security, and integrating JavaScript via jQuery search fields and chartJS for business analytics.

## Creators

This was created by [Marcella Wigg](https://github.com/marcellawigg), [Kerry Sheldon](https://github.com/kjs222), and [Nick Pisciotta](https://github.com/nickpisciotta), as part of the [Turing School of Software & Design's](https://www.turing.io/) Module 3 curriculum. This was adapted from the previous code base, [refugeerestore](https://github.com/robbiejaeger/little_shop).
##Development
This project utilizes Ruby on Rails as a web app framework, [Paperclip](https://github.com/thoughtbot/paperclip) and [AWS](https://aws.amazon.com/s3/) for file attachment & storage, [rails action mailer](http://guides.rubyonrails.org/action_mailer_basics.html), and [Bootstrap](http://getbootstrap.com/) for styling.

##  Production
Visit [Give-Hub](http://give-hub.herokuapp.com/) to view our site!

## App Overview
![](http://g.recordit.co/gCuNqW6zUK.gif)

## Admin Features

![](http://g.recordit.co/ZIfaERg5wu.gif)

## Installation Instructions To Run Locally
```
git clone git@github.com:nickpisciotta/give-hub.git
cd give-hub
bundle
rake db:create
rake db:migrate
rails s
```
