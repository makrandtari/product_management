class Api::V1::ProductsController < ApplicationController

    def index
        @products = Product.all
        render json: @products
    end

    def show
        begin
            @product = Product.find(params[:id])
                render json: @product

                rescue ActiveRecord::RecordNotFound
                    render json: {"error": "Product not found"}, status: :not_found
        end

    end

    def create
        @product= Product.new(product_params)
            if @product.save
                render json: @product, status: :created
            else
                render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
            end
    end
    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            render json: @product, status: :ok
        else
            render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
         render json: {message: "product deleted sucessfully"}, status: :ok
    end

    private

    def product_params
    params.require(:product).permit(:name, :price, :description)
    end
end
