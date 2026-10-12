CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_complaint_case_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
cust_complaint_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for customer compaint case'),
src_cust_complaint_nr STRING(250) NOT NULL
OPTIONS(description='The unique key generated in Salesforce if a case is added to the SF database.'),
cust_complaint_nr BIGNUMERIC(38,0) OPTIONS(description='Customer compaint case number as shown to user'),
case_open_dt DATE OPTIONS(description='The first time an agent accepts the case and starts working on it. in UTC Time.'),
src_name STRING(100) OPTIONS(description='Source System Name (Salesforce or BSI )'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (cust_complaint_sid) NOT ENFORCED
)
OPTIONS(description='The table contais customer complait cases opened in Salesforce or BSI systems as a result of a customer reporting issues via mail , web-form or phone');