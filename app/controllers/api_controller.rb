class ApiController < ApplicationController
  before_action :set_document
  before_action :set_navigation

  def index
    render layout: 'application'
  end

  def show
    # Read document
    document = File.read("#{Rails.root}/_api/#{@document}.md")

    # Parse frontmatter
    @frontmatter = YAML.load(document)

    @content = MarkdownPipeline.new.call(document)

    render layout: 'api'
  end

  private

  def set_navigation
    @navigation = :api
    @side_navigation = "api/#{@document}"
  end

  def set_product
    @product = params[:product]
  end

  def set_document
    @document = params[:document]
  end
end