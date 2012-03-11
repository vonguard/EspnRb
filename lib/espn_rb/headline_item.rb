class HeadlineResponse
  class HeadlineItem
    attr_reader :headline

    def initialize(opts)
      @headline = opts
    end

    # @example
    #   espn = EspnRb::Headline
    #   espn.nba.first.web_url => "http://some-valid-nba-article"
    # @return [String] web_url for Item
    def web_url(mobile=false)
      (mobile == true) ? @headline["links"]["mobile"]["href"] : @headline["links"]["web"]["href"]
    end

    # @example
    #   espn = EspnRb::Headline
    #   espn.ncaa_football.first.title => "Gators Win!!"
    # @return [String] title for Item
    def title
      @headline["headline"]
    end


    # @example
    #   espn = EspnRb::Headline
    #   espn.ncaa_football.first.id => 1234
    # @return [Integer] id for Item
    def id
      @headline["id"]
    end

    # @example
    #   espn = EspnRb::Headline
    #   espn.nba.first.api_url => "http://some-valid-nba-article"
    # @return [String] api_url for Item
    def api_url
      @headline["links"]["api"]["news"]["href"]
    end


    def collect_category(sym)
      @headline["categories"].inject([]) {|m, i| m <<  i[sym.to_s] unless i[sym.to_s].nil?; m}
    end

    # Provides access to categories sub-hash.  If available
    #
    # @example
    #   espn = EspnRb::Headline
    #   espn.nba.first.athletes
    # #=> ["Johnny B", "Freddie Flintstone", "Etc"]
    def athletes
      return collect_category(:description)
    end

    # Provides access to categories sub-hash.  If available
    #
    # @example
    #   espn = EspnRb::Headline
    #   espn.nba.first.leagues
    # #=> ["46"]
    def leagues
      return collect_category(:leagueId)
    end

    # Provides access to categories sub-hash.  If available
    #
    # @example
    #   espn = EspnRb::Headline
    #   espn.nba.first.athlete_ids
    # #=> ["123", "132", "123"]
    def athlete_ids
      return collect_category(:athleteId)
    end

    def categories
      @headline["categories"]
    end
  end
end