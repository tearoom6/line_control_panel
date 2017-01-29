require 'digest/md5'

class PanelController < ApplicationController
  include LineApi

  REALM = 'line_control_panel'
  TALK_COUNT_PER_PAGE = 25

  before_action :digest_auth

  def index
    @talks = Talk.active.limit(TALK_COUNT_PER_PAGE)
  end

  def talk
    @talk = Talk.find(params[:talk_id])
  end

  private

  def digest_auth
    authenticate_or_request_with_http_digest(REALM) do |user|
      return nil if user != ENV['ADMIN_USER']
      Digest::MD5.hexdigest([user, REALM, ENV['ADMIN_PASS']].join(':'))
    end
  end
end
