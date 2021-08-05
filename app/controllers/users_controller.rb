class UsersController < ApplicationController
    def register_user
        params = register_user_params
        unless validate_register_user_params
            error_response("required params are missing")
            return
        end
        user = User.where(phone_number: params[:phone_number])
        if user.present?
            error_response('Phone number is already registered')
            return
        end
        user = User.new
        user.phone_number = params[:phone_number]
        if user.save
            user.update(name: params[:name], pincode: params[:pincode], user_type: params[:user_type])
        else
            error_response(user.errors)
            return
        end
        render json: {userId: user.id}
    end

    def perform_self_assessment
        params = self_assessment_parmas
        unless validate_self_assessment_parmas
            error_response("required params are missing")
            return
        end
        user = User.where(id: params[:user])
        
        unless user.present?
            error_response('Given user is not registered')
            return
        end
        symptoms = params[:symptom]
        user = params[:user]
        tracker_id = CovidTrackerDetail.create(user: user, travel_history: params[:travel_history],
            contact_with_covid_patient: params[:contact_with_patient])
        count = 0
        symptoms.each do |s|
            CovidSymptom.create(covid_tracker_detail_id: tracker_id, symptom: s)
            count = count + 1
        end
        risk_percent = RiskCalculationDetail.where(travel_history: params[:travel_history], 
            contact_with_covid_patient: params[:contact_with_patient]).where("min_symptom_count >= ? AND max_symptom_count <= ?", count, count).first.risk_percent
        render json: {riskPercentage: risk_percent}
    end

    def register_user_params
        params.permit(:name, :phone_number, :pincode, :user_type)
    end

    def validate_register_user_params
        required = [:name, :phone_number, :pincode, :user_type]
        return required.all? {|k| params.has_key? k}
    end

    def self_assessment_parmas
        params.permit(:user, :travel_history, :contact_with_patient, :symptom => [])
    end

    def validate_self_assessment_parmas
        required = [:user, :travel_history, :contact_with_patient, :symptom]
        return required.all? {|k| params.has_key? k}
    end

    def error_response(msg)
        render json: {msg: msg, status: "error"}
    end
end
