require 'powify/app'
require 'powify/client'
require 'powify/server'
require 'powify/utils'
require 'fileutils'

module Powify
  POWPATH = File.expand_path("~/.pow")

  def current_path
    %x{pwd}.strip
  end

  def extension
    if File.exists?('~/.powconfig')
      return %x{source ~/.powconfig; echo $POW_DOMAIN}.strip unless %x{source ~/.powconfig; echo $POW_DOMAIN}.strip.empty?
      return %x{source ~/.powconfig; echo $POW_DOMAINS}.strip.split(',').first unless %x{source ~/.powconfig; echo $POW_DOMAINS}.strip.empty?
    else
      return %x{echo $POW_DOMAIN}.strip unless %x{echo $POW_DOMAIN}.strip.empty?
      return %x{echo $POW_DOMAINS}.strip.split(',').first unless %x{echo $POW_DOMAINS}.strip.empty?
    end

    return 'dev'
  end

  def config
    result = %x{curl localhost/config.json --silent --header host:pow}
    JSON.parse(result)
  end
end