ActionController::Base.before_filter do |controller|
  controller.instance_eval {
    render :nothing => true unless params[:email].blank?
  }
end

class ActionView::Helpers::FormBuilder
  def honeypot
    %{
      <div class="attack_of_the_titans">
        #{@template.label_tag(:email, "Don't fill in this field")}
        #{@template.text_field_tag(:email)}
      </div>
    }
  end
end