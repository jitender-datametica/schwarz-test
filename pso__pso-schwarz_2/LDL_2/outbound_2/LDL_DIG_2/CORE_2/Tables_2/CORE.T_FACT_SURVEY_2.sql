CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_survey_2 (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
answerset_nr STRING(20) NOT NULL OPTIONS(description='The unique identifier for answerset'),
surv_nr STRING(20) NOT NULL OPTIONS(description='The unique identifier for survey'),
surv_customer_nr STRING(20) NOT NULL
OPTIONS(description='The unique identifier for customer ( not the same as Lidl customer number)'),
surv_type_cd STRING(5) NOT NULL OPTIONS(description='Type of the survey'),
surv_create_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The date when the survey was started by a customer'),
surv_complete_tmsp TIMESTAMP
OPTIONS(description='The date when the survey was completed by a customer'),
answer_create_tmsp TIMESTAMP
OPTIONS(description='The date when the survey was created by a customer'),
question_nr STRING(20) NOT NULL OPTIONS(description='The unique identifier for question'),
question_text STRING(10000) OPTIONS(description='The text for question'),
answer_nr STRING(20) NOT NULL OPTIONS(description='The unique identifier for answer'),
answer_text STRING(10000) OPTIONS(description='The text for the chosen answer'),
answer_val BIGNUMERIC(38,0) OPTIONS(description='Numeric value of the chosen answer'),
answer_weight BIGNUMERIC(38,0) OPTIONS(description='The weight of an answer'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (answerset_nr, surv_nr, surv_type_cd, question_nr, answer_nr) NOT ENFORCED
)
OPTIONS(description='A survey where customers answers questions about experience of interacting with Lidl webshop or customer support . Provided by external providers ( like Netigate )');