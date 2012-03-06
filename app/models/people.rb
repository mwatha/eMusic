class People < ActiveRecord::Base
  set_table_name :people
  set_primary_key :people_id

  def name
    given_name = self.first_name
    family_name = self.last_name
    return "#{given_name} #{family_name}"
  end

  def email
    PeopleIdentifier.find(:first,:order => "date_created DESC",
    :conditions =>["people_id = ? AND identifier_type = ?", self.id,
    PeopleIdentifierType.find_by_name("Email").id]).identifier rescue nil
  end

end
