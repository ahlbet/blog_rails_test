module Posts
  class CreateService

    # Create a constructor, with attr readers/writers for variables you'll need
    attr_reader :params, :post
    attr_accessor :errors

    def initialize(params)
      @params = params
      @post = post
      @errors = []
    end

    def hash_into_array(hash, target_key)
      hash.values.map { |h| h[target_key] }
    end

    def confirm_or_create(catgory_names, post)
      catgory_names.each do |category|
        category_record = Category.find_or_create_by(name: category)
        if category_record.errors.empty?
          post.categories << category_record
        else
          @errors = category_record.errors
        end
      end
    end

    def call
      # In call method (here) create a post without worrying about categories
      create_post
      category_hash = @params[:categories_attributes]
      parsed_category_hash = Hash(category_hash)
      category_array = hash_into_array(parsed_category_hash, :name)
      result = confirm_or_create(category_array, @new_post)

      if result
        @new_post
      else
        false
      end

      # Run some logic against nested category attributes to create a categories for the post
      # Run some logic to find a category by the passed in name from params
      #    If that category exists, create association between a post and the category
      #    Else - create a category and associate with the post
      # Based on result of DB queries, should return true or false
      # If insertions failed, populate an errors array
    end

    private
  
      def create_post
        @new_post = Post.new(params.except(:categories_attributes))
        if @new_post.save
        else
          @errors = @new_post.errors
        end
      end

  end

end