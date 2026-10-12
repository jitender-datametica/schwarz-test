CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artikel_vkpreis_2 (
  art_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  umrechnungskurs BIGNUMERIC(38, 5),
  `_vkpk1` BIGNUMERIC(38, 0),
  `_vkpk2` BIGNUMERIC(38, 0),
  `_vkpk3` BIGNUMERIC(38, 0),
  `_vkpk4` BIGNUMERIC(38, 0),
  `_vkpk5` BIGNUMERIC(38, 0),
  `_vkpk6` BIGNUMERIC(38, 0),
  `_vkpk7` BIGNUMERIC(38, 0),
  `_vkpk8` BIGNUMERIC(38, 0),
  `_vkpk9` BIGNUMERIC(38, 0),
  `_vkpk10` BIGNUMERIC(38, 0),
  mwst NUMERIC(12, 2)
) AS
SELECT
  v01.art_id AS art_id,
  v01.mandant_id AS mandant_id,
  v300.umrechnungskurs AS umrechnungskurs,
  v02.`_vkpk1` AS _vkpk1,
  v02.`_vkpk2` AS _vkpk2,
  v02.`_vkpk3` AS _vkpk3,
  v02.`_vkpk4` AS _vkpk4,
  v02.`_vkpk5` AS _vkpk5,
  v02.`_vkpk6` AS _vkpk6,
  v02.`_vkpk7` AS _vkpk7,
  v02.`_vkpk8` AS _vkpk8,
  v02.`_vkpk9` AS _vkpk9,
  v02.`_vkpk10` AS _vkpk10,
  v03.mwst AS mwst
FROM kfl_production_dbp_view.v_art_2 AS v01
LEFT JOIN (
  SELECT
    art_id,
    mandant_id,
    MAX(CASE WHEN pm_id = 1 THEN vk_brutto ELSE NULL END) AS `_vkpk1`,
    MAX(CASE WHEN pm_id = 2 THEN vk_brutto ELSE NULL END) AS `_vkpk2`,
    MAX(CASE WHEN pm_id = 3 THEN vk_brutto ELSE NULL END) AS `_vkpk3`,
    MAX(CASE WHEN pm_id = 4 THEN vk_brutto ELSE NULL END) AS `_vkpk4`,
    MAX(CASE WHEN pm_id = 5 THEN vk_brutto ELSE NULL END) AS `_vkpk5`,
    MAX(CASE WHEN pm_id = 6 THEN vk_brutto ELSE NULL END) AS `_vkpk6`,
    MAX(CASE WHEN pm_id = 7 THEN vk_brutto ELSE NULL END) AS `_vkpk7`,
    MAX(CASE WHEN pm_id = 8 THEN vk_brutto ELSE NULL END) AS `_vkpk8`,
    MAX(CASE WHEN pm_id = 9 THEN vk_brutto ELSE NULL END) AS `_vkpk9`,
    MAX(CASE WHEN pm_id = 10 THEN vk_brutto ELSE NULL END) AS `_vkpk10`
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_2
  WHERE
    CURRENT_DATE BETWEEN dat_von AND dat_bis AND mandant_id <> 1 AND preistyp_id = 0
  GROUP BY
    art_id,
    mandant_id
) AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.art_id = v02.art_id
LEFT JOIN kfl_production_dbp_view.v_mwst_per_2 AS v03
  ON v03.dat_bis = CAST('9999-12-31' AS DATE)
  AND v01.mwst_id = v03.mwst_id
  AND v01.mandant_id = v03.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant_2 AS v100
  ON v01.mandant_id = v100.mandant_id
INNER JOIN kfl_production_dbp_view.v_kurs_2 AS v300
  ON v300.dat_bis = CAST('9999-12-31' AS DATE)
  AND v100.default_wrg = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR'
WHERE
  v01.mandant_id <> 1;
