CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_l_belastungs_kz (
  belastungs_kz STRING(1)
) AS
SELECT
  CASE
    WHEN dat = CURRENT_DATE
    THEN 'A'
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 'H'
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN 'L'
    ELSE 'S'
  END AS belastungs_kz
FROM kfl_production_dbp_view.v_tag
WHERE
  dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL '3' DAY) AND (
    CURRENT_DATE
  );
