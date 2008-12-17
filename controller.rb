class MainController < Ramaze::Controller
	layout '/layout'
	def index
		@items = WishList.dup
	end

	def new
		id = request['id'] ? request['id'].to_i : WishList.keys.max { |a, b| a.to_i <=> b.to_i } + 1
		WishList[id] = {:item => request['item'], :user => session[:nick], :rating => request['rating'].to_i}
		redirect Rs(:/)
	end

	def login
		if request['login'] or session[:nick]
			session[:nick] = request['login'].downcase
			redirect Rs()
		end
	end

	def logout
		session.delete :nick
		flash[:good] = "Logged out"
		redirect Rs()
	end

	def delete(id)
		@item = WishList[id.to_i]
		WishList.delete id.to_i
		flash[:error] = "Deleted '#{@item[:item]}'"
		redirect Rs()
	end

	def add
		# Make sure the user is logged in
		redirect Rs(:login) unless session[:nick]
	end

	def user(nick)
		@items = WishList.select { |k, v| v[:user] == nick }
		flash[:info] = "You're only looking at the wishlist items for #{nick.capitalize}. Click #{A('here', :href => Rs())} to return."
		render_template "index"
	end

	def edit(id)
		@id = id
		@item = WishList[id.to_i]
	end
end
