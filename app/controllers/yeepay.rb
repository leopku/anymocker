Anymocker::App.controllers :yeepay do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :gateway, map: '/yeepay/:version/member/bha/:name' do
    @vendor = Vendor.where(name: 'yeepay',version: params[:version]).first
    @api = @vendor.apis.where(name: 'toRecharge').first
    render :gateway
  end

  post :direct_access do

  end

end
