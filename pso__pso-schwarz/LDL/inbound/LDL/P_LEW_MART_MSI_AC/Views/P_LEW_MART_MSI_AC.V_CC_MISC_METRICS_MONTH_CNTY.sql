/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_CC_MISC_METRICS_MONTH_CNTY
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CC_MISC_METRICS_MONTH_CNTY AS
SELECT
	client_id
	,cy_month
	,dat_calendar
	,cal_dt
	,area_name
	,service_level_call
	,service_availability_call
	,self_service_sessions
	,pers_cost_eur_val
	,mat_cost_eur_val
FROM
	P_LEW_MART_MSI.V_CC_MISC_METRICS_MONTH_CNTY;