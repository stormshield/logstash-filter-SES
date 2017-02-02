# encoding: utf-8
require 'set'
require 'logstash/filters/base'
require 'logstash/namespace'

class LogStash::Filters::SES < LogStash::Filters::Base
  config_name 'SES'

  public
  def register
    @re_source = /\.(?<extension>[^\.\<]*)\<(?<certificat>[^\>]*)\>\<(?<md5>[^\>]*)\>\<(?<sha1>[^\>]*)\>/
    @re_destination = /\.(?<extension>[^\.]*)$/
  end # def register

  public
  def filter(event)

    if event.get('status') == 'EXT-BLK'
      # Try to extract the file extensions
      m = @re_source.match(event.get('source'))
      if m
        event.set('source_extension', m['extension'])
      end
      m = @re_destination.match(event.get('dest'))
      if m
        event.set('target_extension', m['extension'])
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::SES
