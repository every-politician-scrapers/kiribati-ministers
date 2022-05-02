#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full: parts.first,
        prefixes: ['H.E', 'Hon.']
      ).short
    end

    def position
      parts.last.gsub(/\s*\(.*/, '').split(/ and (?=Minister)/)
    end

    private

    def parts
      noko.text.split(',', 2).map(&:tidy)
    end
  end

  class Members
    def member_container
      noko.css('.tm-content ol li')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
