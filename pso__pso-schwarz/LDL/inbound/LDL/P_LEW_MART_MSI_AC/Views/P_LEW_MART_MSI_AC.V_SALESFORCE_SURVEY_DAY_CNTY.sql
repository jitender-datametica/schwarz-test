/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_SALESFORCE_SURVEY_DAY_CNTY
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SALESFORCE_SURVEY_DAY_CNTY AS
SELECT
	client_id
	,cc2
	,cc3
	,cust_complaint_sid
	,src_cust_complaint_nr
	,case_open_dt
	,cust_complaint_survey_dt
	,cust_complaint_feedback_val
	,dat_calendar
	,cy_month
	,byr
FROM
	P_LEW_MART_MSI.V_SALESFORCE_SURVEY_DAY_CNTY;