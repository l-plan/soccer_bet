class Message < ApplicationRecord

	enum :subject, {latest: 1, input: 2}


	belongs_to :participant
end
