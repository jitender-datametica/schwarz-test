CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_jahr_kj
AS
SELECT kj,
 akt_kj,
 akt_kj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_jahr_kj
WHERE kj >= 2005
 AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);