CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_LAGERAUSLASTUNG_KPI_2(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code',
	LIDL_CTRY COMMENT 'Country_2 code. Original field name bic_zmlila',
	WH_ID COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	STRG_BIN COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA',
	STRG_TYPE COMMENT 'Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP',
	STRG_TYPE_DESC,
	AREA,
	AREAID,
	STRG_SEC COMMENT 'Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER',
	BIN_CNT,
	STRG_BIN_TYPE COMMENT 'Storage bin type',
	BIN_ACS_TYPE COMMENT 'Bin access type',
	IS_STRG_BIN_EMPTY_FLG COMMENT 'Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER',
	IS_STRG_BIN_FULL_FLG COMMENT 'Full Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER',
	STRG_BIN_AISLE COMMENT 'Storage bin aisle',
	STRG_BIN_STACK COMMENT 'Storage bin stack',
	STRG_BIN_LEVEL COMMENT 'Storage bin level',
	IS_STRG_BIN_FIXED_FLG COMMENT 'Fixed Storage Bin Type',
	TOT_CAPA COMMENT 'Total Capacity Key Figure - Technical name: G_CAPA - Component Type: /SCWM/DE_GCAPA',
	REM_CAPA COMMENT 'Net Capacity Key Figure',
	EPE_CAPA COMMENT 'Total Capacity in EuroPallet Equivalent, rounded down',
	AVL_CAPA COMMENT 'Net Capacity in EuroPallet Equivalent, rounded down',
	USED_CAPA COMMENT 'Total-Net Capacity in EuroPallet Equivalent, rounded down',
	EMPTY_BIN COMMENT 'Empty bins',
	TOTAL_BIN COMMENT 'Total bins',
	OCCUPIED_BIN COMMENT 'Occupied bins',
	BIN_REM COMMENT 'Remaining bins - calculations adjusted for AHR',
	BIN_GES COMMENT 'Total bins - calculations adjusted for AHR',
	BIN_USED COMMENT 'Occupied bins - calculations adjusted for AHR',
	DWH_LOAD_ID COMMENT 'Load id',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DELETED_FG COMMENT 'Flag if record is deleted'
) AS SELECT
		client_id
		,lidl_ctry
		,wh_id
		,strg_bin
		,strg_type
		,strg_type_desc
		,area
		,areaid
		,strg_sec
		,bin_cnt
		,strg_bin_type
		,bin_acs_type
		,is_strg_bin_empty_flg
		,is_strg_bin_full_flg
		,strg_bin_aisle
		,strg_bin_stack
		,strg_bin_level
		,is_strg_bin_fixed_flg
		,tot_capa
		,rem_capa
		,epe_capa
		,avl_capa
		,used_capa
		,empty_bin
		,total_bin
		,occupied_bin
		,bin_rem
		,bin_ges
		,bin_used
		,dwh_load_id
		,dwh_created
		,dwh_updated
		,dwh_valid_from
		,dwh_valid_to
		,deleted_fg
FROM FE_MSTR_LOGOP.V_SAPEWM_LAGERAUSLASTUNG_ADD_2
;