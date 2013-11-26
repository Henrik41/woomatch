class PhotosController < ApplicationController

  require 'flickraw'

  def index

  end

  def show
  FlickRaw.api_key='de0e2be23d8523a00e6b8e68765bac24'
  FlickRaw.shared_secret='33d52c3d446a2db4'
  url=params[:url]
  info = flickr.photos.search(:text =>url.split('/').last)
  @embed_photo = FlickRaw.url_b(info[0])
  end


  
end
