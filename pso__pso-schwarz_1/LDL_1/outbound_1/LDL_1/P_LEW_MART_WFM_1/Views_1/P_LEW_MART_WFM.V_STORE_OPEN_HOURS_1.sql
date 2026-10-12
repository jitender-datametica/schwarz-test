/* This SQL pivot the data from v_store_open_hours_base_1 */ 
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_store_open_hours_1
AS SELECT country_lidl_cd,
 orig_store_nr,
 1 AS weekday,
 CONCAT(LEFT(open_time_mo_nrm, 2), ':', SUBSTR(open_time_mo_nrm, 3, 2)) AS open_from,
 CONCAT(SUBSTR(open_time_mo_nrm, 5, 2), ':', SUBSTR(open_time_mo_nrm, 7, 2)) AS open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_base_1 AS PTM_LATEST
WHERE COALESCE(open_time_mo_nrm, ' ') <> ' '
UNION ALL
SELECT country_lidl_cd,
 orig_store_nr,
 2 AS weekday,
 CONCAT(LEFT(open_time_tu_nrm, 2), ':', SUBSTR(open_time_tu_nrm, 3, 2)) AS open_from,
 CONCAT(SUBSTR(open_time_tu_nrm, 5, 2), ':', SUBSTR(open_time_tu_nrm, 7, 2)) AS open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_base_1 AS PTM_LATEST
WHERE COALESCE(open_time_tu_nrm, ' ') <> ' '
UNION ALL
SELECT country_lidl_cd,
 orig_store_nr,
 3 AS weekday,
 CONCAT(LEFT(open_time_we_nrm, 2), ':', SUBSTR(open_time_we_nrm, 3, 2)) AS open_from,
 CONCAT(SUBSTR(open_time_we_nrm, 5, 2), ':', SUBSTR(open_time_we_nrm, 7, 2)) AS open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_base_1 AS PTM_LATEST
WHERE COALESCE(open_time_we_nrm, ' ') <> ' '
UNION ALL
SELECT country_lidl_cd,
 orig_store_nr,
 4 AS weekday,
 CONCAT(LEFT(open_time_th_nrm, 2), ':', SUBSTR(open_time_th_nrm, 3, 2)) AS open_from,
 CONCAT(SUBSTR(open_time_th_nrm, 5, 2), ':', SUBSTR(open_time_th_nrm, 7, 2)) AS open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_base_1 AS PTM_LATEST
WHERE COALESCE(open_time_th_nrm, ' ') <> ' '
UNION ALL
SELECT country_lidl_cd,
 orig_store_nr,
 5 AS weekday,
 CONCAT(LEFT(open_time_fr_nrm, 2), ':', SUBSTR(open_time_fr_nrm, 3, 2)) AS open_from,
 CONCAT(SUBSTR(open_time_fr_nrm, 5, 2), ':', SUBSTR(open_time_fr_nrm, 7, 2)) AS open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_base_1 AS PTM_LATEST
WHERE COALESCE(open_time_fr_nrm, ' ') <> ' '
UNION ALL
SELECT country_lidl_cd,
 orig_store_nr,
 6 AS weekday,
 CONCAT(LEFT(open_time_sa_nrm, 2), ':', SUBSTR(open_time_sa_nrm, 3, 2)) AS open_from,
 CONCAT(SUBSTR(open_time_sa_nrm, 5, 2), ':', SUBSTR(open_time_sa_nrm, 7, 2)) AS open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_base_1 AS PTM_LATEST
WHERE COALESCE(open_time_sa_nrm, ' ') <> ' '
UNION ALL
SELECT country_lidl_cd,
 orig_store_nr,
 7 AS weekday,
 CONCAT(LEFT(open_time_su_nrm, 2), ':', SUBSTR(open_time_su_nrm, 3, 2)) AS open_from,
 CONCAT(SUBSTR(open_time_su_nrm, 5, 2), ':', SUBSTR(open_time_su_nrm, 7, 2)) AS open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_base_1 AS PTM_LATEST
WHERE COALESCE(open_time_su_nrm, ' ') <> ' ';
