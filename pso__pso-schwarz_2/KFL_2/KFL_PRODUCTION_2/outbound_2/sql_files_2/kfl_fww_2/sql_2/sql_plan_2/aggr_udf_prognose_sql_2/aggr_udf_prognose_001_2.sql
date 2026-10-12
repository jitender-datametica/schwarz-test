--aktion_list


CREATE OR REPLACE TEMPORARY TABLE _aaw AS
SELECT mandant_id,
 wup_id,
 art_id,
 aktion_id
FROM dbp_data.aktion_art_wup_zu_2
WHERE mandant_id <> 1 AND dat_preisaktiviert <> DATE '1900-01-01' AND vk_aktion_brutto > 0
 OR mandant_id = 1 AND dat_sperrung IS NULL;


CREATE OR REPLACE TEMPORARY TABLE _a AS
SELECT aktion.aktion_id,
 aktion.mandant_id,
 T.dat
FROM dbp_data.aktion_2
 INNER JOIN dbp_data.tag_2 AS T ON T.dat BETWEEN aktion.dat_von AND aktion.dat_bis;


CREATE OR REPLACE TEMPORARY TABLE _aktion_list AS
SELECT DISTINCT AAW.mandant_id,
 AAW.wup_id,
 AAW.art_id,
 A.dat,
 1 AS aktionslistung_fg
FROM `_aaw` AS AAW
 INNER JOIN `_a` AS A ON AAW.aktion_id = A.aktion_id AND AAW.mandant_id = A.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _p_udf_aktion AS WITH `_P_UDF` AS (SELECT mandant_id,
   wup_id,
   nb_id,
   art_id,
   dat,
   dat_prognoselauf,
   prognose_horizont,
   menge_prognose_sa,
   menge_prognose_af,
   menge_prognose_gesteuert
  FROM dbp_data.udf_prognose_2
  WHERE diagnose_id = '') (SELECT p_udf.mandant_id,
   p_udf.wup_id,
   p_udf.nb_id,
   p_udf.art_id,
   p_udf.dat,
   p_udf.dat_prognoselauf,
   MAX(p_udf.prognose_horizont) AS prognose_horizont,
   SUM(p_udf.menge_prognose_sa) AS menge_prognose_sa_udf,
   SUM(p_udf.menge_prognose_af) AS menge_prognose_af_udf,
   SUM(CASE
     WHEN p_udf.menge_prognose_sa IS NULL AND p_udf.menge_prognose_af IS NULL
     THEN NULL
     ELSE COALESCE(p_udf.menge_prognose_sa, 0) + COALESCE(p_udf.menge_prognose_af, 0)
     END) AS menge_prognose,
   SUM(CASE
     WHEN AKTION_LIST.aktionslistung_fg = 1
     THEN p_udf.menge_prognose_gesteuert
     ELSE NULL
     END) AS menge_prognose_sa_udf_gesteuert,
   SUM(CASE
     WHEN AKTION_LIST.aktionslistung_fg IS NULL
     THEN p_udf.menge_prognose_gesteuert
     ELSE NULL
     END) AS menge_prognose_af_udf_gesteuert,
   SUM(p_udf.menge_prognose_gesteuert) AS menge_prognose_gesteuert
  FROM `_P_UDF` AS p_udf
   LEFT JOIN `_aktion_list` AS AKTION_LIST ON p_udf.mandant_id = AKTION_LIST.mandant_id AND p_udf.wup_id = AKTION_LIST.wup_id
        AND p_udf.art_id = AKTION_LIST.art_id AND p_udf.dat = AKTION_LIST.dat
  WHERE p_udf.dat BETWEEN DATE_SUB(DATE(${DAT_KALK}), INTERVAL 3 DAY) AND (DATE(${DAT_KALK}))
  GROUP BY p_udf.mandant_id,
   p_udf.wup_id,
   p_udf.nb_id,
   p_udf.art_id,
   p_udf.dat,
   p_udf.dat_prognoselauf);


CREATE OR REPLACE TEMPORARY TABLE _udf_pass AS WITH `_ARTBEW` AS (SELECT dat,
   art_id,
   mandant_id,
   nb_id,
   wup_id,
   SUM(menge) AS vk_menge,
   SUM(CASE
     WHEN bewart_id = 1002
     THEN menge
     ELSE NULL
     END) AS vk_menge_sa,
   SUM(CASE
     WHEN bewart_id = 1001
     THEN menge
     ELSE NULL
     END) AS vk_menge_af
  FROM dbp_data.artbew_2
  GROUP BY dat,
   art_id,
   mandant_id,
   nb_id,
   wup_id) (SELECT P_UDF_AKTION.mandant_id,
   P_UDF_AKTION.wup_id,
   P_UDF_AKTION.nb_id,
   P_UDF_AKTION.art_id,
   P_UDF_AKTION.dat,
   P_UDF_AKTION.dat_prognoselauf,
   T.kjwo,
   T.kjmo,
   P_UDF_AKTION.prognose_horizont AS prognose_horizont_udf,
   COALESCE(artbew.vk_menge, 0) AS vk_menge_udf,
   COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_udf,
   COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_udf,
   P_UDF_AKTION.menge_prognose_sa_udf,
   P_UDF_AKTION.menge_prognose_af_udf,
   P_UDF_AKTION.menge_prognose AS menge_prognose_udf,
   ABS(P_UDF_AKTION.menge_prognose - COALESCE(artbew.vk_menge, 0)) AS abs_diff_udf,
   ABS(P_UDF_AKTION.menge_prognose_sa_udf - COALESCE(artbew.vk_menge_sa, 0)) AS abs_diff_sa_udf,
   ABS(P_UDF_AKTION.menge_prognose_af_udf - COALESCE(artbew.vk_menge_af, 0)) AS abs_diff_af_udf,
   P_UDF_AKTION.menge_prognose_sa_udf_gesteuert,
   P_UDF_AKTION.menge_prognose_af_udf_gesteuert,
   P_UDF_AKTION.menge_prognose_gesteuert AS menge_prognose_udf_gesteuert,
   ABS(P_UDF_AKTION.menge_prognose_gesteuert - COALESCE(artbew.vk_menge, 0)) AS abs_diff_udf_gesteuert,
   ABS(P_UDF_AKTION.menge_prognose_sa_udf_gesteuert - COALESCE(artbew.vk_menge_sa, 0)) AS abs_diff_sa_udf_gesteuert,
   ABS(P_UDF_AKTION.menge_prognose_af_udf_gesteuert - COALESCE(artbew.vk_menge_af, 0)) AS abs_diff_af_udf_gesteuert
  FROM `_p_udf_aktion` AS P_UDF_AKTION
   LEFT JOIN `_ARTBEW` AS artbew_2 ON P_UDF_AKTION.mandant_id = artbew.mandant_id AND P_UDF_AKTION.wup_id = artbew.wup_id
     AND P_UDF_AKTION.dat = artbew.dat AND P_UDF_AKTION.art_id = artbew.art_id
   INNER JOIN dbp_data.tag_2 AS T ON P_UDF_AKTION.dat = T.dat);


CREATE OR REPLACE TABLE dbp_etl.udf_pass_agg_2 AS
SELECT UDF_PASS.mandant_id,
 UDF_PASS.wup_id,
 UDF_PASS.nb_id,
 UDF_PASS.dat,
 UDF_PASS.dat_prognoselauf,
 UDF_PASS.kjwo,
 UDF_PASS.kjmo,
 MAX(UDF_PASS.prognose_horizont_udf) AS udf_prognose_horizont,
 awg.wg_id,
 SUM(UDF_PASS.vk_menge_udf) AS udf_vk_menge,
 SUM(UDF_PASS.vk_menge_sa_udf) AS udf_vk_menge_sa,
 SUM(UDF_PASS.vk_menge_af_udf) AS udf_vk_menge_af,
 SUM(UDF_PASS.menge_prognose_sa_udf) AS udf_menge_prognose_sa,
 SUM(UDF_PASS.menge_prognose_af_udf) AS udf_menge_prognose_af,
 SUM(UDF_PASS.menge_prognose_udf) AS udf_menge_prognose,
 SUM(UDF_PASS.abs_diff_udf) AS udf_abs_diff,
 SUM(UDF_PASS.abs_diff_sa_udf) AS udf_abs_diff_sa,
 SUM(UDF_PASS.abs_diff_af_udf) AS udf_abs_diff_af,
 SUM(UDF_PASS.menge_prognose_sa_udf_gesteuert) AS udf_gesteuert_menge_prognose_sa,
 SUM(UDF_PASS.menge_prognose_af_udf_gesteuert) AS udf_gesteuert_menge_prognose_af,
 SUM(UDF_PASS.menge_prognose_udf_gesteuert) AS udf_gesteuert_menge_prognose,
 SUM(UDF_PASS.abs_diff_udf_gesteuert) AS udf_gesteuert_abs_diff,
 SUM(UDF_PASS.abs_diff_sa_udf_gesteuert) AS udf_gesteuert_abs_diff_sa,
 SUM(UDF_PASS.abs_diff_af_udf_gesteuert) AS udf_gesteuert_abs_diff_af
FROM `_udf_pass` AS UDF_PASS
 INNER JOIN (SELECT mandant_id,
   art_id,
   wg_id
  FROM dbp_data.art_wg_zu_per_2
  WHERE arthiertyp_id = 2
   AND dat_bis = DATE '9999-12-31') AS awg ON UDF_PASS.mandant_id = awg.mandant_id AND UDF_PASS.art_id = awg.art_id
GROUP BY UDF_PASS.mandant_id,
 UDF_PASS.wup_id,
 UDF_PASS.nb_id,
 UDF_PASS.dat,
 UDF_PASS.dat_prognoselauf,
 UDF_PASS.kjwo,
 UDF_PASS.kjmo,
 awg.wg_id;