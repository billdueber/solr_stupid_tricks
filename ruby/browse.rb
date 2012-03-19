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
  
  def jruby_browse args={}, forcetype=nil
    if forcetype
      args['wt'] = forcetype
    end
    @@desktop.browse(Java::java.net.URI.new(urlify args))
  end
  
  def browse args={}, forcetype = nil
    if forcetype
      args['wt'] = forcetype
    end
    Launchy.open urlify(args)
  end
end


if __FILE__ == $0
  unless ARGV.size > 0
    puts "\nusage: ruby browse.rb jsonfile   OR"
    puts   "       ruby browse.rb jsonfile [json|csv|standard|xml] OR"
    exit
  end
  b = Browse.new('http://localhost:8983/solr/select/?')
  args = eval(File.open(ARGV[0]).read)
  ARGV[1] = 'standard' if ARGV[1] == 'xml'
  unless args.kind_of? Array
    args = [args]
  end
  args.each {|a| b.browse a, ARGV[1]}
end
  
    