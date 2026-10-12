CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu (USERID STRING) AS SELECT DISTINCT user_id,
 ek_anzeige_fg
FROM kfl_production_dbp_security.user_ek_anzeige_zu AS V01
WHERE user_id = USERID;
