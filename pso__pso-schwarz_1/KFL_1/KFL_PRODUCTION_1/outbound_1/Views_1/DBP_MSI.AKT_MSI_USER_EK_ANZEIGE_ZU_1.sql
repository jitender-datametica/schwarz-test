-- 2023-07-17 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_1(USERID STRING)AS SELECT DISTINCT
 user_id,
 ek_anzeige_fg
FROM kfl_production_dbp_security.user_ek_anzeige_zu_1 AS V01
WHERE user_id = USERID;