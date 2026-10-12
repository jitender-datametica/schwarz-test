CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_bedienung_spr_zu_cz_2 (
  bed_fg INT64,
  bed_bez STRING(4),
  bed_kbez STRING(1)
) AS
SELECT
  CASE
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 1
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN -1
    ELSE 0
  END AS bed_fg,
  CASE
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 'Ja'
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN ''
    ELSE 'Nein'
  END AS bed_bez,
  CASE WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY) THEN 'J' ELSE '' END AS bed_kbez
FROM kfl_production_dbp_view.v_tag_2
WHERE
  dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY) AND (
    CURRENT_DATE
  );
