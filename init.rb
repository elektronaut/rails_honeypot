module Honeypot
  class << self; attr_accessor :form_field; end
  self.form_field ||= :email
end

ActionController::Base.before_filter do |controller|
  controller.instance_eval {
    render :nothing => true unless params[Honeypot.form_field].blank?
  }
end

class ActionView::Helpers::FormBuilder
  def honeypot
    %{
      <div class="attack_of_the_titans">
        #{@template.label_tag(Honeypot.form_field, "Don't fill in this field")}
        #{@template.text_field_tag(Honeypot.form_field)}
      </div>
    }
  end
end