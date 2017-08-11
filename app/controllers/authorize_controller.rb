class AuthorizeController < ApplicationController

    def self.authorize(request)
		@tokenstr = request.headers['Authorization']
		@token = Token.find_by token: @tokenstr

		if @token == nil
			return nil
		end

		if not @token.is_valid?
			@token.destroy
			return nil
		end

		return @token.user
	end

    def self.check_access(user, access)
        if user != nil 
			return user.has_access?(access)
		end 
		return false
    end
end
