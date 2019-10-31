class User::Activate < Trailblazer::Operation
  step :model!
  fail :user_does_not_exist!
  step :activate_user!
  fail :user_is_active_already!
  step :persist!

  def model!(options, params:, **)
    options['model'] = User.find_by(activation_token: params[:activation_token])
  end

  def user_does_not_exist!(options, params:, **)
    options['result.model'] = 'Wrong activation token ' +
                              "#{params[:activation_token]}!"
  end

  def activate_user!(options, model:, **)
    options['model'].active = true unless model.active
  end

  def user_is_active_already!(options, params:, **)
    options['result.model'] ||= 'User with activation token ' +
                              "#{params[:activation_token]} is already active!"
  end

  def persist!(options, **)
    options['model'].save!
  end
end
