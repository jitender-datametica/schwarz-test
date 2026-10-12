/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_stockoverview_stocktype_add_2
Description		|	SAP EWM Stock Overview - view with additional columns
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_STOCKOVERVIEW_STOCKTYPE_ADD_2(
	CLIENT_ID COMMENT 'Client ID (PK)'
	,WH_ID COMMENT 'Warehouse ID (PK)'
	,STRG_BIN COMMENT 'Storage bin'
	,STRG_TYPE COMMENT 'Storage type'
	,STRG_BIN_AISLE COMMENT 'Storage bin aisle'
	,DWH_VALID_FROM COMMENT 'Valid from date (PK)'
	,DWH_CREATED COMMENT 'DWH creation timestamp'
	,DWH_UPDATED COMMENT 'DWH update timestamp'
	,HU_IDENT COMMENT 'Handling unit_2 ID (PK)'
	,ZZ_HU_TYPE COMMENT 'Handling unit_2 type'
	,SORTED_NON_FOOD_FLG COMMENT 'Sorted non-food flag'
	,PAIR_BRACKET COMMENT 'Pair bracket'
	,SYS_PAL COMMENT 'System pallet'
	,PROD_DESC_FG COMMENT 'Product description Flag'
	,PACI COMMENT 'Putaway control indicator (Einlagersteuerkennzeichen)'
	,HU_EPA COMMENT 'Calculated EPA of handling unit_2 (Europalettenaequivalente)'
	,ASSORT_AREA_ID COMMENT 'Identified assortment area'
	,HU_TYPE_EP COMMENT 'Identified handling unit_2 type for EP'
	,HU_TYPE_EP_SP COMMENT 'Identified handling unit_2 type for EP with SP'
	,HU_TYPE_SINGLE_DD COMMENT 'Identified handling unit_2 type for DD single'
	,HU_TYPE_COUPLED_DD COMMENT 'Identified handling unit_2 type for DD coupled'
) AS
WITH strgbinphystk AS (
    SELECT DISTINCT v01.client_id 
            ,v01.wh_id
            ,v01.lgpla 
            ,v01.huident
            ,v01.logpos
            ,IFF(STARTSWITH(v02.maktx, 'NFBC'),1,0) AS prod_desc_fg
            ,v02.put_stra AS paci
            ,v01.dwh_valid_from
        FROM DATA.T_SAPEWM_PHYSICALSTOCK_2 v01 
        LEFT JOIN DATA.T_SAPEWM_WAREHOUSEATTRIBUTE_2 v02 
		ON v01.client_id = v02.client_id
			AND v01.wh_id = v02.wh_id
			AND v01.matnr = v02.matnr		
			AND CURRENT_DATE BETWEEN v02.dwh_valid_from AND v02.dwh_valid_to
        WHERE CURRENT_DATE BETWEEN v01.dwh_valid_from AND v01.dwh_valid_to
)
SELECT
	s.client_id
	,s.wh_id
	,s.lgpla AS strg_bin
	,s.lgtyp AS strg_type
	,s.aisle AS strg_bin_aisle
	,s.dwh_valid_from
	,s.dwh_created
	,s.dwh_updated
	,h.huident AS hu_ident
	,h.zz_hutyp_org AS zz_hu_type
	,h.zz_hu_sorted AS sorted_non_food_flg
	,h.zz_pair_brack AS pair_bracket
	,h.zz_sys_pal AS sys_pal
	,w.prod_desc_fg
	,w.paci 
	,DECODE(h.zz_pair_brack, 0, 1, 2, 1, 1, 0.5) AS hu_epa 
	,CASE 
		WHEN w.paci IN ('I100', 'I110') THEN 1 
		WHEN s.client_id <> 23 AND w.paci = 'I120' THEN 2
		WHEN s.client_id = 23 AND w.paci = 'I110' THEN 2 		
		WHEN w.paci IN ('I200', 'I201') THEN 3 
		WHEN w.prod_desc_fg =  1 THEN 4 
		WHEN w.paci = 'I300' AND h.zz_hu_sorted = 'X' THEN 5 
		WHEN w.paci = 'I300' AND NVL(h.zz_hu_sorted, '') <> 'X' THEN 6 
		WHEN STARTSWITH(h.huident, '92') THEN 7 
		WHEN STARTSWITH(h.huident, '94') THEN 8 
		WHEN STARTSWITH(h.huident, '96') THEN 9 
		WHEN w.paci = 'I500' THEN 10 
		WHEN w.paci = 'I800' THEN 11 
		ELSE NULL
	END AS assort_area_id 	
	,CASE
		WHEN STARTSWITH(h.zz_hutyp_org, 'EP') THEN TRUE
		ELSE FALSE
	END AS hu_type_ep 
	,CASE
		WHEN STARTSWITH(h.zz_hutyp_org, 'EP') AND h.zz_sys_pal = 2 THEN TRUE
		ELSE FALSE
	END AS hu_type_ep_sp 
	,CASE
		WHEN STARTSWITH(h.zz_hutyp_org, 'DD') AND h.zz_pair_brack = 1 THEN TRUE
		ELSE FALSE
	END AS hu_type_single_dd 
	,CASE
		WHEN STARTSWITH(h.zz_hutyp_org, 'DD') AND h.zz_pair_brack = 2 THEN TRUE
		ELSE FALSE
	END AS hu_type_coupled_dd 
FROM DATA.T_SAPEWM_STORAGEBIN_2 s 
	LEFT JOIN DATA.T_SAPEWM_HANDLINGUNITSTOCK_2 h 
		ON s.client_id = h.client_id
			AND s.wh_id = h.wh_id
			AND s.lgpla = h.lgpla 
		--	AND s.dwh_valid_from = h.dwh_valid_from removed as it filtered out records needed - we shouldnt join on tech columns anyway
			AND CURRENT_DATE = TO_DATE(h.dwh_updated) -- Included trying to identify only the LIVE records
 	LEFT JOIN strgbinphystk w 
		ON h.client_id = w.client_id
			AND s.wh_id = h.wh_id
			AND h.lgpla = w.lgpla 
            AND h.huident = w.huident
	WHERE CURRENT_DATE BETWEEN s.dwh_valid_from AND s.dwh_valid_to
	AND CURRENT_DATE BETWEEN h.dwh_valid_from AND h.dwh_valid_to AND h.deleted_fg = FALSE
  AND (((s.client_id, s.wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96), (18,4), (13,60)) 
      AND s.lgtyp = '8141')
      OR 
      ((s.client_id, s.wh_id) = (23,18) AND s.lgtyp = '8241'))
  AND (NOT STARTSWITH(h.huident, '92') OR h.created_by = 'RFC-MFS')
  ;