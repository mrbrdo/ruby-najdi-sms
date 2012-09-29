require 'mechanize'
require 'json'
class NajdiSms
  def initialize(username, password)
    login(username, password)
  end

  def login(username, password)
    agent.get("http://www.najdi.si/auth/login.jsp", :lg => 0, :target_url => "http://www.najdi.si/index.jsp")
    r = agent.post("https://id.najdi.si/j_spring_security_check",
      {:j_username => username, :j_password => password}, {"Referer" => "https://id.najdi.si/login"})
  end

  def send_sms(number, message)
    number.gsub!(/[^\d]/, "")
    number.gsub!(/\A0/, "")
    number =~ /(\d{2})(\d{3})(\d{3})/
    area, num1, num2 = $1, $2, $3

    params = {
      "sms_action" => 4,
      "sms_so_l_" => "#{num1} #{num2}",
      "sms_so_ac_" => area,
      "myContacts" => "",
      "sms_message_" => message
    }
    r = agent.get("http://www.najdi.si/sms/smsController.jsp", params, "http://www.najdi.si/", "X-Requested-With" => "XMLHttpRequest", "X-Prototype-Version" => "1.6.0.3")
    r = JSON::parse(r.body)
    if r["msg_left"] != nil
      r["msg_left"]
    else
      false
    end
  end

  def self.send_sms(username, password, number, message)
    self.new(username, password).send_sms(number, message)
  end

private
  def agent
    @agent ||= Mechanize.new do |agent|
      agent.user_agent_alias = 'Mac Safari'
    end
  end
end
