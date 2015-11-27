class Event
  class << self
    def generate_id
      id = random_id
      while Profile.where(event_id: id).exists?
        id = random_id
      end
      id
    end

    def random_id
      (0..5).to_a.map{|i| rand(0..9).to_s}.join ''
    end
  end
end
