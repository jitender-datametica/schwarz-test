CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_report_webshop_user_privilege (
report_name STRING(50) OPTIONS(description='Name of the report for which this condition is used'),
username STRING(50) OPTIONS(description='Username of the user (Lidl Digital employee)'),
full_mstr_login_name STRING(100) NOT NULL OPTIONS(description='Microstrategy login of the user (Lidl Digital employee)'),
wshop_cd STRING(20) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
tmsp_insert DATETIME,
tmsp_update DATETIME,
PRIMARY KEY (full_mstr_login_name, wshop_cd) NOT ENFORCED
)
OPTIONS(description='This table contains users information and all the webshops they have privileges for in the specified report');