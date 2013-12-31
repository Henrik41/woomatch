class PhotosController < ApplicationController

  require 'flickraw'

  def index

  end

  def show
  FlickRaw.api_key='de0e2be23d8523a00e6b8e68765bac24'
  FlickRaw.shared_secret='33d52c3d446a2db4'
  url=params[:url]
  
    begin
  args = {}
  args[:sort] = 'relevance'
  args[:text] = "#{url.split('/').last}"
  
  info = flickr.photos.search args
  @embed_photo = [FlickRaw.url(info[0]),FlickRaw.url(info[1]),FlickRaw.url(info[2]),FlickRaw.url(info[3]),FlickRaw.url(info[4]),FlickRaw.url(info[5]),FlickRaw.url(info[6]),FlickRaw.url(info[7])]

rescue
  @embed_photo = ['http://placekitten.com/180/200', 'http://placekitten.com/180/200' ]
end
  respond_to do |format|
    format.js { }
  end
  end


 def show2

 @picture = params[:picture]
 
 
 end

  
end
