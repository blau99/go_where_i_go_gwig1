class RestaurantPhotosController < ApplicationController
  def index
    @restaurant_photos = RestaurantPhoto.all

    render("restaurant_photos/index.html.erb")
  end

  def show
    @restaurant_photo = RestaurantPhoto.find(params[:id])

    render("restaurant_photos/show.html.erb")
  end

  def new
    @restaurant_photo = RestaurantPhoto.new

    render("restaurant_photos/new.html.erb")
  end

  def create
    @restaurant_photo = RestaurantPhoto.new

    @restaurant_photo.restaurant_id = params[:restaurant_id]
    @restaurant_photo.user_id = params[:user_id]
    @restaurant_photo.caption = params[:caption]

    save_status = @restaurant_photo.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurant_photos/new", "/create_restaurant_photo"
        redirect_to("/restaurant_photos")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant photo created successfully.")
      end
    else
      render("restaurant_photos/new.html.erb")
    end
  end

  def edit
    @restaurant_photo = RestaurantPhoto.find(params[:id])

    render("restaurant_photos/edit.html.erb")
  end

  def update
    @restaurant_photo = RestaurantPhoto.find(params[:id])

    @restaurant_photo.restaurant_id = params[:restaurant_id]
    @restaurant_photo.user_id = params[:user_id]
    @restaurant_photo.caption = params[:caption]

    save_status = @restaurant_photo.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurant_photos/#{@restaurant_photo.id}/edit", "/update_restaurant_photo"
        redirect_to("/restaurant_photos/#{@restaurant_photo.id}", :notice => "Restaurant photo updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant photo updated successfully.")
      end
    else
      render("restaurant_photos/edit.html.erb")
    end
  end

  def destroy
    @restaurant_photo = RestaurantPhoto.find(params[:id])

    @restaurant_photo.destroy

    if URI(request.referer).path == "/restaurant_photos/#{@restaurant_photo.id}"
      redirect_to("/", :notice => "Restaurant photo deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Restaurant photo deleted.")
    end
  end
end