module Admin
    class ProductsController < Admin::BaseController
      before_action :set_product, only: [:edit, :update, :destroy]
  
      def index
        @products = Product.all.includes(:categories).page(params[:page])
      end
  
      def new
        @product = Product.new
      end
  
      def create
        @product = Product.new(product_params)
        if @product.save
          process_categories
          redirect_to admin_products_path, notice: 'Product created'
        else
          render :new
        end
      end
  
      def edit
      end
  
      def update
        if @product.update(product_params)
          process_categories
          redirect_to admin_products_path, notice: 'Product updated'
        else
          render :edit
        end
      end
  
      def destroy
        @product.destroy
        redirect_to admin_products_path, notice: 'Product deleted'
      end
  
      private
      
      def process_categories
        if params[:category_ids]
          @product.categories = Category.where(id: params[:category_ids])
        end
      end
      
      # ... other private methods
    end
  end