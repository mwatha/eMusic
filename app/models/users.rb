require 'digest/sha1'
require 'digest/sha2'


class Users < ActiveRecord::Base
  set_table_name :users
  set_primary_key :ser_id

  before_save :set_password, :before_create

  cattr_accessor :current_user                                                  
  attr_accessor :plain_password

  belongs_to :people, :foreign_key => :people_id, :conditions => {:retired => 0}

  def try_to_login                                                              
    Users.authenticate(self.username,self.password)                              
  end                                                                           
                                                                                
  def set_password                                                              
    # We expect that the default OpenMRS interface is used to create users      
    self.password = encrypt(self.plain_password, self.salt) if self.plain_password
  end                                                                           
                                                                                
  def self.authenticate(login, password)                                        
    u = find :first, :conditions => {:username => login}                        
    u && u.authenticated?(password) ? u : nil                                   
  end                                                                           
                                                                                
  def authenticated?(plain)                                                     
    encrypt(plain, salt) == password || Digest::SHA1.hexdigest("#{plain}#{salt}") == password || Digest::SHA512.hexdigest("#{plain}#{salt}") ==        password
  end

  def encrypt(plain, salt)                                                      
    encoding = ""                                                               
    digest = Digest::SHA1.digest("#{plain}#{salt}")                             
    (0..digest.size-1).each{|i| encoding << digest[i].to_s(16) }                
    encoding                                                                    
  end

  def before_create                                                            
    super                                                                       
    self.salt = User.random_string(10) if !self.salt?                           
    self.password = User.encrypt(self.password,self.salt)                       
  end

   def self.random_string(len)                                                  
    #generat a random password consisting of strings and digits                 
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a                 
    newpass = ""                                                                
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }                    
    return newpass                                                              
  end                                                                           
                                                                                
  def self.encrypt(password,salt)                                               
    Digest::SHA1.hexdigest(password+salt)                                       
  end


end
