require 'csv'
class Contact < ApplicationRecord
  before_create :email_check

  def email_check
    bool = nil
    begin
      bool = EmailVerifier.check(email)
    rescue EmailVerifier::NoMailServerException
      bool = false
    rescue EmailVerifier::NoMailServerException
      bool = false
    rescue
      bool = nil
    end
    self.is_valid = bool
  end

  def self.to_csv(path=nil)
    _csv = CSV.generate do |csv|
      csv << column_names
      all.each do |result|
        csv << result.attributes.values_at(*column_names)
      end
    end
    if path
      File.open(path, 'w') do |f|
        f.write(_csv)
      end
    end
    _csv
  end

end
