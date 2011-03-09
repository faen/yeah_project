class FeaturesController < ApplicationController
  include StructuralItem::Controller
  def new
    @feature = Feature.new
  end

  def create
    @feature = @featurable.features.build[params['feature']]
    if(@featurable.save)
      redirect_to @redirect_to_parent_scope_path
    else
      render 'edit'
    end
  end

  def show
    @feature = Feature.find_by_id(params[:id])
  end

  def edit
    @feature = Feature.find_by_id(params[:id])
  end

  def update
    @feature = Feature.find_by_id(params[:id])
    if(@feature.update_attributes[params[:feature]])
      redirect_to @redirect_to_parent_scope_path
    else
      render 'edit'
    end
  end

  def destroy
    @feature = Feature.find_by_id(params[:id])
    @feature.destroy
    redirect_to @redirect_to_parent_scope_path
  end
  
  private
    def find_featurable
      @featurable = get_polymorhic_parent_from_params
      featurable_class_name = @featurable.class.name.underscore
      featurable_path_token = "#{featurable_class_name}_path"
      target = @featurable
      parent = current_user
      featurable_path_token = "#{parent.class.name.underscore}_#{featurable_path_token}"
      @redirect_to_parent_scope_path = send(featurable_path_token, parent, target)
    end
end