CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_order_by_sales_company_1 (sales_company_sid
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'), country_org_cd
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
int_org_nr
OPTIONS(description='The number which identifies the sales_1 company (VGES) /Store to which this store is related.'),
int_org_type_cd OPTIONS(description='The code identifying the discriminators for internal organizations.'),
requestor_user_name
OPTIONS(description='The MicroStrategy-User who requests fraud detection analysis for organization unit_1 in ZKP-Solution'),
request_tmsp OPTIONS(description='The point in time when this record requested by the MicroStrategy-User.'),
approver_user_name
OPTIONS(description='The MicroStrategy-User who approves the fraud detection analysis for organization unit_1 in ZKP-Solution'),
approved_tmsp OPTIONS(description='The point in time when this record approved by the MicroStrategy-User.'),
analysis_period_start_dt
OPTIONS(description='The begin date of the period which receipts of the internal organization will be analysed'),
analysis_period_end_dt
OPTIONS(description='The end date of the period which receipts of the internal organization will be analysed'),
order_parameter_status_cd OPTIONS(description='The status_1 of a order parameter if it is approved, requested or denied.'),
order_reason_cd
OPTIONS(description='The revision reason code for an analysis, if it is for threshold definition or fraud analysis'),
audit_user_name OPTIONS(description='The MicroStrategy-User who prooves and start the audit.'), audit_tmsp
OPTIONS(description='The point in time when this record approved by the MicroStrategy-User or the audit got started from the MicroStrategy-User '),
cancel_scenario_grp_fg
OPTIONS(description='An indicator showing the analysis should proove the cancel scenarios group.'),
deposit_scenario_grp_fg
OPTIONS(description='An indicator showing the analysis should proove the deposit scenarios group'),
return_scenario_grp_fg OPTIONS(description='An indicator showing the analysis should proove the return scenario group'),
abort_scenario_grp_suspend_fg
OPTIONS(description='An indicator showing the analysis should proove the abourt/suspend scenario group'),
discount_scenario_grp_fg
OPTIONS(description='An indicator showing the analysis should proove the discount scenario group'),
other_scenario_grp_fg
OPTIONS(description='xxx_1 An indicator showing the analysis should proove the other scenario group'), test_fg
OPTIONS(description='An indicator showing the analysis is a test_1 case'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE CURRENT ENTRIES FOR THE SALES_1 COMPANIES`) AS SELECT int_org_sid AS sales_company_sid,
 country_org_cd,
 int_org_nr,
 int_org_type_cd,
 requestor_user_name,
 request_tmsp,
 approver_user_name,
 approved_tmsp,
 analysis_period_start_dt,
 analysis_period_end_dt,
 order_parameter_status_cd,
 order_reason_cd,
 audit_user_name,
 audit_tmsp,
 cancel_scenario_grp_fg,
 deposit_scenario_grp_fg,
 return_scenario_grp_fg,
 abort_scenario_grp_suspend_fg,
 discount_scenario_grp_fg,
 other_scenario_grp_fg,
 test_fg,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_1 AS main
WHERE int_org_type_cd = 'COMPANY';