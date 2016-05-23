class RankingController < ApplicationController

  def have
  @haveMap = {}
  
  Ownership.all.each {|item|
      if item.type == "Have"
        if @haveMap[item.item_id]!= nil
          @haveMap[item.item_id] = @haveMap[item.item_id] + 1
        else
          @haveMap[item.item_id] = 1
        end
      end
      }
      @rank = p @haveMap.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
      #binding.pry
  end
  
  def want
  @haveMap = {}
  Ownership.all.each {|item|
      if item.type == "Want"
        if @haveMap[item.item_id]!= nil
          @haveMap[item.item_id] = @haveMap[item.item_id] + 1
        else
          @haveMap[item.item_id] = 1
        end
      end
      }
      @rank = p @haveMap.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
      #binding.pry
  end
end
