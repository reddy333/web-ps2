require 'nokogiri'
require 'rubygems'
require 'open-uri'
class BasicsController < ApplicationController
  def quotations
    if params[:quotation]
      @quotation = Quotation.new(basic_params)
      if @quotation.save
        flash[:notice] = 'Quotation was successfully created.'
        @quotation = Quotation.new

      end
    else
      @quotation = Quotation.new
    end
    if params[:sort_by] == "date"
      @quotations = Quotation.order(:created_at)
    else
      @quotations = Quotation.order(:category)
    end

    @quotations = Quotation.all
    respond_to do |format|
      format.html
      format.json {render json: @quotations }
      format.xml { render xml: @quotations }
    end

  end
  def basic_params
    if params[:category] != 'new'
      params.require(:quotation).permit(:author_name, :category, :quote )
    else if param[:category] == 'new'
           params.require(:quotation).permit(:author_name, :new_field, :quote )
         end
    end
  end
  def fetch

    xml = open(params["qxml"])
    doc = Nokogiri::XML(xml)
    doc.css("quotation").each do |node|
      children = node.children

      @quotation = Quotation.create(
                 :author_name => children.css('author_name').inner_text,
                 :category => children.css('category').inner_text,
                 :quote => children.css('quote').inner_text
    )
    end
    @quotation.save
    redirect_to basics_quotations_path
  end
end
