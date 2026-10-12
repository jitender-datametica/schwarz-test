/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SURVEY_SUBMISSION_1
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:45:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_survey_submission_1 (
surv_submission_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier of the filled survey. One ID per each time a customer takes a survey and submits it. (NK  - Survey Platform CD + Survey Submission NR)'),
question_cd STRING(50) NOT NULL OPTIONS(description='The unique identifier for question within the survey'),
answer_nr STRING(20) NOT NULL OPTIONS(description='The unique identifier for answer'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
surv_platform_cd STRING(20)
OPTIONS(description='Code identifiying the platform (system) used for the surveys (ex Medallia, Netigate ..)'),
surv_submission_nr STRING(50)
OPTIONS(description='Unique identifier of the survey submission within the Survey Platform'),
surv_type_cd STRING(5) OPTIONS(description='Type of the survey (NPS, ..)'),
surv_method_cd STRING(5)
OPTIONS(description='Code idenfifying the method by which the survey was sent to cusotmer ( online after checkout, by email after delivery...)'),
surv_customer_nr STRING(20)
OPTIONS(description='The unique identifier for customer ( not the same as Lidl customer number)'),
surv_form_sid BIGNUMERIC
OPTIONS(description='Unique Indetifier of the  - Surrogate Key based on the following NK (Survey System CD/Survey Platform Name, Survey NR in the survey system, Survey Type CD)'),
surv_form_nr STRING(20) OPTIONS(description='ID of the survey form in the Survey Platform/System'),
surv_form_name STRING(100) OPTIONS(description='Name of the survey form'),
web_browser_name STRING(100) OPTIONS(description='Name of the web browser used during the activity'),
web_device_type_name STRING(100)
OPTIONS(description='Summarized Types of device used for web browsing (Desktop, Mobile Phone, Tablet, Other)'),
country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
cust_gender_cd STRING(20) OPTIONS(description='The code for a gender of a customer ( M - Male , F - Female)'),
cust_loyalty_classification_cd STRING(5)
OPTIONS(description='Code identifying customer purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)'),
age_group_lower_val BIGNUMERIC OPTIONS(description='The lower bound of the age category in which the customer falls in'),
age_group_upper_val BIGNUMERIC OPTIONS(description='The upper bound of the age category in which the customer falls in'),
age_group_txt STRING(30) OPTIONS(description='Contactenated upper and lower bound of age group'),
surv_start_tmsp TIMESTAMP OPTIONS(description='The date when the survey was started by a customer'),
surv_complete_tmsp TIMESTAMP
OPTIONS(description='The date when the survey was completed by a customer'),
answer_tmsp TIMESTAMP OPTIONS(description='The date when the survey was created by a customer'),
question_txt STRING(10000) OPTIONS(description='The text for question'),
answer_txt STRING(10000) OPTIONS(description='The text for the chosen answer'),
answer_val BIGNUMERIC OPTIONS(description='Numeric value of the chosen answer'),
answer_weight BIGNUMERIC OPTIONS(description='The weight of an answer'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (surv_submission_sid, question_cd, answer_nr) NOT ENFORCED
)
OPTIONS(description='A survey submissions where customers answers questions about experience of interacting with Lidl webshop or customer support . Provided by external providers ( like Netigate )');