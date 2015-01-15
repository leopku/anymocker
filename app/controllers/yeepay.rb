Anymocker::App.controllers :yeepay do

  before do
    @vendor = Vendor.where(name: 'yeepay',version: params[:version]).first
    @api = @vendor.apis.where(name: params[:name] || params[:service]).first
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

  before :direct_access do
    # @service =
  end

  post :gateway, map: '/yeepay/:version/member/bha/:name' do
    render :gateway
  end

  post :direct_access, map: '/yeepay/:version/member/bhaexter/bhaController' do
    @output1.to_s
  end

end
