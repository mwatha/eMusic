class People < ActiveRecord::Base
  set_table_name :people
  set_primary_key :people_id

  def name
    given_name = self.first_name
    family_name = self.last_name
    return "#{given_name.humanize} #{family_name.humanize}"
  end

  def email
    PeopleIdentifier.find(:first,:order => "date_created DESC",
    :conditions =>["people_id = ? AND identifier_type = ?", self.id,
    PeopleIdentifierType.find_by_name("Email").id]).identifier rescue nil
  end

  def address
    PeopleIdentifier.find(:first,:order => "date_created DESC",
    :conditions =>["people_id = ? AND identifier_type = ?", self.id,
    PeopleIdentifierType.find_by_name("Mailing address").id]).identifier rescue nil
  end

  def phone_number
    PeopleIdentifier.find(:first,:order => "date_created DESC",
    :conditions =>["people_id = ? AND identifier_type = ?", self.id,
    PeopleIdentifierType.find_by_name("Phone number").id]).identifier rescue nil
  end

  def zip_code
    PeopleIdentifier.find(:first,:order => "date_created DESC",
    :conditions =>["people_id = ? AND identifier_type = ?", self.id,
    PeopleIdentifierType.find_by_name("Zip code").id]).identifier rescue nil
  end

end
