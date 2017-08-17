ActiveAdmin.register CouncillorContribution do
  actions :index, :show

  index do
    column :contributor
    column :created_at
    column :authority

    actions
  end

  show title: :created_at do
    h3 "Contributor"
    table_for resource.contributor, class: "index_table" do
      column :name
      column :email
    end
    attributes_table do
      row :authority
    end

    h3 "Suggested Councillors"
    table_for resource.suggested_councillors, class: "index_table" do
      column :name
      column :email
    end
  end
end
