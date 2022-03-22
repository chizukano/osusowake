module PageHelper
  def non_searchable_page?
    action_name == "home" || action_name == "new" || action_name == "show"
  end
end
