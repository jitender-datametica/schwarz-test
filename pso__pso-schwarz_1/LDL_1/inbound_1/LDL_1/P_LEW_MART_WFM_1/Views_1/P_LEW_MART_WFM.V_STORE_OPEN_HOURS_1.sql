CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORE_OPEN_HOURS_1
AS
/* This SQL pivot the data from v_store_open_hours_base_1 */
SELECT
ptm_latest.country_lidl_cd,
ptm_latest.orig_store_nr,
1            AS weekday,
INSERT(LEFT(ptm_latest.open_time_mo_nrm,4),3,0, ':') AS open_from , 
INSERT(RIGHT(ptm_latest.open_time_mo_nrm,4),3,0, ':') AS open_until
FROM p_lew_mart_wfm.v_store_open_hours_base_1 ptm_latest
WHERE COALESCE(ptm_latest.open_time_mo_nrm, '') <> ''
--null: wenn originalfeld null war; leerstring (''): wenn normierung nichts extrahieren kann (z.b. aus '-' im original) 

UNION ALL
SELECT
ptm_latest.country_lidl_cd,
ptm_latest.orig_store_nr,
2            AS weekday,
INSERT(LEFT(ptm_latest.open_time_tu_nrm,4),3,0, ':') AS open_from,
INSERT(RIGHT(ptm_latest.open_time_tu_nrm,4),3,0, ':') AS open_until
FROM p_lew_mart_wfm.v_store_open_hours_base_1 ptm_latest
WHERE COALESCE(ptm_latest.open_time_tu_nrm, '') <> ''

UNION ALL
SELECT
ptm_latest.country_lidl_cd,
ptm_latest.orig_store_nr,
3            AS weekday,
INSERT(LEFT(ptm_latest.open_time_we_nrm,4),3,0, ':') AS open_from,
INSERT(RIGHT(ptm_latest.open_time_we_nrm,4),3,0, ':') AS open_until
FROM p_lew_mart_wfm.v_store_open_hours_base_1 ptm_latest
WHERE COALESCE(ptm_latest.open_time_we_nrm, '') <> ''

UNION ALL
SELECT
ptm_latest.country_lidl_cd,
ptm_latest.orig_store_nr,
4            AS weekday,
INSERT(LEFT(ptm_latest.open_time_th_nrm,4),3,0, ':') AS open_from,
INSERT(RIGHT(ptm_latest.open_time_th_nrm,4),3,0, ':') AS open_until
FROM p_lew_mart_wfm.v_store_open_hours_base_1 ptm_latest
WHERE COALESCE(ptm_latest.open_time_th_nrm, '') <> ''

UNION ALL
SELECT
ptm_latest.country_lidl_cd,
ptm_latest.orig_store_nr,
5            AS weekday,
INSERT(LEFT(ptm_latest.open_time_fr_nrm,4),3,0, ':') AS open_from,
INSERT(RIGHT(ptm_latest.open_time_fr_nrm,4),3,0, ':') AS open_until
FROM p_lew_mart_wfm.v_store_open_hours_base_1 ptm_latest
WHERE COALESCE(ptm_latest.open_time_fr_nrm, '') <> ''

UNION ALL
SELECT
ptm_latest.country_lidl_cd,
ptm_latest.orig_store_nr,
6            AS weekday,
INSERT(LEFT(ptm_latest.open_time_sa_nrm,4),3,0, ':') AS open_from,
INSERT(RIGHT(ptm_latest.open_time_sa_nrm,4),3,0, ':') AS open_until
FROM p_lew_mart_wfm.v_store_open_hours_base_1 ptm_latest
WHERE COALESCE(ptm_latest.open_time_sa_nrm, '') <> ''

UNION ALL
SELECT
ptm_latest.country_lidl_cd,
ptm_latest.orig_store_nr,
7            AS weekday,
INSERT(LEFT(ptm_latest.open_time_su_nrm,4),3,0, ':') AS open_from,
INSERT(RIGHT(ptm_latest.open_time_su_nrm,4),3,0, ':') AS open_until
FROM p_lew_mart_wfm.v_store_open_hours_base_1 ptm_latest
WHERE COALESCE(ptm_latest.open_time_su_nrm, '') <> ''
;


