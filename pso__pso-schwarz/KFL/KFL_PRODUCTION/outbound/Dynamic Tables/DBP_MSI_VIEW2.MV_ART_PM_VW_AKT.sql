CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_art_pm_vw_akt (
  art_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  vkpk1 BIGNUMERIC(38, 0),
  vkpk10 BIGNUMERIC(38, 0),
  vkpk4 BIGNUMERIC(38, 0)
) AS
SELECT
  art_id AS art_id,
  mandant_id AS mandant_id,
  MAX(vkpk1) AS vkpk1,
  MAX(vkpk10) AS vkpk10,
  MAX(vkpk4) AS vkpk4
FROM (
  SELECT
    art_id,
    mandant_id,
    MAX(CASE WHEN pm_id = 1 THEN vk_brutto ELSE NULL END) AS vkpk1,
    MAX(CASE WHEN pm_id = 10 THEN vk_brutto ELSE NULL END) AS vkpk10,
    MAX(CASE WHEN pm_id = 4 THEN vk_brutto ELSE NULL END) AS vkpk4
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per
  WHERE
    mandant_id = 1
    AND dat_von <= CURRENT_DATE
    AND dat_bis >= CURRENT_DATE
    AND pm_id IN (1, 4, 10)
    AND preistyp_id = 0
  GROUP BY
    art_id,
    mandant_id,
    dat_von
) AS t2
GROUP BY
  art_id,
  mandant_id;
