CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artikel_vkpreis (art_id, mandant_id, vkpk1, vkpk1_netto,
vkpk2, vkpk3, vkpk4, vkpk4_netto, vkpk5, vkpk6, vkpk7, vkpk8, vkpk9, vkpk10, mwst) AS SELECT V01.art_id,
 V01.mandant_id,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk1` * V300.umrechnungskurs
   ELSE v02.`_vkpk1`
   END AS NUMERIC) AS vkpk1,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk1` * V300.umrechnungskurs / (1.000 + V03.mwst / 100.000)
   ELSE v02.`_vkpk1` / (1.000 + V03.mwst / 100.000)
   END AS NUMERIC) AS vkpk1_netto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk2` * V300.umrechnungskurs
   ELSE v02.`_vkpk2`
   END AS NUMERIC) AS vkpk2,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk3` * V300.umrechnungskurs
   ELSE v02.`_vkpk3`
   END AS NUMERIC) AS vkpk3,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk4` * V300.umrechnungskurs
   ELSE v02.`_vkpk4`
   END AS NUMERIC) AS vkpk4,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk4` * V300.umrechnungskurs / (1.000 + V03.mwst / 100.000)
   ELSE v02.`_vkpk4` / (1.000 + V03.mwst / 100.000)
   END AS NUMERIC) AS vkpk4_netto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk5` * V300.umrechnungskurs
   ELSE v02.`_vkpk5`
   END AS NUMERIC) AS vkpk5,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk6` * V300.umrechnungskurs
   ELSE v02.`_vkpk6`
   END AS NUMERIC) AS vkpk6,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk7` * V300.umrechnungskurs
   ELSE v02.`_vkpk7`
   END AS NUMERIC) AS vkpk7,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk8` * V300.umrechnungskurs
   ELSE v02.`_vkpk8`
   END AS NUMERIC) AS vkpk8,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk9` * V300.umrechnungskurs
   ELSE v02.`_vkpk9`
   END AS NUMERIC) AS vkpk9,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN v02.`_vkpk10` * V300.umrechnungskurs
   ELSE v02.`_vkpk10`
   END AS NUMERIC) AS vkpk10,
 V03.mwst
FROM kfl_production_dbp_view.v_art AS V01
 LEFT JOIN (SELECT art_id,
   mandant_id,
   MAX(CASE
     WHEN pm_id = 1
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk1`,
   MAX(CASE
     WHEN pm_id = 2
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk2`,
   MAX(CASE
     WHEN pm_id = 3
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk3`,
   MAX(CASE
     WHEN pm_id = 4
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk4`,
   MAX(CASE
     WHEN pm_id = 5
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk5`,
   MAX(CASE
     WHEN pm_id = 6
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk6`,
   MAX(CASE
     WHEN pm_id = 7
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk7`,
   MAX(CASE
     WHEN pm_id = 8
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk8`,
   MAX(CASE
     WHEN pm_id = 9
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk9`,
   MAX(CASE
     WHEN pm_id = 10
     THEN vk_brutto
     ELSE NULL
     END) AS `_vkpk10`
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per
  WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
   AND preistyp_id = 0
  GROUP BY art_id,
   mandant_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id
 LEFT JOIN kfl_production_dbp_view.v_mwst_per AS V03 ON V03.dat_bis = DATE '9999-12-31' AND V01.mwst_id = V03.mwst_id
  AND V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V100.default_wrg = V300.von_wrg_id
      AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR';