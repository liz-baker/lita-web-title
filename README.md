# lita-web-title

A simple plugin to parse URIs in chat and return the title. Also follows 30x redirects if they are found

## Installation

Add lita-web-title to your Lita instance's Gemfile:

``` ruby
gem "lita-web-title"
```

## Configuration

### Required attributes
None

### Optional attributes
* ```ignore_patterns``` (String or Array) - A pattern or list of patterns.  When a URL matches any of these patterns, Lita will silently ignore it.  Default: ```nil```.  Example: ```config.handlers.web_title.ignore_patterns = ["rpm.newrelic.com","example.com","my(dev|stg|prd).com"]```

## Usage

``` no-hilight
dosman-bot > http://bit.ly/1RmnUT
Google
```
