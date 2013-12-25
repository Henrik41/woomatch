class PhotosController < ApplicationController

  require 'flickraw'

  def index

  end

  def show
  FlickRaw.api_key='de0e2be23d8523a00e6b8e68765bac24'
  FlickRaw.shared_secret='33d52c3d446a2db4'
  url=params[:url]
  
    begin
  info = flickr.photos.search(:sort => 'relevance', :text =>url.split('/').last)

  @embed_photo = [FlickRaw.url_b(info[0]),FlickRaw.url_b(info[1]),FlickRaw.url_b(info[2]),FlickRaw.url_b(info[3]),FlickRaw.url_b(info[4]),FlickRaw.url_b(info[5]),FlickRaw.url_b(info[6]),FlickRaw.url_b(info[7])]
rescue
  
  @embed_photo = ['http://placekitten.com/180/200', 'http://placekitten.com/180/200' ]
end
  respond_to do |format|

    format.js { }
  end
  end




  
end
