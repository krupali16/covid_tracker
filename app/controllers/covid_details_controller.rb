class CovidDetailsController < ApplicationController
    def update_covid_result
        params = covid_result_params
        unless validate_covid_result_params
            error_response("required params are missing")
            return
        end
        admin = User.where(id: params[:admin], user_type: 'admin')
        unless admin.present?
            error_response('Admin does not exist')
            return
        end
        user = User.where(id: params[:user], user_type: 'patient').first
        unless user.present?
            error_response('Patient does not exist')
            return
        end
       
        user_result = UserResult.where(user_id: user.id).first
        zone = Zone.where(pincode: user.pincode).first
        covid_count = zone.covid_patient_count
        result = params[:result]
        if user_result.present?
            user_result.update(has_covid: result)
        else
            UserResult.create(user_id: user.id, has_covid: result, zone_id: zone.id)
        end
        count = result ? (covid_count + 1) : (covid_count - 1)
        zone.update(covid_patient_count: count)
        render json: {updated: true}
    end

    def covid_result_params
        params.permit(:user, :admin, :result)
    end

    def validate_covid_result_params
        required = [:user, :admin, :result]
        return required.all? {|k| params.has_key? k}
    end

    def error_response(msg)
        render json: {msg: msg, status: "error"}
    end
end
