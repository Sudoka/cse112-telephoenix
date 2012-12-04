require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :reviews
  #make_flaggable :flag_once => true
  mount_uploader :image, ImageUploader
  make_flagger
  attr_accessible :username, :email, :password, :password_confirmation, :ip_address, :image
  attr_protected :id, :salt, :user_type
  attr_accessor :password, :password_confirmation, :current_password, :password_validator, :username_validator #determine whether validate password/username

  validates_length_of :username, :within => 5..40, :if => :should_validate_username?   
  validates_presence_of :username, :if => :should_validate_username?    
  validates_uniqueness_of :username, :if => :should_validate_username?    
  
  validates_length_of :password, :within => 5..40,  :if => :should_validate_password?   
  validates_presence_of :password, :password_confirmation, :salt, :if => :should_validate_password?   
  validates_confirmation_of :password, :if => :should_validate_password?   

  validates_presence_of :email
  validates_uniqueness_of :email      
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"

  def self.authenticate(username, pass)
    u=find(:first, :conditions=>["username = ?", username])
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt)==u.hashed_password
  end 

  def password=(pass)
    @password=pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def change_new_password
    new_pass = User.random_string(10)
    self.password = new_pass
    self.password_confirmation = new_pass
    self.save!
    #Notifications.deliver_forgot_password(self.email, self.username, new_pass)
    #debugger
    self.delay.send_password(self, new_pass)
  end
  
  def should_validate_password?   
      password_validator==true
  end

  def should_validate_username?
      username_validator==true
  end

  def change_password (current_password, new_password, new_password_confirmation)
     if user= User.authenticate(self.username, current_password)
        user.password = new_password
        user.password_confirmation = new_password_confirmation
        debugger
        return user.save
     else
        return false
     end

  end
  def send_password (user, password)
      UserMailer.send_password(user, password).deliver
  end
  ##
  def no_omniauth?
      self.provider.nil?
  end

  def self.from_omniauth(auth)
   
     user = where(auth.slice(:provider, :uid)).first
     if user.nil?
        user = find_by_email auth.info.email
        if user.nil?
           user = User.new
           user.provider = auth.provider
           user.uid = auth.uid      
           user.oauth_token = auth.credentials.token
           user.oauth_expires_at = Time.at(auth.credentials.expires_at)     
           user.username = auth.info.name     
           user.email = auth.info.email        
           user.web_page = auth.info.urls.Facebook
           user.location = auth.info.loation
           user.name = auth.info.name
           user.password_validator = false
           user.username_validator = false
           user.image = File.open ('app/assets/images/fb_avatar.jpg')
        
           user.save!
        end
     end
   
     return user
    
  end

  protected

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def self.setUser_type(usr)
  #  if rand(2) == 1
  #    usr.user_type = Moderator.to_s
  #  else
    usr.user_type = "Moderator"
  #  end
  end

  def comment_remind ( commenter)
      UserMailer.comment_review(self, commenter).deliver
  end
  def signup_confirmation
      UserMailer.signup_confirmation(self).deliver
  end
end
