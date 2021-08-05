class CovidSymptom < ApplicationRecord
    enum symptom: %i[cough cold fever others]
end
