#!/bin/env ruby
#
# Open the default  browser to a URL constructed from the root
# and the args
# 

require 'cgi'

# Use Launchy for anything but jruby

unless defined? JRUBY_VERSION
  require 'launchy'
end

class Browse
  
  def initialize root
    @root = root
    @ready_for_args = false
    if @root =~ /\?/
      @ready_for_args = true
    end
    
    if defined? JRUBY_VERSION
      singleton_class = class << self; self; end
      singleton_class.send(:define_method, :browse, method(:jruby_browse))
      @@desktop = Java::java.awt.Desktop.desktop
    end
  end
  
  def urlify args={}
    return root if args.size == 0
    unless @ready_for_args
      raise "There's no '?' in your root url '#{@root}'; can't add args" 
    end
    return @root + args.map{|k,v| "#{k}=#{CGI::escape(v)}"}.join('&')
  end
  
  def jruby_browse args={}
    @@desktop.browse(Java::java.net.URI.new(urlify args))
  end
  
  def browse args={}
    Launchy.open urlify(args)
  end
end


if __FILE__ == $0
  b = Browse.new('http://mirlyn.lib.umich.edu/Search/Home?')
  if defined? JRUBY_VERSION
    b.browse({'lookfor' => 'jruby'})
  else 
    b.browse({'lookfor' => 'ruby'})
  end
end
  
    