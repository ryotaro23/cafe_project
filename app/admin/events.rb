ActiveAdmin.register Event do
  permit_params :name, :style, :abv, :ibu, :description, :image

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :time_id
      f.input :recommend_menu
      f.input :place
      f.input :max_num
      f.input :image, as: :file
      f.actions
    end
  end

  show do
    attributes_table do
      row :name
      row :time_id
      row :recommend_menu
      row :place
      row :max_num
      row :image do |ad|
        image_tag url_for(ad.image)
      end
      active_admin_comments
    end
  end
end