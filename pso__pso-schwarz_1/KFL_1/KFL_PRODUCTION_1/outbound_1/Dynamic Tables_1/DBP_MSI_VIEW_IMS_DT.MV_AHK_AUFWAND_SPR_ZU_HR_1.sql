CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_ahk_aufwand_spr_zu_hr_1 (
  ahk_aufwand_id INT64,
  ahk_aufwand_bez STRING(8)
) AS
SELECT
  CASE
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 1
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN 0
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '3' DAY)
    THEN 2
    ELSE -1
  END AS ahk_aufwand_id,
  CASE
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY)
    THEN 'AHK'
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '2' DAY)
    THEN 'Aufwand'
    WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL '3' DAY)
    THEN 'AiB'
    ELSE 'Sonstige'
  END AS ahk_aufwand_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE
  dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL '3' DAY) AND (
    CURRENT_DATE
  );
