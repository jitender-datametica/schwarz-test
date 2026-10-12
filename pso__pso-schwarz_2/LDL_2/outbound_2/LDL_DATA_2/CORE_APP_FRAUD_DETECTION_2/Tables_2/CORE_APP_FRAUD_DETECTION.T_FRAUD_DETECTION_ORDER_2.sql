/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_order_2
   generated from Powerdesigner on Mittwoch, 16. Oktober 2024 16:23:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_detection_order_2 (
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organizatio (store or sales_2 company/VGES)'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
int_org_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the sales_2 company (VGES) /Store to which this store is related.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
requestor_user_name STRING(100) NOT NULL
OPTIONS(description='The MicroStrategy-User who requests fraud detection analysis for organization unit_2 in ZKP-Solution'),
request_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record requested by the MicroStrategy-User.'),
approver_user_name STRING(100)
OPTIONS(description='The MicroStrategy-User who approves the fraud detection analysis for organization unit_2 in ZKP-Solution'),
approved_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record approved by the MicroStrategy-User.'),
analysis_period_start_dt DATE NOT NULL
OPTIONS(description='The begin date of the period which receipts of the internal organization will be analysed'),
analysis_period_end_dt DATE NOT NULL
OPTIONS(description='The end date of the period which receipts of the internal organization will be analysed'),
order_parameter_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_2 of a order parameter if it is approved, requested or denied.'),
order_reason_cd STRING(20)
OPTIONS(description='The revision reason code for an analysis, if it is for threshold definition or fraud analysis'),
audit_user_name STRING(100) OPTIONS(description='The MicroStrategy-User who prooves and start the audit.'),
audit_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record approved by the MicroStrategy-User or the audit got started from the MicroStrategy-User '),
cancel_scenario_grp_fg BOOL DEFAULT TRUE NOT NULL
OPTIONS(description='An indicator showing the analysis should proove the cancel scenarios group.'),
deposit_scenario_grp_fg BOOL DEFAULT TRUE NOT NULL
OPTIONS(description='An indicator showing the analysis should proove the deposit scenarios group'),
return_scenario_grp_fg BOOL DEFAULT TRUE NOT NULL
OPTIONS(description='An indicator showing the analysis should proove the return scenario group'),
abort_scenario_grp_suspend_fg BOOL DEFAULT TRUE NOT NULL
OPTIONS(description='An indicator showing the analysis should proove the abourt/suspend scenario group'),
discount_scenario_grp_fg BOOL DEFAULT TRUE NOT NULL
OPTIONS(description='An indicator showing the analysis should proove the discount scenario group'),
other_scenario_grp_fg BOOL DEFAULT TRUE NOT NULL
OPTIONS(description='xxx_2 An indicator showing the analysis should proove the other scenario group'),
test_fg BOOL DEFAULT FALSE NOT NULL OPTIONS(description='An indicator showing the analysis is a test_2 case'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, request_tmsp) NOT ENFORCED
)
OPTIONS(description='Contains the requestes for all fraud detection audits. Hold the status_2 of the request, requester and approver. A request can be placed and it can be store or internal (sales_2 / VGES) company. The request is for a certain period, this is by default for the sales_2 company the last 8 full weeks.A request can be placed for one or several group of scenarios. Additional a business (audit user) start the audit proces.');