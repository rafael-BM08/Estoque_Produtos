class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  def add_stock
  product = Product.find(params[:id])
  quantity = params[:quantity].to_i

  if quantity <= 0
    render json: { error: "Quantidade inválida" }, status: :unprocessable_entity
    return
  end

  StockMovement.create!(
    product: product,
    user: @current_user, # Usuário logado
    movement_type: "entrada",
    quantity: quantity
  )

  product.update!(quantidade: product.quantidade + quantity)

  render json: product
  end


  def remove_stock
  product = Product.find(params[:id])
  quantity = params[:quantity].to_i

  if quantity <= 0 || quantity > product.quantidade
    render json: { error: "Quantidade inválida" }, status: :unprocessable_entity
    return
  end

  StockMovement.create!(
    product: product,
    user: @current_user,
    movement_type: "saida",
    quantity: quantity
  )

  product.update!(quantidade: product.quantidade - quantity)

  render json: product
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:price, :quantity, :description, :name)
    end
end
