/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_stagingtollcell_kpi_2
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_stagingtollcell_kpi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_country
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), src_address_id OPTIONS(description='Identifier of the origin address_2'),
new_mod_fg OPTIONS(description='Indicator whether it\"s newly imported/created or it has fields updated'), soft_dlv_fg
OPTIONS(description='True if the instance is removed from external system\"'), time_profile_id
OPTIONS(description='Identifier of time profile'), tgt_address_id
OPTIONS(description='Identifier of the destination address_2'), toll_cat_id
OPTIONS(description='The identifier for toll category'), toll_cost
OPTIONS(description='The toll cost from origin to destination address_2'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), active_fg OPTIONS(description='Flag if record is active'))
OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 src_address_id,
 new_mod_fg,
 soft_dlv_fg,
 time_profile_id,
 tgt_address_id,
 toll_cat_id,
 toll_cost,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_stagingtollcell_2;