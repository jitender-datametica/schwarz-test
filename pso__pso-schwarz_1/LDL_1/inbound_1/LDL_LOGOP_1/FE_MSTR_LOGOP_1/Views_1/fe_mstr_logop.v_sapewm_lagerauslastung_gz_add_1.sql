CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_LAGERAUSLASTUNG_GZ_ADD_1(
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
			WHEN ('0100') THEN 'HR Ambient Case Pick'
			WHEN ('0106') THEN 'HR Ambient Flow Rack Case Pick'
			WHEN ('0110') THEN 'HR Hazardous Ambient Case Pick'
			WHEN ('0120') THEN 'HR Chilled Ambient Case Pick'
			WHEN ('0126') THEN 'HR Chilled Ambient Flow Rack Case Pick'
			WHEN ('0130') THEN 'HR High Value Ambient Case Pick'
			WHEN ('0200') THEN 'Lane Bulk Case Pick (Top Up)'
			WHEN ('0201') THEN 'Lane Bulk Pallet Pick'
			WHEN ('0240') THEN 'Empties Block Virtual Lanes'
			WHEN ('0280') THEN 'Bread'
			WHEN ('0300') THEN 'HR NF/Food Promo Case Pick'
			WHEN ('0304') THEN 'NF Pushback Pick'
			WHEN ('0306') THEN 'NF Flow Rack Case Pick'
			WHEN ('0310') THEN 'Lane NF/Food Promo Case Pick'
			WHEN ('0311') THEN 'Lane NF/Food Promo Pallet Pick'
			WHEN ('0400') THEN 'Lane 14°C F&V Case Pick'
			WHEN ('0410') THEN 'Lane 04°C F&V Case Pick'
			WHEN ('0500') THEN 'HR Chiller Case Pick'
			WHEN ('0506') THEN 'Flow Rack Chiller Cases'
			WHEN ('0510') THEN 'Lane Chiller Case Pick'
			WHEN ('0511') THEN 'Lane Chiller Pallet Pick'
			WHEN ('0600') THEN 'Lane Meat, Poultry, & Fish Case Pick CW'
			WHEN ('0610') THEN 'Lane MPF Pick - Non CW'
			WHEN ('0700') THEN 'HR Freezer Case Pick'
			WHEN ('0704') THEN 'Freezer Pushback Pick '
			WHEN ('0710') THEN 'HR Bake Off Case Pick'
			WHEN ('0714') THEN 'HR Bake Off Tunnel Case Pick'
			WHEN ('0720') THEN 'Lane Freezer Case Pick'
			WHEN ('0721') THEN 'Lane Freezer Pallet Pick'
			WHEN ('0910') THEN 'Shadow Ambient + Bulk Case Pick'
			WHEN ('0911') THEN 'Shadow Ambient + Bulk Pallet Pick'
			WHEN ('0930') THEN 'Shadow NF/Food Promo Case Pick'
			WHEN ('0931') THEN 'Shadow NF/Food Promo Pallet Pick'
			WHEN ('0940') THEN 'Shadow F&V HU Case Pick'
			WHEN ('0941') THEN 'Shadow F&V Pallet Pick'
			WHEN ('0942') THEN 'Shadow F&V Case Pick'
			WHEN ('0950') THEN 'Shadow Meat, Poultry & Fish Case Pick'
			WHEN ('0951') THEN 'Shadow Meat, Poultry & Fish Pallet Pick'
			WHEN ('0952') THEN 'GR/GI Milk Trolley'
			WHEN ('0953') THEN 'GR/GI Milk Trolley Case Pick'
			WHEN ('0970') THEN 'Shadow Freezer Case Pick'
			WHEN ('0971') THEN 'Shadow Freezer Pallet Pick'
			WHEN ('8100') THEN 'AHR Ambient Tunnel Case Pick'
			WHEN ('8110') THEN 'AHR Hazardous Ambient Tunnel Case Pick'
			WHEN ('8120') THEN 'AHR Chilled Ambient Tunnel Case Pick'
			WHEN ('8142') THEN 'AHR Ambient Replenishment for Tunnel'
			WHEN ('8300') THEN 'AHR NF Tunnel Case Pick'
			WHEN ('EX01') THEN 'Ext. WH 1'
			WHEN ('EX02') THEN 'Ext. WH 2'
			WHEN ('EX03') THEN 'Ext. WH 3'
			ELSE 'Unassigned'
			END AS strg_type_desc
		,CASE strg_type
			WHEN ('0100') THEN 'Ambient'
			WHEN ('0106') THEN 'Ambient'
			WHEN ('0110') THEN 'Ambient'
			WHEN ('0120') THEN 'Ambient'
			WHEN ('0126') THEN 'Ambient'
			WHEN ('0130') THEN 'Ambient'
			WHEN ('0200') THEN 'Bulk'
			WHEN ('0201') THEN 'Bulk'
			WHEN ('0240') THEN 'Bulk'
			WHEN ('0280') THEN 'Bulk'
			WHEN ('0300') THEN 'NF'
			WHEN ('0304') THEN 'NF'
			WHEN ('0306') THEN 'NF'
			WHEN ('0310') THEN 'NF'
			WHEN ('0311') THEN 'NF'
			WHEN ('0400') THEN 'F&V'
			WHEN ('0410') THEN 'F&V'
			WHEN ('0500') THEN 'Chiller'
			WHEN ('0506') THEN 'Chiller'
			WHEN ('0510') THEN 'Chiller'
			WHEN ('0511') THEN 'Chiller'
			WHEN ('0600') THEN 'MPF'
			WHEN ('0610') THEN 'MPF'
			WHEN ('0700') THEN 'Freezer'
			WHEN ('0704') THEN 'Freezer'
			WHEN ('0710') THEN 'Freezer'
			WHEN ('0714') THEN 'Freezer'
			WHEN ('0720') THEN 'Freezer'
			WHEN ('0721') THEN 'Freezer'
			WHEN ('0910') THEN 'Ambient'
			WHEN ('0911') THEN 'Ambient'
			WHEN ('0930') THEN 'NF'
			WHEN ('0931') THEN 'NF'
			WHEN ('0940') THEN 'F&V'
			WHEN ('0941') THEN 'F&V'
			WHEN ('0942') THEN 'F&V'
			WHEN ('0950') THEN 'MPF'
			WHEN ('0951') THEN 'MPF'
			WHEN ('0952') THEN 'MPF'
			WHEN ('0953') THEN 'MPF'
			WHEN ('0970') THEN 'Freezer'
			WHEN ('0971') THEN 'Freezer'
			WHEN ('8100') THEN 'AHR'
			WHEN ('8110') THEN 'AHR'
			WHEN ('8120') THEN 'AHR'
			WHEN ('8142') THEN 'AHR'
			WHEN ('8300') THEN 'AHR'
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
		,CASE WHEN strg_type IN ('8100','8110','8120','8142') THEN bin_cnt*empty_bin ELSE bin_cnt*IFF(is_strg_bin_empty_flg, 1, 0) END AS bin_rem
        ,CASE WHEN strg_type IN ('8100','8110','8120','8142') THEN bin_cnt*total_bin ELSE bin_cnt END AS bin_ges
        ,CASE WHEN strg_type IN ('8100','8110','8120','8142') THEN bin_cnt*occupied_bin ELSE bin_cnt-bin_rem END AS bin_used
		,dwh_load_id
		,dwh_created
		,dwh_updated
		,dwh_valid_from
		,dwh_valid_to
		,deleted_fg
	FROM "DATA".T_SAPEWM_STORAGEBIN_1  
	WHERE strg_type IN ('0100','0106','0110','0120','0126','0130','0200','0201','0240','0280','0300','0304','0306','0310','0311','0400','0410','0500','0506','0510','0511','0600','0610','0700','0704','0710','0714','0720','0721','0910','0911','0930','0931','0940','0941','0942','0950','0951','0952','0953','0970','0971','8100','8110','8120','8142','8300','EX01','EX02','EX03')
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
			WHEN ('0100') THEN 'HR Ambient Case Pick'
			WHEN ('0106') THEN 'HR Ambient Flow Rack Case Pick'
			WHEN ('0110') THEN 'HR Hazardous Ambient Case Pick'
			WHEN ('0120') THEN 'HR Chilled Ambient Case Pick'
			WHEN ('0126') THEN 'HR Chilled Ambient Flow Rack Case Pick'
			WHEN ('0130') THEN 'HR High Value Ambient Case Pick'
			WHEN ('0200') THEN 'Lane Bulk Case Pick (Top Up)'
			WHEN ('0201') THEN 'Lane Bulk Pallet Pick'
			WHEN ('0240') THEN 'Empties Block Virtual Lanes'
			WHEN ('0280') THEN 'Bread'
			WHEN ('0300') THEN 'HR NF/Food Promo Case Pick'
			WHEN ('0304') THEN 'NF Pushback Pick'
			WHEN ('0306') THEN 'NF Flow Rack Case Pick'
			WHEN ('0310') THEN 'Lane NF/Food Promo Case Pick'
			WHEN ('0311') THEN 'Lane NF/Food Promo Pallet Pick'
			WHEN ('0400') THEN 'Lane 14°C F&V Case Pick'
			WHEN ('0410') THEN 'Lane 04°C F&V Case Pick'
			WHEN ('0500') THEN 'HR Chiller Case Pick'
			WHEN ('0506') THEN 'Flow Rack Chiller Cases'
			WHEN ('0510') THEN 'Lane Chiller Case Pick'
			WHEN ('0511') THEN 'Lane Chiller Pallet Pick'
			WHEN ('0600') THEN 'Lane Meat, Poultry, & Fish Case Pick CW'
			WHEN ('0610') THEN 'Lane MPF Pick - Non CW'
			WHEN ('0700') THEN 'HR Freezer Case Pick'
			WHEN ('0704') THEN 'Freezer Pushback Pick '
			WHEN ('0710') THEN 'HR Bake Off Case Pick'
			WHEN ('0714') THEN 'HR Bake Off Tunnel Case Pick'
			WHEN ('0720') THEN 'Lane Freezer Case Pick'
			WHEN ('0721') THEN 'Lane Freezer Pallet Pick'
			WHEN ('0910') THEN 'Shadow Ambient + Bulk Case Pick'
			WHEN ('0911') THEN 'Shadow Ambient + Bulk Pallet Pick'
			WHEN ('0930') THEN 'Shadow NF/Food Promo Case Pick'
			WHEN ('0931') THEN 'Shadow NF/Food Promo Pallet Pick'
			WHEN ('0940') THEN 'Shadow F&V HU Case Pick'
			WHEN ('0941') THEN 'Shadow F&V Pallet Pick'
			WHEN ('0942') THEN 'Shadow F&V Case Pick'
			WHEN ('0950') THEN 'Shadow Meat, Poultry & Fish Case Pick'
			WHEN ('0951') THEN 'Shadow Meat, Poultry & Fish Pallet Pick'
			WHEN ('0952') THEN 'GR/GI Milk Trolley'
			WHEN ('0953') THEN 'GR/GI Milk Trolley Case Pick'
			WHEN ('0970') THEN 'Shadow Freezer Case Pick'
			WHEN ('0971') THEN 'Shadow Freezer Pallet Pick'
			WHEN ('8100') THEN 'AHR Ambient Tunnel Case Pick'
			WHEN ('8110') THEN 'AHR Hazardous Ambient Tunnel Case Pick'
			WHEN ('8120') THEN 'AHR Chilled Ambient Tunnel Case Pick'
			WHEN ('8142') THEN 'AHR Ambient Replenishment for Tunnel'
			WHEN ('8300') THEN 'AHR NF Tunnel Case Pick'
			WHEN ('EX01') THEN 'Ext. WH 1'
			WHEN ('EX02') THEN 'Ext. WH 2'
			WHEN ('EX03') THEN 'Ext. WH 3'
			ELSE 'Unassigned'
			END AS strg_type_desc
		,CASE strg_type
			WHEN ('0100') THEN 'Total'
			WHEN ('0106') THEN 'Total'
			WHEN ('0110') THEN 'Total'
			WHEN ('0120') THEN 'Total'
			WHEN ('0126') THEN 'Total'
			WHEN ('0130') THEN 'Total'
			WHEN ('0200') THEN 'Total'
			WHEN ('0201') THEN 'Total'
			WHEN ('0240') THEN 'Total'
			WHEN ('0280') THEN 'Total'
			WHEN ('0300') THEN 'Total'
			WHEN ('0304') THEN 'Total'
			WHEN ('0306') THEN 'Total'
			WHEN ('0310') THEN 'Total'
			WHEN ('0311') THEN 'Total'
			WHEN ('0400') THEN 'Total'
			WHEN ('0410') THEN 'Total'
			WHEN ('0500') THEN 'Total'
			WHEN ('0506') THEN 'Total'
			WHEN ('0510') THEN 'Total'
			WHEN ('0511') THEN 'Total'
			WHEN ('0600') THEN 'Total'
			WHEN ('0610') THEN 'Total'
			WHEN ('0700') THEN 'Total'
			WHEN ('0704') THEN 'Total'
			WHEN ('0710') THEN 'Total'
			WHEN ('0714') THEN 'Total'
			WHEN ('0720') THEN 'Total'
			WHEN ('0721') THEN 'Total'
			WHEN ('0910') THEN 'Total'
			WHEN ('0911') THEN 'Total'
			WHEN ('0930') THEN 'Total'
			WHEN ('0940') THEN 'Total'
			WHEN ('0931') THEN 'Total'
			WHEN ('0941') THEN 'Total'
			WHEN ('0942') THEN 'Total'
			WHEN ('0950') THEN 'Total'
			WHEN ('0951') THEN 'Total'
			WHEN ('0952') THEN 'Total'
			WHEN ('0953') THEN 'Total'
			WHEN ('0970') THEN 'Total'
			WHEN ('0971') THEN 'Total'
			WHEN ('8100') THEN 'Total'
			WHEN ('8110') THEN 'Total'
			WHEN ('8120') THEN 'Total'
			WHEN ('8142') THEN 'Total'
			WHEN ('8300') THEN 'Total'
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
		,CASE WHEN strg_type IN ('8100','8110','8120','8142') THEN bin_cnt*empty_bin ELSE bin_cnt*IFF(is_strg_bin_empty_flg, 1, 0) END AS bin_rem
        ,CASE WHEN strg_type IN ('8100','8110','8120','8142') THEN bin_cnt*total_bin ELSE bin_cnt END AS bin_ges
        ,CASE WHEN strg_type IN ('8100','8110','8120','8142') THEN bin_cnt*occupied_bin ELSE bin_cnt-bin_rem END AS bin_used
		,dwh_load_id
		,dwh_created
		,dwh_updated
		,dwh_valid_from
		,dwh_valid_to
		,deleted_fg
	FROM "DATA".T_SAPEWM_STORAGEBIN_1  
	WHERE strg_type IN ('0100','0106','0110','0120','0126','0130','0200','0201','0240','0280','0300','0304','0306','0310','0311','0400','0410','0500','0506','0510','0511','0600','0610','0700','0704','0710','0714','0720','0721','0910','0911','0930','0931','0940','0941','0942','0950','0951','0952','0953','0970','0971','8100','8110','8120','8142','8300')
	AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
	AND strg_bin NOT LIKE '%DUMMY_1%'
    AND DELETED_FG = 'FALSE'
;