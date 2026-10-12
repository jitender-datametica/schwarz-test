/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_stockoverview_stocktype_kpi_1
Description		|	SAP EWM Stock Overview - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_stockoverview_stocktype_kpi_1 (
	client_id COMMENT 'Client ID (PK)'
	--,lidl_ctry COMMENT 'Country_1 code'
	,wh_id COMMENT 'Warehouse ID (PK)'
	,strg_bin COMMENT 'Storage bin'
	--,strg_bin_type COMMENT 'Storage bin type'
	,strg_type COMMENT 'Storage type'
	--,strg_sec COMMENT 'Storage section'
	--,bin_acs_type COMMENT 'Bin access type'
	,strg_bin_aisle COMMENT 'Storage bin aisle'
	--,strg_bin_stack COMMENT 'Storage bin stack'
	--,strg_bin_level COMMENT 'Storage bin level'
	--,dwh_valid_from COMMENT 'Valid from date (PK)'
	--,dwh_valid_to COMMENT 'Valid to date'
	--,dwh_created COMMENT 'DWH creation timestamp'
	,dwh_updated COMMENT 'DWH update timestamp'
	,hu_ident COMMENT 'Handling unit_1 ID (PK)'
	--,hu_type COMMENT 'Handling unit_1 type'
	,zz_hu_type COMMENT 'Handling unit_1 type'
	,sorted_non_food_flg COMMENT 'Sorted non-food flag'
	,pair_bracket COMMENT 'Pair bracket'
	,sys_pal COMMENT 'System pallet'
	--,prod_nr COMMENT 'Product number (PK)'
	--,prod_desc_ps COMMENT 'Product short description'
	--,gr_dt COMMENT 'Goods receipt date (PK)'
	--,gr_tm COMMENT 'Goods receipt time (PK)'
	--,stock_type COMMENT 'Stock Type (PK)'
	--,doc_nr COMMENT 'Document (PK)'
	--,batch COMMENT 'Batch (PK)'
	,prod_desc_fg COMMENT 'Product description Flag'
	,paci COMMENT 'Putaway control indicator (Einlagersteuerkennzeichen)'
	--,prod_nr_first COMMENT 'Indicator to identify the first record of Physical Stock per group'
	--,hu_ident_first COMMENT 'Indicator for calculating only once per handling unit_1'
	,hu_epa COMMENT 'Calculated EPA of handling unit_1 (Europalettenaequivalente)' 
	,assort_area_id COMMENT 'Identified assortment area'
	,hu_type_ep COMMENT 'Identified handling unit_1 type for EP'
	,hu_type_ep_sp COMMENT 'Identified handling unit_1 type for EP with SP'
	,hu_type_single_dd COMMENT 'Identified handling unit_1 type for DD single'
	,hu_type_coupled_dd COMMENT 'Identified handling unit_1 type for DD coupled'
) COMMENT = 'SAP EWM stock overview report for stock type - final view (based on v_sapewm_stockoverview_stocktype_add_1)'
AS
SELECT
	client_id
	--,lidl_ctry
	,wh_id
	,strg_bin
	--,strg_bin_type
	,strg_type
	--,strg_sec
	--,bin_acs_type
	,strg_bin_aisle
	--,strg_bin_stack
	--,strg_bin_level
	--,dwh_valid_from
	--,dwh_valid_to
	--,dwh_created
	,dwh_updated
	,hu_ident
	--,hu_type
	,zz_hu_type
	,sorted_non_food_flg
	,pair_bracket
	,sys_pal
	--,prod_nr
	--,prod_desc_ps
	--,gr_dt
	--,gr_tm
	--,stock_type
	--,doc_nr
	--,batch
	,prod_desc_fg
	,paci
	--,prod_nr_first
	--,hu_ident_first
	,hu_epa
	,assort_area_id
	,hu_type_ep
	,hu_type_ep_sp
	,hu_type_single_dd
	,hu_type_coupled_dd
FROM fe_mstr_logop.v_sapewm_stockoverview_stocktype_add_1 -- Primary key combination (client_id, wh_id, strg_bin, dwh_valid_from)
;

