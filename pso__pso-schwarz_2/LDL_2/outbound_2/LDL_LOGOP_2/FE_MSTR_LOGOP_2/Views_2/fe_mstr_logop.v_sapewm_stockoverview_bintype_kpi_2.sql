/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_bintype_kpi_2
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-22		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	Final view for SAP EWM stock overview report bin type
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_bintype_kpi_2 (client_id
OPTIONS(description='Client ID (PK)'), lidl_ctry OPTIONS(description='Country_2 code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), strg_bin OPTIONS(description='Storage bin (PK)'), strg_bin_type
OPTIONS(description='Storage bin type'), strg_type OPTIONS(description='Storage type'), strg_sec
OPTIONS(description='Storage section'), bin_acs_type OPTIONS(description='Bin access type'), is_strg_bin_empty_flg
OPTIONS(description='Storage bin is empty'), is_strg_bin_full_flg OPTIONS(description='Storage bin is full'),
strg_bin_aisle OPTIONS(description='Storage bin aisle'), strg_bin_stack OPTIONS(description='Storage bin stack'),
strg_bin_level OPTIONS(description='Storage bin level'), rem_bin_depth OPTIONS(description='Remaining bin depth'),
max_bin_depth OPTIONS(description='Maximum bin depth'), dwh_valid_from OPTIONS(description='Valid from date (PK)'),
dwh_valid_to OPTIONS(description='Valid to date'), pi_doc_nr OPTIONS(description='Physical inventory document number'),
dwh_created OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'),
total_bin OPTIONS(description='Total bins'), occupied_bin OPTIONS(description='Occupied bins'), empty_bin
OPTIONS(description='Empty bins'), strg_bin_cat OPTIONS(description='Storage bin category'))
OPTIONS(DESCRIPTION = `SAP EWM STOCK OVERVIEW REPORT FOR BIN TYPE - FINAL VIEW (BASED ON V_SAPEWM_STOCKOVERVIEW_BINTYPE_ADD_2)`)
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_bintype_add_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to;