/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_utilization_add
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


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_utilization_add (client_id
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
WITH HU AS (SELECT client_id,
   wh_id,
   lgpla,
   dwh_valid_from,
   COUNTIF(STARTS_WITH(zz_hutyp_org, 'DD') AND zz_pair_brack = 1) AS cnt_hut_single_dd,
   COUNTIF(STARTS_WITH(zz_hutyp_org, 'DD') AND zz_pair_brack = 2) AS cnt_hut_coupled_dd,
   COUNTIF(LEFT(zz_hutyp_org, 2) IN ('EP', 'SP')) AS cnt_hut_total_ep,
     COUNTIF(STARTS_WITH(zz_hutyp_org, 'DD') AND zz_pair_brack = 1) + COUNTIF(STARTS_WITH(zz_hutyp_org, 'DD') AND
        zz_pair_brack = 2) + COUNTIF(LEFT(zz_hutyp_org, 2) IN ('EP', 'SP')) AS cnt_hut_epae,
   COUNT(huident) AS cnt_hu_ident
  FROM ldl_logop_data.t_sapewm_handlingunitstock
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96), (23, 18))
  GROUP BY client_id,
   wh_id,
   lgpla,
   dwh_valid_from), FBA AS (SELECT client_id,
   wh_id,
   lgpla
  FROM ldl_logop_data.t_sapewm_scwmbinmat
  WHERE (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96)) AND lgtyp = '8100'
   OR (client_id, wh_id) IN ((23, 18))
  GROUP BY client_id,
   wh_id,
   lgpla) (SELECT S.client_id,
   S.wh_id,
   S.lgpla AS strg_bin,
   S.lptyp AS strg_bin_type,
   S.lgtyp AS strg_type,
   S.lgber AS strg_sec,
   S.anzle AS hu_cnt,
   S.kzler AS is_strg_bin_empty_flg,
   S.kzvol AS is_strg_bin_full_flg,
   S.aisle AS strg_bin_aisle,
   S.stack AS strg_bin_stack,
   S.rem_bin_depth,
   S.max_bin_depth,
   S.dwh_valid_from,
   S.dwh_valid_to,
   S.dwh_created,
   S.dwh_updated,
   h.lgpla AS hu_strg_bin,
   h.cnt_hut_single_dd,
   h.cnt_hut_coupled_dd,
   h.cnt_hut_total_ep,
   h.cnt_hut_epae,
   h.cnt_hu_ident,
   IF(S.client_id <> 23 AND S.lgtyp = '8141' OR S.client_id = 23 AND S.lgtyp = '8241', S.max_bin_depth, NULL) AS
   total_bin,
   IF(S.client_id <> 23 AND S.lgtyp = '8141' OR S.client_id = 23 AND S.lgtyp = '8241', S.max_bin_depth - S.rem_bin_depth
     , NULL) AS occupied_bin,
   IF(S.client_id <> 23 AND S.lgtyp = '8141' OR S.client_id = 23 AND S.lgtyp = '8241', S.rem_bin_depth, NULL) AS
   empty_bin,
   IF(S.client_id <> 23 AND S.lgtyp = '8141' OR S.client_id = 23 AND S.lgtyp = '8241', TRUE, FALSE) AS total_ch,
   IF((S.client_id <> 23 AND S.lgtyp = '8141' OR S.client_id = 23 AND S.lgtyp = '8241') AND S.kzler = FALSE, TRUE, FALSE
    ) AS occupied_ch,
   IF((S.client_id <> 23 AND S.lgtyp = '8141' OR S.client_id = 23 AND S.lgtyp = '8241') AND S.kzler = TRUE, TRUE, FALSE
    ) AS empty_ch,
   IF(S.client_id <> 23 AND S.lgtyp = '8100' OR S.client_id = 23 AND S.lgtyp IS NOT NULL, TRUE, FALSE) AS total_pickface
   ,
   IF((S.client_id <> 23 AND S.lgtyp = '8100' OR S.client_id = 23 AND S.lgtyp IS NOT NULL) AND t6.lgpla IS NULL, TRUE,
    FALSE) AS unassigned_pickface
  FROM ldl_logop_data.t_sapewm_storagebin AS S
   LEFT JOIN HU AS h ON S.client_id = h.client_id AND S.wh_id = h.wh_id AND S.lgpla = h.lgpla AND S.dwh_valid_from = h.dwh_valid_from
     
   LEFT JOIN (SELECT DISTINCT *
    FROM FBA AS f) AS t6 ON S.client_id = t6.client_id AND S.wh_id = t6.wh_id AND S.lgpla = t6.lgpla
  WHERE CURRENT_DATE BETWEEN S.dwh_valid_from AND S.dwh_valid_to AND (S.client_id, S.wh_id) IN ((1, 9), (8, 6), (10, 7)
       , (25, 96), (18, 4), (13, 60)) AND S.lgtyp IN ('8141', '8100')
   OR (S.client_id, S.wh_id) = (23, 18) AND S.lgtyp IN ('8241'));