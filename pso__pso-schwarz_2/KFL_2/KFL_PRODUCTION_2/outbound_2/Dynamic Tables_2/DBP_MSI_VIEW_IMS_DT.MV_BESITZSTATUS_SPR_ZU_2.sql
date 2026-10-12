CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_besitzstatus_spr_zu_2 (
  eigentum_kz INT64,
  eigentum_bez STRING(8),
  eigentum_kbez STRING(1)
) AS
SELECT
  CASE
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 1
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN 0
    ELSE -1
  END AS eigentum_kz,
  CASE
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 'Eigentum'
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN 'Miete'
    ELSE ''
  END AS eigentum_bez,
  CASE
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 'E'
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN 'M'
    ELSE ''
  END AS eigentum_kbez
FROM kfl_production_dbp_view.v_tag_2
WHERE
  dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY) AND (
    CURRENT_DATE
  );
