RailsAdmin.config do |config|

  ### Popular gems integration

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      username == ENV['RAILS_ADMIN_USERNAME'] && password == ENV['RAILS_ADMIN_PASSWORD']
    end
  end

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Profile' do
    list do
      field :first_name
      field :driver
      field :event_title
      field :event_id do
        label "Event ID"
      end
      field :location
      field :profiles_contacted do
        label "Contacted"
        pretty_value do
          if value.present?
            "#{value.length} other#{'s' if value.length != 1}"
          else
            "0 others"
          end
        end
      end
    end

    edit do
      exclude_fields :profiles_contacted
    end
  end
end
