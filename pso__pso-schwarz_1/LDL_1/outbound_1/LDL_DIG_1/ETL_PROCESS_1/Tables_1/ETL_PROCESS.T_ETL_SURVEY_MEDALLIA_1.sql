/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SURVEY_MEDALLIA_1
   GENERATED FROM POWERDESIGNER ON Freitag, 4. August 2023 14:38:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_survey_medallia_1 (
a_surveyid STRING(20) NOT NULL
OPTIONS(description='Unique idenfitier of the survey submission (generated during ETL process. Does not come from source)'),
surv_submission_sid BIGNUMERIC
OPTIONS(description='The unique identifier of the filled survey. One ID per each time a customer takes a survey and submits it. (NK  - Survey Platform CD + Survey Submission NR)'),
surv_form_sid BIGNUMERIC
OPTIONS(description='Unique Indetifier of the  - Surrogate Key based on the following NK (Survey System CD/Survey Platform Name, Survey NR in the survey system, Survey Type CD)'),
e_bp_digital_browser_name_auto STRING(100) OPTIONS(description='Name of the web browser used during the activity'),
e_bp_digital_country_code_auto STRING(20)
OPTIONS(description='Automatically detected code of the country_1 from which the survey is made (based on web session cookies, etc)'),
e_bp_digital_device_hardware_type_auto STRING(100)
OPTIONS(description='Automatically detected type of device used for web browsing - phone, pc, VR set,  (based on web session cookies, etc)'),
e_bp_digital_origin_type_auto STRING(250)
OPTIONS(description='Automatically detected attribute (not yet defined, not in CORE)'),
e_bp_digital_trigger_entity_type_auto STRING(250)
OPTIONS(description='Automatically detected attribute (not yet defined, not in CORE)'),
e_bp_digital_client_correlation_id_txt STRING(250)
OPTIONS(description='Automatically detected attribute ( could be ID used to link the survey to existin customer, but not yet defined, not in CORE)'),
e_bp_digital_form_id_txt STRING(250)
OPTIONS(description='Automatically detected attribute (not yet defined, not in CORE)'),
e_bp_digital_form_name_txt STRING(250) OPTIONS(description='Name of the survey form that is filled'),
e_bp_digital_ip_address_txt STRING(250) OPTIONS(description='Automatically detected IP address_1 of the web session'),
e_bp_digital_itm_survey_alt STRING(250) OPTIONS(description='Number (identifier) of the survey form'),
e_bp_digital_unit STRING(250)
OPTIONS(description='Automatically detected ID of the web app - could be used to map survey to webshop, as apps for different webshops have different codes'),
e_bp_digital_uuid_txt STRING(250)
OPTIONS(description='Unique identifier of the survey submission (coming from source system)'),
e_responsedate STRING(250) OPTIONS(description='Date when the cusotmer took the survey'),
e_schwarzit_digital_nps_channel_choice_new STRING(250)
OPTIONS(description='Automatically detected attribute (not yet defined, not in CORE)'),
e_survey_method STRING(250)
OPTIONS(description='Code idenfifying the method by which the survey was sent to cusotmer ( online after checkout, by email after delivery...)'),
k_bp_digital_url_query_string_auto STRING(250) OPTIONS(description='parameter part of the URL string'),
k_lidl_customer_type_auto STRING(250)
OPTIONS(description='Calculated field - customer classification type based on the answer of q_digital_orders_last_12_months'),
k_lidl_digital_device_hardware_type_auto STRING(250)
OPTIONS(description='Calculated field - summarized device type name (desktop, mobile ..) based on e_bp_digital_origin_type_auto'),
q_bp_digital_ease_task_scale5 STRING(250)
OPTIONS(description='code of the answer to survey question "How easy was it to complete your order?"'),
q_digital_age STRING(250) OPTIONS(description='code of the answer to survey question "Please enter your age"'),
q_md_9799_awareness_assortment STRING(250)
OPTIONS(description='code of the answer to survey question "According to your perception, which products can be ordered in the Lidl online shop"'),
q_digital_category STRING(250)
OPTIONS(description='code of the answer to survey question "In which product category did you last order?"'),
q_digital_delivery_appropriate_packaging STRING(250)
OPTIONS(description='code of the answer to survey question "packaging was appropriate - yes/no/cannot say"'),
q_digital_delivery_carrier STRING(250)
OPTIONS(description='code of the answer to survey question  "Delivery by shipping service prodiver went smoothly - yes/no/cannot say"'),
q_digital_delivery_defects STRING(250)
OPTIONS(description='code of the answer to survey question "products were delivered without defects - yes/no/cannot say"'),
q_digital_delivery_haulage STRING(250)
OPTIONS(description='code of the answer to survey question "Was your order delivered by a freight forwarder?  "'),
q_digital_delivery_information_status STRING(250)
OPTIONS(description='code of the answer to survey question "I was sufficiently informed about delivery status_1 - yes/no/cannot say"'),
q_digital_delivery_on_time STRING(250)
OPTIONS(description='code of the answer to survey question  "Was you last delivery on time"'),
q_digital_delivery_option STRING(250)
OPTIONS(description='code of the answer to survey question "Which delivery option did you choose for your last order in the Lidl online shop"'),
q_digital_delivery_problems_carrier STRING(250)
OPTIONS(description='code of the answer to survey question "What problems you had with delivery company/carrier  - select many"'),
q_digital_delivery_shipping_fees STRING(250)
OPTIONS(description='code of the answer to survey question "Shopping fees were reasonable - yes/no/ cannot say"'),
q_digital_delivery_time STRING(250)
OPTIONS(description='code of the answer to survey question "Was the expected delivery anounced time reasonable"'),
q_digital_gender STRING(250) OPTIONS(description='code of the answer to survey question Please select your gender"'),
q_digital_nps STRING(250)
OPTIONS(description='code of the answer to survey question "How likely are you to recommend the Lidl online shop to your friends or family"'),
q_digital_nps_reason_open_text_detractors STRING(10000)
OPTIONS(description='open form for comments if answer of q_digital_nps >=9 ( scale is 0-10)'),
q_digital_nps_reason_open_text_passives STRING(10000)
OPTIONS(description='open form for comments if answer of q_digital_nps in 7,8 ( scale is 0-10)'),
q_digital_nps_reason_open_text_promotors STRING(10000)
OPTIONS(description='open form for comments if answer of q_digital_nps <= 6 ( scale is 0-10)'),
q_digital_orders_last_12_months STRING(250)
OPTIONS(description='code of the answer to survey question "How often did you order in the Lidl-Onlineshop over the last 12 months?"'),
q_digital_order_satisfaction STRING(250)
OPTIONS(description='code of the answer to survey question "How satisfied were you with the ordering process in the Lidl online shop?"'),
q_digital_past_order_satisfaction STRING(250)
OPTIONS(description='code of the answer to survey question "How satisfied were you in general with your last order in the Lidl online shop"'),
q_digital_postal_code STRING(250)
OPTIONS(description='code of the answer to survey question "Please state the first three digits of your postal code"'),
q_digital_product_match_presentation STRING(250)
OPTIONS(description='code of the answer to survey question "The products match the presentation in the online shop - yes/no/cannot say"'),
q_digital_product_price STRING(250)
OPTIONS(description='code of the answer to survey question "The prices of the products are reasonable - yes/no/cannot say"'),
q_digital_product_quality STRING(250)
OPTIONS(description='code of the answer to survey question "The quality of the products convinces me - yes, no, no cannot say"'),
q_digital_product_return_order STRING(250)
OPTIONS(description='code of the answer to survey question\'Did you return your order (or parts of it)\''),
q_digital_product_satisfaction STRING(250)
OPTIONS(description='code of the answer to survey question "How satisfied were you with the products of your last order in the Lidl online shop?"'),
q_digital_return_ces STRING(250)
OPTIONS(description='code of the answer to survey question "How much effort was it to place your return?  "'),
q_digital_return_ces_comments STRING(10000)
OPTIONS(description='open text form "How can we improve our return process?  "'),
q_digital_return_label_usability STRING(250)
OPTIONS(description='code of the answer to survey question "The return form was easy to fill out"'),
q_digital_return_status_information STRING(250)
OPTIONS(description='code of the answer to survey question "I feel adequately informed about the status_1 of the return. "'),
q_digital_return_time_back_payment STRING(250)
OPTIONS(description='code of the answer to survey question "The time to credit was reasonable. "'),
q_digital_satisfaction_web_presence STRING(250)
OPTIONS(description='code of the answer to survey question "How satisfied were you with the web presence of the Lidl online shop?"'),
q_digital_trigger STRING(250)
OPTIONS(description='code of the answer to survey question - no info (could be "what made you choose Lidl Digital" but this is a guess)'),
k_lidl_digital_custom_par_5006_product_price_auto STRING(250) OPTIONS(description='Derived Product Brand_1 (DE)'),
k_lidl_digital_custom_par_5007_product_price_auto STRING(250) OPTIONS(description='Derived Product Price (DE)'),
k_lidl_digital_custom_par_5662_product_name_auto STRING(250) OPTIONS(description='Derived Product Name (DE)'),
k_lidl_digital_custom_par_5761_product_id_auto STRING(250) OPTIONS(description='Derived Product ID (DE)'),
k_lidl_digital_custom_par_6110_product_id_sk_auto STRING(250) OPTIONS(description='Derived Product ID (SK)'),
k_lidl_digital_custom_par_6111_product_name_auto STRING(250) OPTIONS(description='Derived Product Name (SK)'),
k_lidl_digital_custom_par_6112_product_price_auto STRING(250) OPTIONS(description='Derived Product Price (SK)'),
k_lidl_digital_custom_par_6114_product_brand_auto STRING(250) OPTIONS(description='Derived Product Brand_1 (SK)'),
k_lidl_digital_custom_par_6115_product_brand_auto STRING(250) OPTIONS(description='Derived Product Brand_1 (BE)'),
k_lidl_digital_custom_par_6117_product_price_auto STRING(250) OPTIONS(description='Derived Product Price (BE)'),
k_lidl_digital_custom_par_6118_product_id_be_auto STRING(250) OPTIONS(description='Derived Product ID (BE)'),
k_lidl_digital_custom_par_6119_product_name_auto STRING(250) OPTIONS(description='Derived Product Name (BE)'),
k_lidl_digital_custom_par_6120_product_brand_auto STRING(250) OPTIONS(description='Derived Product Brand_1 (CZ)'),
k_lidl_digital_custom_par_6122_product_price_auto STRING(250) OPTIONS(description='Derived Product Price (CZ)'),
k_lidl_digital_custom_par_6123_product_id_cz_auto STRING(250) OPTIONS(description='Derived Product ID (CZ)'),
k_lidl_digital_custom_par_6124_product_name_auto STRING(250) OPTIONS(description='Derived Product Name (CZ)'),
k_lidl_digital_custom_par_6125_product_brand_auto STRING(250) OPTIONS(description='Derived Product Brand_1 (NL)'),
k_lidl_digital_custom_par_6127_product_price_auto STRING(250) OPTIONS(description='Derived Product Price (NL)'),
k_lidl_digital_custom_par_6128_product_id_nl_auto STRING(250) OPTIONS(description='Derived Product ID (NL)'),
k_lidl_digital_custom_par_6129_product_name_auto STRING(250) OPTIONS(description='Derived Product Name (NL)'),
k_lidl_digital_custom_par_6130_product_brand_auto STRING(250) OPTIONS(description='Derived Product Brand_1 (PL)'),
k_lidl_digital_custom_par_6132_product_price_auto STRING(250) OPTIONS(description='Derived Product Price (PL)'),
k_lidl_digital_custom_par_6133_product_name_auto STRING(250) OPTIONS(description='Derived Product Name (PL)'),
k_lidl_digital_custom_par_6134_product_id_pl_auto STRING(250) OPTIONS(description='Derived Product ID (PL)'),
k_lidl_digital_custom_par_6447_product_brand_auto STRING(250) OPTIONS(description='Derived Product Brand_1 (ES)'),
k_lidl_digital_custom_par_6449_product_price_auto STRING(250) OPTIONS(description='Derived Product Price (ES)'),
k_lidl_digital_custom_par_6450_product_name_auto STRING(250) OPTIONS(description='Derived Product Name (ES)'),
k_lidl_digital_custom_par_6451_product_id_be_auto STRING(250) OPTIONS(description='Derived Product ID (ES)'),
k_lidl_digital_product_category_all_country_multi STRING(250)
OPTIONS(description='Derived Product Category - Multi Valued (All Countries)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (a_surveyid) NOT ENFORCED
) OPTIONS(description='Helper table that stores "as-is" survey data comming from Medallia system');