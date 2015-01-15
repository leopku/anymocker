Anymocker::Admin.controllers :apis do
  get :index do
    @title = "Apis"
    @apis = Api.all
    render 'apis/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'api')
    @api = Api.new
    render 'apis/new'
  end

  post :create do
    @api = Api.new(params[:api])
    if @api.save
      @title = pat(:create_title, :model => "api #{@api.id}")
      flash[:success] = pat(:create_success, :model => 'Api')
      params[:save_and_continue] ? redirect(url(:apis, :index)) : redirect(url(:apis, :edit, :id => @api.id))
    else
      @title = pat(:create_title, :model => 'api')
      flash.now[:error] = pat(:create_error, :model => 'api')
      render 'apis/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "api #{params[:id]}")
    @vendors = Vendor.all
    @api = Api.find(params[:id])
    if @api
      render 'apis/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'api', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "api #{params[:id]}")
    @api = Api.find(params[:id])
    if @api
      if @api.update_attributes(params[:api])
        flash[:success] = pat(:update_success, :model => 'Api', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:apis, :index)) :
          redirect(url(:apis, :edit, :id => @api.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'api')
        render 'apis/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'api', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Apis"
    api = Api.find(params[:id])
    if api
      if api.destroy
        flash[:success] = pat(:delete_success, :model => 'Api', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'api')
      end
      redirect url(:apis, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'api', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Apis"
    unless params[:api_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'api')
      redirect(url(:apis, :index))
    end
    ids = params[:api_ids].split(',').map(&:strip)
    apis = Api.find(ids)

    if Api.destroy apis

      flash[:success] = pat(:destroy_many_success, :model => 'Apis', :ids => "#{ids.to_sentence}")
    end
    redirect url(:apis, :index)
  end
end
