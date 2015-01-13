Anymocker::Admin.controllers :vendors do
  get :index do
    @title = "Vendors"
    @vendors = Vendor.all
    render 'vendors/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'vendor')
    @vendor = Vendor.new
    render 'vendors/new'
  end

  post :create do
    @vendor = Vendor.new(params[:vendor])
    if @vendor.save
      @title = pat(:create_title, :model => "vendor #{@vendor.id}")
      flash[:success] = pat(:create_success, :model => 'Vendor')
      params[:save_and_continue] ? redirect(url(:vendors, :index)) : redirect(url(:vendors, :edit, :id => @vendor.id))
    else
      @title = pat(:create_title, :model => 'vendor')
      flash.now[:error] = pat(:create_error, :model => 'vendor')
      render 'vendors/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "vendor #{params[:id]}")
    @vendor = Vendor.find(params[:id])
    if @vendor
      render 'vendors/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'vendor', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "vendor #{params[:id]}")
    @vendor = Vendor.find(params[:id])
    if @vendor
      if @vendor.update_attributes(params[:vendor])
        flash[:success] = pat(:update_success, :model => 'Vendor', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:vendors, :index)) :
          redirect(url(:vendors, :edit, :id => @vendor.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'vendor')
        render 'vendors/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'vendor', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Vendors"
    vendor = Vendor.find(params[:id])
    if vendor
      if vendor.destroy
        flash[:success] = pat(:delete_success, :model => 'Vendor', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'vendor')
      end
      redirect url(:vendors, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'vendor', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Vendors"
    unless params[:vendor_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'vendor')
      redirect(url(:vendors, :index))
    end
    ids = params[:vendor_ids].split(',').map(&:strip)
    vendors = Vendor.find(ids)
    
    if Vendor.destroy vendors
    
      flash[:success] = pat(:destroy_many_success, :model => 'Vendors', :ids => "#{ids.to_sentence}")
    end
    redirect url(:vendors, :index)
  end
end
