/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_utilization_add_2
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-06		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	View with additional columns for SAP EWM stock overview report utilization
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_STOCKOVERVIEW_UTILIZATION_ADD_2(
	CLIENT_ID COMMENT 'Client ID (PK)'
	,WH_ID COMMENT 'Warehouse ID (PK)'
	,STRG_BIN COMMENT 'Storage bin (PK)'
	,STRG_BIN_TYPE COMMENT 'Storage bin type'
	,STRG_TYPE COMMENT 'Storage type'
	,STRG_SEC COMMENT 'Storage section'
	,HU_CNT COMMENT 'Number of handling units in storage bin'
	,IS_STRG_BIN_EMPTY_FLG COMMENT 'Storage bin is empty'
	,IS_STRG_BIN_FULL_FLG COMMENT 'Storage bin is full'
	,STRG_BIN_AISLE COMMENT 'Storage bin aisle'
	,STRG_BIN_STACK COMMENT 'Storage bin stack'
	,REM_BIN_DEPTH COMMENT 'Remaining bin depth'
	,MAX_BIN_DEPTH COMMENT 'Maximum bin depth'
	,DWH_VALID_FROM COMMENT 'Valid from date (PK)'
	,DWH_VALID_TO COMMENT 'Valid to date'
	,DWH_CREATED COMMENT 'DWH creation timestamp'
	,DWH_UPDATED COMMENT 'DWH update timestamp'
	,HU_STRG_BIN COMMENT 'Storage bin of handling unit_2 data that matches'
	,CNT_HUT_SINGLE_DD COMMENT 'Number of records with handling unit_2 type DD single per storage bin'
	,CNT_HUT_COUPLED_DD COMMENT 'Number of records with handling unit_2 type DD coupled per storage bin'
	,CNT_HUT_TOTAL_EP COMMENT 'Number of records with handling unit_2 type EP and SP per storage bin'
	,CNT_HUT_EPAE COMMENT 'Total of records with any of those three handling unit_2 types (DD single, DD coupled and EP & SP)'
	,CNT_HU_IDENT COMMENT 'Number of handling unit_2 IDs (PK) per storage bin (only to see how many data records have been aggregated)'
	,TOTAL_BIN COMMENT 'Total bins'
	,OCCUPIED_BIN COMMENT 'Occupied bins'
	,EMPTY_BIN COMMENT 'Empty bins'
	,TOTAL_CH COMMENT 'Total channel which is equal to all storage bins with storage type 8141 without considering empty indicators'
	,OCCUPIED_CH COMMENT 'Occupied channel which is all storage bins with storage type 8141 and empty indicator not true'
	,EMPTY_CH COMMENT 'Empty channel which is all storage bins with storage type 8141 and empty indicator true '
	,TOTAL_PICKFACE COMMENT 'Total pickface'
	,UNASSIGNED_PICKFACE COMMENT 'Unassigned pickface'
) AS
WITH
hu AS (
    SELECT 
        client_id
        ,wh_id
        ,lgpla
        ,dwh_valid_from
        ,COUNT_IF(STARTSWITH(zz_hutyp_org, 'DD') AND zz_pair_brack = 1) AS cnt_hut_single_dd
        ,COUNT_IF(STARTSWITH(zz_hutyp_org, 'DD') AND zz_pair_brack = 2) AS cnt_hut_coupled_dd
        ,COUNT_IF(LEFT(zz_hutyp_org, 2) IN ('EP', 'SP')) AS cnt_hut_total_ep
        ,cnt_hut_single_dd + cnt_hut_coupled_dd + cnt_hut_total_ep AS cnt_hut_epae
        ,COUNT(huident) AS cnt_hu_ident
    FROM DATA.T_SAPEWM_HANDLINGUNITSTOCK_2
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
        AND (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96), (23, 18))
    GROUP BY client_id, wh_id, lgpla, dwh_valid_from
),
fba AS (
    SELECT DISTINCT
        client_id
        ,wh_id
        ,lgpla
        --,dwh_valid_from
    FROM DATA.T_SAPEWM_SCWMBINMAT_2 
    WHERE 
	--CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to AND
		((client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96)) AND lgtyp = '8100')
		OR (client_id, wh_id) IN ((23, 18))		       
)
SELECT
    s.client_id
    ,s.wh_id
    ,s.lgpla AS strg_bin
    ,s.lptyp AS strg_bin_type
    ,s.lgtyp AS strg_type
    ,s.lgber AS strg_sec
    ,s.anzle AS hu_cnt
    ,s.kzler AS is_strg_bin_empty_flg
    ,s.kzvol AS is_strg_bin_full_flg
    ,s.aisle AS strg_bin_aisle
    ,s.stack AS strg_bin_stack
    ,s.rem_bin_depth
    ,s.max_bin_depth
    ,s.dwh_valid_from
    ,s.dwh_valid_to
    ,s.dwh_created
    ,s.dwh_updated
    ,h.lgpla AS hu_strg_bin
    ,h.cnt_hut_single_dd
    ,h.cnt_hut_coupled_dd
    ,h.cnt_hut_total_ep
    ,h.cnt_hut_epae
    ,h.cnt_hu_ident
    ,IFF(((s.client_id <> 23 AND s.lgtyp = '8141') OR (s.client_id = 23 AND s.lgtyp = '8241')), s.max_bin_depth, NULL) AS total_bin
    ,IFF(((s.client_id <> 23 AND s.lgtyp = '8141') OR (s.client_id = 23 AND s.lgtyp = '8241')), s.max_bin_depth - s.rem_bin_depth, NULL) AS occupied_bin
    ,IFF(((s.client_id <> 23 AND s.lgtyp = '8141') OR (s.client_id = 23 AND s.lgtyp = '8241')), rem_bin_depth, NULL) AS empty_bin
    ,IFF(((s.client_id <> 23 AND s.lgtyp = '8141') OR (s.client_id = 23 AND s.lgtyp = '8241')), TRUE, FALSE) AS total_ch
    ,IFF(((s.client_id <> 23 AND s.lgtyp = '8141') OR (s.client_id = 23 AND s.lgtyp = '8241')) AND is_strg_bin_empty_flg = FALSE, TRUE, FALSE) AS occupied_ch
    ,IFF(((s.client_id <> 23 AND s.lgtyp = '8141') OR (s.client_id = 23 AND s.lgtyp = '8241')) AND is_strg_bin_empty_flg = TRUE, TRUE, FALSE) AS empty_ch
    ,IFF(((s.client_id <> 23 AND s.lgtyp = '8100') OR (s.client_id = 23 AND s.lgtyp IS NOT NULL)), TRUE, FALSE) AS total_pickface
	,IFF(((s.client_id <> 23 AND s.lgtyp = '8100') OR (s.client_id = 23 AND s.lgtyp IS NOT NULL)) AND f.lgpla IS NULL, TRUE, FALSE) AS unassigned_pickface   
FROM DATA.T_SAPEWM_STORAGEBIN_2 s
    LEFT JOIN hu h
        ON s.client_id = h.client_id
        AND s.wh_id = h.wh_id
        AND s.lgpla = h.lgpla
        AND s.dwh_valid_from = h.dwh_valid_from
    LEFT JOIN fba f
        ON s.client_id = f.client_id
        AND s.wh_id = f.wh_id
        AND s.lgpla = f.lgpla
        --AND s.dwh_valid_from = f.dwh_valid_from
WHERE CURRENT_DATE BETWEEN s.dwh_valid_from AND s.dwh_valid_to
    AND ((s.client_id, s.wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96), (18,4), (13,60)) AND s.lgtyp IN ('8141', '8100'))
    OR ((s.client_id, s.wh_id) = (23,18) AND s.lgtyp IN ('8241'))
;