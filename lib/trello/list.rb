# Ruby wrapper around the Trello API
# Copyright (c) 2012, Jeremy Tregunna
# Use and distribution terms may be found in the file LICENSE included in this distribution.

module Trello
  class List < BasicData
    class << self
      def find(id)
        super(:lists, id)
      end
    end

    # Fields

    def id
      fields['id']
    end

    def name
      fields['name']
    end

    def closed
      fields['closed']
    end

    # Links to other data structures

    def actions
      response = Client.query("/1/lists/#{id}/actions")
      JSON.parse(response.read_body).map do |action_fields|
        Action.new(action_fields)
      end
    end

    def board
      Board.find(fields['idBoard'])
    end

    def cards
      fields['cards'].map do |c|
        Card.new(c)
      end
    end
  end
end