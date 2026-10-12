/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_stockoverview_stocktype_kpi_1
Description		|	SAP EWM Stock Overview - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_stocktype_kpi_1 (client_id
OPTIONS(description='Client ID (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), strg_bin
OPTIONS(description='Storage bin'), strg_type OPTIONS(description='Storage type'), strg_bin_aisle
OPTIONS(description='Storage bin aisle'), dwh_updated OPTIONS(description='DWH update timestamp'), hu_ident
OPTIONS(description='Handling unit_1 ID (PK)'), zz_hu_type OPTIONS(description='Handling unit_1 type'), sorted_non_food_flg
OPTIONS(description='Sorted non-food flag'), pair_bracket OPTIONS(description='Pair bracket'), sys_pal
OPTIONS(description='System pallet'), prod_desc_fg OPTIONS(description='Product description Flag'), paci
OPTIONS(description='Putaway control indicator (Einlagersteuerkennzeichen)'), hu_epa
OPTIONS(description='Calculated EPA of handling unit_1 (Europalettenaequivalente)'), assort_area_id
OPTIONS(description='Identified assortment area'), hu_type_ep
OPTIONS(description='Identified handling unit_1 type for EP'), hu_type_ep_sp
OPTIONS(description='Identified handling unit_1 type for EP with SP'), hu_type_single_dd
OPTIONS(description='Identified handling unit_1 type for DD single'), hu_type_coupled_dd
OPTIONS(description='Identified handling unit_1 type for DD coupled'))
OPTIONS(DESCRIPTION = `SAP EWM STOCK OVERVIEW REPORT FOR STOCK TYPE - FINAL VIEW (BASED ON V_SAPEWM_STOCKOVERVIEW_STOCKTYPE_ADD_1)`)
AS SELECT client_id,
 wh_id,
 strg_bin,
 strg_type,
 strg_bin_aisle,
 dwh_updated,
 hu_ident,
 zz_hu_type,
 sorted_non_food_flg,
 pair_bracket,
 sys_pal,
 prod_desc_fg,
 paci,
 hu_epa,
 assort_area_id,
 hu_type_ep,
 hu_type_ep_sp,
 hu_type_single_dd,
 hu_type_coupled_dd
FROM ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_stocktype_add_1;