require 'digest/md5'

class PanelController < ApplicationController
  REALM = 'line_control_panel'
  before_action :digest_auth

  def index
  end

  private

  def digest_auth
    authenticate_or_request_with_http_digest(REALM) do |user|
      return nil if user != ENV['ADMIN_USER']
      Digest::MD5.hexdigest([user, REALM, ENV['ADMIN_PASS']].join(':'))
    end
  end
end
