/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_utilization_kpi
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-06		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	Final view for SAP EWM stock overview report utilization
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_utilization_kpi (client_id
OPTIONS(description='Client ID (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), strg_bin
OPTIONS(description='Storage bin (PK)'), strg_bin_type OPTIONS(description='Storage bin type'), strg_type
OPTIONS(description='Storage type'), strg_sec OPTIONS(description='Storage section'), hu_cnt
OPTIONS(description='Number of handling units in storage bin'), is_strg_bin_empty_flg
OPTIONS(description='Storage bin is empty'), is_strg_bin_full_flg OPTIONS(description='Storage bin is full'),
strg_bin_aisle OPTIONS(description='Storage bin aisle'), strg_bin_stack OPTIONS(description='Storage bin stack'),
rem_bin_depth OPTIONS(description='Remaining bin depth'), max_bin_depth OPTIONS(description='Maximum bin depth'),
dwh_valid_from OPTIONS(description='Valid from date (PK)'), dwh_valid_to OPTIONS(description='Valid to date'),
dwh_created OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'),
hu_strg_bin OPTIONS(description='Storage bin of handling unit data that matches'), cnt_hut_single_dd
OPTIONS(description='Number of records with handling unit type DD single per storage bin'), cnt_hut_coupled_dd
OPTIONS(description='Number of records with handling unit type DD coupled per storage bin'), cnt_hut_total_ep
OPTIONS(description='Number of records with handling unit type EP and SP per storage bin'), cnt_hut_epae
OPTIONS(description='Total of records with any of those three handling unit types (DD single, DD coupled and EP & SP)'),
cnt_hu_ident
OPTIONS(description='Number of handling unit IDs (PK) per storage bin (only to see how many data records have been aggregated)'),
total_bin OPTIONS(description='Total bins'), occupied_bin OPTIONS(description='Occupied bins'), empty_bin
OPTIONS(description='Empty bins'), total_ch
OPTIONS(description='Total channel which is equal to all storage bins with storage type 8141 without considering empty indicators'),
occupied_ch
OPTIONS(description='Occupied channel which is all storage bins with storage type 8141 and empty indicator not true'),
empty_ch OPTIONS(description='Empty channel which is all storage bins with storage type 8141 and empty indicator true '),
total_pickface OPTIONS(description='Total pickface'), unassigned_pickface OPTIONS(description='Unassigned pickface')) AS
SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_utilization_add
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to;