/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_bintype_add
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-22		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	View with additional columns for SAP EWM stock overview report bin type
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_bintype_add (client_id
OPTIONS(description='Client ID (PK)'), lidl_ctry OPTIONS(description='Country code'), wh_id
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
OPTIONS(description='Empty bins'), strg_bin_cat OPTIONS(description='Storage bin category')) AS SELECT client_id,
 lidl_country AS lidl_ctry,
 wh_id,
 lgpla AS strg_bin,
 lptyp AS strg_bin_type,
 lgtyp AS strg_type,
 lgber AS strg_sec,
 bin_at AS bin_acs_type,
 kzler AS is_strg_bin_empty_flg,
 kzvol AS is_strg_bin_full_flg,
 aisle AS strg_bin_aisle,
 stack AS strg_bin_stack,
 lvl_v AS strg_bin_level,
 rem_bin_depth,
 max_bin_depth,
 dwh_valid_from,
 dwh_valid_to,
 ivnum AS pi_doc_nr,
 dwh_created,
 dwh_updated,
 IF(client_id <> 23 AND lgtyp = '8141' OR client_id = 23 AND lgtyp = '8241', max_bin_depth, NULL) AS total_bin,
 IF(client_id <> 23 AND lgtyp = '8141' OR client_id = 23 AND lgtyp = '8241', max_bin_depth - rem_bin_depth, NULL) AS
 occupied_bin,
 IF(client_id <> 23 AND lgtyp = '8141' OR client_id = 23 AND lgtyp = '8241', rem_bin_depth, NULL) AS empty_bin,
  CASE
  WHEN client_id = 23
  THEN IF(STARTS_WITH(lptyp, 'T'), 'HK' || SUBSTR(lptyp, 2, 1) || '/KK' || SUBSTR(lptyp, 3, 2), NULL)
  ELSE IF(STARTS_WITH(lptyp, 'P'), 'GK' || SUBSTR(lptyp, 3, 1) || '/HK' || SUBSTR(lptyp, 2, 1), NULL)
  END AS strg_bin_cat
FROM ldl_logop_data.t_sapewm_storagebin
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to AND (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96)
     , (18, 4), (13, 60)) AND lgtyp IN ('8141', '8142')
 OR (client_id, wh_id) = (23, 18) AND lgtyp = '8241' AND CASE
   WHEN client_id = 23
   THEN IF(STARTS_WITH(lptyp, 'T'), 'HK' || SUBSTR(lptyp, 2, 1) || '/KK' || SUBSTR(lptyp, 3, 2), NULL)
   ELSE IF(STARTS_WITH(lptyp, 'P'), 'GK' || SUBSTR(lptyp, 3, 1) || '/HK' || SUBSTR(lptyp, 2, 1), NULL)
   END IS NOT NULL;