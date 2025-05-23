class CreatorEarningsSerializer
  def self.serialize(creator_earnings)
    creator_earnings.map do |earnings|
      {
        creator_id: earnings.creator_id,
        total_earnings: earnings.total_earnings.to_f
      }
    end
  end
end 