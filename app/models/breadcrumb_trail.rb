class BreadcrumbTrail < Croutons::BreadcrumbTrail
  def home_index
    breadcrumb('Home', root_path)
  end

  def projects_index
    home_index
    breadcrumb('Projects', projects_path(objects['user'].id))
  end

  def contributions_index
    projects_index
    breadcrumb('Contributions')
  end
end
