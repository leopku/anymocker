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

  # def prepare_api
  #   @vendor = Vendor.where(name: 'yeepay',version: params[:version]).first
  #   @api = @vendor.apis.where(name: params[:name]).first
  #   @input = @api.input
  #   @output1 = @api.output1
  #   @output2 = @api.output2
  # end

  # get :gateway, map: '/yeepay/:version/member/bha/:name' do
  #   render :gateway
  # end
  before do
    @vendor = Vendor.where(name: 'yeepay',version: params[:version]).first
    @api = @vendor.apis.where(name: params[:name]).first
    @input = Nokogiri::Slop(params[:req] || @api.input)
    @output1 = Nokogiri::Slop(@api.output1)
    @output2 = Nokogiri::Slop(@api.output2)

    @platform_no = @input.request.attr('platformNo')
    @output1.response['platformNo'] = @platform_no
    @output2.notify['platformNo'] = @platform_no
  # end

  # before :gateway do

    ['callback_url', 'notify_url'].each do |url|
      begin
        instance_variable_set("@#{url}", @input.request.send(url.camelize(:lower)).content)
      rescue
        nil
      end
    end

    ['request_no', 'platform_user_no'].each do |node|
      begin
        @output1.response.send(node.camelize(:lower)).content = @input.request.send(node.camelize(:lower)).content
      rescue
        nil
      end

      begin
        @output2.notify.send(node.camelize(:lower)).content = @input.request.send(node.camelize(:lower)).content
      rescue
        nil
      end

    end
  end

  post :gateway, map: '/yeepay/:version/member/bha/:name' do
    render :gateway
  end

  post :direct_access do

  end

end
