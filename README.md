# IBM Homework Site

## Prerequisites:
### dev tools installed (for compiling EventMachine, possibly others)
If running on AL or another RHEL-based platform:
```bash
sudo yum group install "Development Tools"
```
### Ruby
RVM is ideal
```bash
# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable --ruby
# Use the same Ruby I used to develop this package
rvm use --default ruby-2.5.1
``` 

## Install:
```bash
$ cd ibmsite && bundle install
```
```ruby
Fetching gem metadata from https://rubygems.org/..............
Resolving dependencies...
Using bundler 1.16.2
Using daemons 1.2.6
Using eventmachine 1.2.7
Using rack 2.0.5
Using thin 1.7.2
Bundle complete! 2 Gemfile dependencies, 5 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

## Run:
```bash
$ bundle exec rackup -E $TEST_DEVELOPMENT_DEPLOY
```
```ruby
Thin web server (v1.7.2 codename Bachmanity)
Maximum connections set to 1024
Listening on 0.0.0.0:8888, CTRL+C to stop
```

## Example results:
### App uptime
```bash
curl $SERVER_IP:8888
```
```json
{"siteUpSince":"2018-10-14 03:43:46 +0200","IPs":{"123.45.67.89":9}}
```

### Server (host) uptime
```bash
curl $SERVER_IP:8888/system
```
```json
{"siteUpSince":"2018-01-07 00:07:14 +0100","IPs":{"123.45.167.89":4}}
```

## Original text:
> # DevOps HOMEWORK Challenge
> 
> Here is the assignment for the DevOps candidate. The assignment uses standard IETF requirements terms:  https://www.ietf.org/rfc/rfc2119.txt
> 
> ## Agile Story: 
> As a DevOps candidate I want to create a simple website so that I can showcase my ability with cloud technology, linux, automation, scripting, and documentation. 
> 
> ## Acceptance Criteria:   
> Must develop a simple website and deploy it to your favorite public cloud provider.   AWS may be used.
> 
> ## Website Functionality
> Must receive HTTP Requests of the form: http://yoursite/
> The web page must show the the application launch time.
> The web page must show all unique IPs from scanning the web server access log.
> The web page must show the count per IP address.
> The web page may look like the following …
> ```                
> This site has been up since <site up datetime>       
> These are all of the IP addresses that are found in the web container log files
> <IP1>
> <IP2>
> … 
> ```
> HTTP Response format should be in HTML or JSON
> 
> ## Deployment
> Deployment should be automated as much as possible
> May use a tool like Terraform or AWS Cloudformation to create the cloud infrastructure  
> Should deploy the server/container and the web app
> 
> ## Deliverables 
> Must provide link to public repo (github, gitlab, bitbucket, etc)
> All files and code must be included in the repo.
> Complete instructions on how to setup and test the solution must be included in the repo.
> Instructions should be targeted to a junior level DevOps engineer
> 
> ## Example Usage
> 
> Request #1: curl http://yoursite/  
> Response: (e.g. as json)  
> ```{ 
> “siteUpSince” : “2018-07-25T2300000Z”,
> “IPs” : {
>   “10.100.220.1” : 1
>   }
> }
> ```
> Request #2: curl http://yoursite/  
> Response: (e.g. as json)  
> ```{ 
> “siteUpSince” : “2018-07-25T2300000Z”,
> “IPs” : {
>   “10.100.220.1” : 2
>   }
> }
> ```
> Request #N: curl http://yoursite/ (from different IPs)  
> Response: (e.g. as json)   
> ```{ 
> “siteUpSince” : “2018-07-25T2300000Z”,
> “IPs” : {
>   “10.100.220.1” : 2,
>   “10.100.220.8” : 1,
>   “10.100.221.3” : 5
>   }
> }
> ```
