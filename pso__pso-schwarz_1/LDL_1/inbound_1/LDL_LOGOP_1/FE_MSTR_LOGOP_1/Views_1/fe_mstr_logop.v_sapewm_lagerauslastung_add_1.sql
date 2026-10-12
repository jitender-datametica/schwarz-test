CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_LAGERAUSLASTUNG_ADD_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	LIDL_CTRY COMMENT 'Country_1 code. Original field name bic_zmlila',
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
) AS 
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,wh_id
		,lgpla AS strg_bin
		,lgtyp AS strg_type
		,CASE strg_type
			WHEN ('0101') THEN 'HR Ambient Reserve'
			WHEN ('0111') THEN 'HR Hazardous Ambient Reserve'
			WHEN ('0121') THEN 'HR Chilled Ambient Reserve'
			WHEN ('0131') THEN 'HR Ambient Reserve'
			WHEN ('0143') THEN 'Buffer for Reorg Tunnel'
			WHEN ('0205') THEN 'Ambient Roll Rack Reserve'
			WHEN ('0251') THEN 'Bulk Reserve'
			WHEN ('0301') THEN 'HR NF/Food Promo Reserve'
			WHEN ('0307') THEN 'NF Pushback Reserve'
			WHEN ('0501') THEN 'HR Chiller Reserve'
			WHEN ('0601') THEN 'MPF Catch Weight Reserve'
			WHEN ('0602') THEN 'MPF Non CW Reserve'
			WHEN ('0701') THEN 'HR Freezer Reserve'
			WHEN ('0707') THEN 'HR Freezer Pushback Reserve'
			WHEN ('0711') THEN 'HR Bake Off Reserve'
			WHEN ('0715') THEN 'HR Bake Off Roll Rack Reserve'
			WHEN ('7000') THEN 'HR Returned Products'
			WHEN ('8141') THEN 'AHR Ambient Reserve'
			WHEN ('8143') THEN 'AHR Ambient Emergency Exit -Loops Defect'
			WHEN ('8180') THEN 'AHR Ambient Conveyor System'
			WHEN ('EX01') THEN 'Ext. WH 1'
			WHEN ('EX02') THEN 'Ext. WH 2'
			WHEN ('EX03') THEN 'Ext. WH 3'
			ELSE 'Unassigned'
			END AS strg_type_desc
		,CASE strg_type
			WHEN ('0101') THEN 'Ambient'
			WHEN ('0111') THEN 'Ambient'
			WHEN ('0121') THEN 'Ambient'
			WHEN ('0131') THEN 'Ambient'
			WHEN ('0143') THEN 'Ambient'
			WHEN ('0205') THEN 'Bulk'
			WHEN ('0251') THEN 'Bulk'
			WHEN ('0301') THEN 'NF'
			WHEN ('0307') THEN 'NF'
			WHEN ('0501') THEN 'Chiller'
			WHEN ('0601') THEN 'MPF'
			WHEN ('0602') THEN 'MPF'
			WHEN ('0701') THEN 'Freezer'
			WHEN ('0707') THEN 'Freezer'
			WHEN ('0711') THEN 'Freezer'
			WHEN ('0715') THEN 'Freezer'
			WHEN ('7000') THEN 'NF-Return'
			WHEN ('8141') THEN 'AHR'
			WHEN ('8143') THEN 'AHR'
			WHEN ('8180') THEN 'AHR'
			WHEN ('EX01') THEN 'ExWH'
			WHEN ('EX02') THEN 'ExWH'
			WHEN ('EX03') THEN 'ExWH'
			ELSE 'Unassigned'
			END AS area
		,CASE area
			WHEN ('AHR') THEN '8'
			WHEN ('Ambient') THEN '1'
			WHEN ('NF') THEN '3'
			WHEN ('Returns') THEN '9'
			WHEN ('Bulk') THEN '2'
			WHEN ('F&V') THEN '4'
			WHEN ('Chiller') THEN '5'
			WHEN ('MPF') THEN '6'
			WHEN ('Freezer') THEN '7'
			WHEN ('ExWH') THEN '10'
			ELSE '-999'
			END AS areaid
		,lgber AS strg_sec
		,COUNT( DISTINCT lgpla) OVER (PARTITION BY strg_bin) AS bin_cnt
		,lptyp AS strg_bin_type
		,bin_at AS bin_acs_type
		,kzler AS is_strg_bin_empty_flg
		,kzvol AS is_strg_bin_full_flg
		,aisle AS strg_bin_aisle 
		,stack AS strg_bin_stack 
		,lvl_v AS strg_bin_level
		,fixbintyp AS is_strg_bin_fixed_flg
		,max_capa AS tot_capa
		,fcapa AS rem_capa
		,FLOOR(tot_capa/10000000) AS epe_capa
		,FLOOR(rem_capa/10000000) AS avl_capa
		,epe_capa-avl_capa AS used_capa
		,rem_bin_depth AS empty_bin
		,max_bin_depth AS total_bin
		,max_bin_depth - rem_bin_depth AS occupied_bin
		,CASE WHEN strg_type IN ('8141','8143','8180') THEN bin_cnt*empty_bin ELSE bin_cnt*IFF(is_strg_bin_empty_flg, 1, 0) END AS bin_rem
        ,CASE WHEN strg_type IN ('8141','8143','8180') THEN bin_cnt*total_bin ELSE bin_cnt END AS bin_ges
        ,CASE WHEN strg_type IN ('8141','8143','8180') THEN bin_cnt*occupied_bin ELSE bin_cnt-bin_rem END AS bin_used
		,dwh_load_id
		,dwh_created
		,dwh_updated
		,dwh_valid_from
		,dwh_valid_to
		,deleted_fg
	FROM "DATA".T_SAPEWM_STORAGEBIN_1  
	WHERE strg_type IN ('0101', '0111','0121','0131','0143','0205','0251','0301','0307','0501','0601','0602','0701','0707','0711','0715','7000','8141','8143','8180','EX01','EX02','EX03')
	AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
	AND strg_bin NOT LIKE '%DUMMY_1%'
    AND DELETED_FG = 'FALSE'
UNION
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,wh_id
		,lgpla AS strg_bin
		,lgtyp AS strg_type
		,CASE strg_type
			WHEN ('0101') THEN 'HR Ambient Reserve'
			WHEN ('0111') THEN 'HR Hazardous Ambient Reserve'
			WHEN ('0121') THEN 'HR Chilled Ambient Reserve'
			WHEN ('0131') THEN 'HR Ambient Reserve'
			WHEN ('0143') THEN 'Buffer for Reorg Tunnel'
			WHEN ('0205') THEN 'Ambient Roll Rack Reserve'
			WHEN ('0251') THEN 'Bulk Reserve'
			WHEN ('0301') THEN 'HR NF/Food Promo Reserve'
			WHEN ('0307') THEN 'NF Pushback Reserve'
			WHEN ('0501') THEN 'HR Chiller Reserve'
			WHEN ('0601') THEN 'MPF Catch Weight Reserve'
			WHEN ('0602') THEN 'MPF Non CW Reserve'
			WHEN ('0701') THEN 'HR Freezer Reserve'
			WHEN ('0707') THEN 'HR Freezer Pushback Reserve'
			WHEN ('0711') THEN 'HR Bake Off Reserve'
			WHEN ('0715') THEN 'HR Bake Off Roll Rack Reserve'
			WHEN ('7000') THEN 'HR Returned Products'
			WHEN ('8141') THEN 'AHR Ambient Reserve'
			WHEN ('8143') THEN 'AHR Ambient Emergency Exit -Loops Defect'
			WHEN ('8180') THEN 'AHR Ambient Conveyor System'
			WHEN ('EX01') THEN 'Ext. WH 1'
			WHEN ('EX02') THEN 'Ext. WH 2'
			WHEN ('EX03') THEN 'Ext. WH 3'
			ELSE 'Unassigned'
			END AS strg_type_desc
		,CASE strg_type
			WHEN ('0101') THEN 'Total'
			WHEN ('0111') THEN 'Total'
			WHEN ('0121') THEN 'Total'
			WHEN ('0131') THEN 'Total'
			WHEN ('0143') THEN 'Total'
			WHEN ('0205') THEN 'Total'
			WHEN ('0251') THEN 'Total'
			WHEN ('0301') THEN 'Total'
			WHEN ('0307') THEN 'Total'
			WHEN ('0501') THEN 'Total'
			WHEN ('0601') THEN 'Total'
			WHEN ('0602') THEN 'Total'
			WHEN ('0701') THEN 'Total'
			WHEN ('0707') THEN 'Total'
			WHEN ('0711') THEN 'Total'
			WHEN ('0715') THEN 'Total'
			WHEN ('7000') THEN 'Total'
			WHEN ('8141') THEN 'Total'
			WHEN ('8143') THEN 'Total'
			WHEN ('8180') THEN 'Total'
			WHEN ('EX01') THEN 'Total'
			WHEN ('EX02') THEN 'Total'
			WHEN ('EX03') THEN 'Total'
			ELSE 'Unassigned'
			END AS area
		,CASE area
			WHEN ('Total') THEN '999'
			ELSE '-999'
			END AS areaid
		,lgber AS strg_sec
		,COUNT( DISTINCT lgpla) OVER (PARTITION BY strg_bin) AS bin_cnt
		,lptyp AS strg_bin_type
		,bin_at AS bin_acs_type
		,kzler AS is_strg_bin_empty_flg
		,kzvol AS is_strg_bin_full_flg
		,aisle AS strg_bin_aisle 
		,stack AS strg_bin_stack 
		,lvl_v AS strg_bin_level
		,fixbintyp AS is_strg_bin_fixed_flg
		,max_capa AS tot_capa
		,fcapa AS rem_capa
		,FLOOR(tot_capa/10000000) AS epe_capa
		,FLOOR(rem_capa/10000000) AS avl_capa
		,epe_capa-avl_capa AS used_capa
		,rem_bin_depth AS empty_bin
		,max_bin_depth AS total_bin
		,max_bin_depth - rem_bin_depth AS occupied_bin
		,CASE WHEN strg_type IN ('8141','8143','8180') THEN bin_cnt*empty_bin ELSE bin_cnt*IFF(is_strg_bin_empty_flg, 1, 0) END AS bin_rem
        ,CASE WHEN strg_type IN ('8141','8143','8180') THEN bin_cnt*total_bin ELSE bin_cnt END AS bin_ges
        ,CASE WHEN strg_type IN ('8141','8143','8180') THEN bin_cnt*occupied_bin ELSE bin_cnt-bin_rem END AS bin_used
		,dwh_load_id
		,dwh_created
		,dwh_updated
		,dwh_valid_from
		,dwh_valid_to
		,deleted_fg
	FROM "DATA".T_SAPEWM_STORAGEBIN_1  
	WHERE strg_type IN ('0101', '0111','0121','0131','0143','0205','0251','0301','0307','0501','0601','0602','0701','0707','0711','0715','7000','8141','8143','8180')
	AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
	AND strg_bin NOT LIKE '%DUMMY_1%'
    AND DELETED_FG = 'FALSE'
;