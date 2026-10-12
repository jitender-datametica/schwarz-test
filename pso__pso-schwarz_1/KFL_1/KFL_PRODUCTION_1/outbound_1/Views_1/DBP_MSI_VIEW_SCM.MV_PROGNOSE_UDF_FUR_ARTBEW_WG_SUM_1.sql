-- AP0138978 |dknop | adding vk_menge_udf_opa, vk_menge_fur_opa

-- 20221208 richternic prognose_kennzeichen_fur entfernen -> fuehrt zu dopplungen

-- 20220309 richternic AP0089430 Neuanlage
 -- 2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_prognose_udf_fur_artbew_wg_sum_1 (mandant_id, wup_id, nb_id, dat
, dat_prognoselauf, kjwo, kjmo, diagnose_id_udf, prognose_bez, prognose_horizont_udf, wg_id, diagnose_id_fur,
prognose_horizont_fur, vk_menge_udf, vk_menge_udf_opa, vk_menge_sa_udf, vk_menge_af_udf, menge_prognose_sa_udf,
menge_prognose_af_udf, menge_prognose_udf, abs_diff_udf, abs_diff_sa_udf, abs_diff_af_udf,
menge_prognose_sa_udf_gesteuert, menge_prognose_af_udf_gesteuert, menge_prognose_udf_gesteuert, abs_diff_udf_gesteuert,
abs_diff_sa_udf_gesteuert, abs_diff_af_udf_gesteuert, menge_prognose_sa_fur, menge_prognose_af_fur, menge_prognose_fur,
menge_prognose_max_fur, vk_menge_fur, vk_menge_fur_opa, vk_menge_sa_fur, vk_menge_af_fur, abs_diff_fur, abs_diff_sa_fur
, abs_diff_af_fur) AS -- udf_pass_agg_1
 -- udf_pass
 -- p_udf_aktion
 -- aktion_list
 -- artbew_1

-- Hier kommt der F&R Teil
 -- fur_pass_agg_1
 -- ,fur_pass.prognose_kennzeichen_fur
 -- fur_pass
 -- ,CASE

-- WHEN p_fur.menge_prognose_aktion > 0 THEN 'SA'
 -- ELSE 'AF'
 -- END AS prognose_kennzeichen_fur
 -- artbew_1

-- ,fur_pass.prognose_kennzeichen_fur
 SELECT udf_pass_agg.mandant_id -- ,udf_pass_agg.wup_id

 -- ,CASE WHEN TRY_CAST(udf_pass_agg.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id

 ,
 V05.aktuell_wup_id AS kunde_id,
 udf_pass_agg.nb_id,
 udf_pass_agg.dat,
 udf_pass_agg.dat_prognoselauf,
 udf_pass_agg.kjwo,
 udf_pass_agg.kjmo,
 udf_pass_agg.diagnose_id_udf,
 COALESCE(udf_pass_agg.prognose_bez_udf, fur_pass_agg.prognose_bez_fur) AS prognose_bez,
 udf_pass_agg.prognose_horizont_udf,
 udf_pass_agg.wg_id,
 fur_pass_agg.diagnose_id_fur -- ,fur_pass_agg.prognose_bez_fur
,
 fur_pass_agg.prognose_horizont_fur -- ,fur_pass_agg.prognose_kennzeichen_fur
,
 udf_pass_agg.vk_menge_udf,
 udf_pass_agg.vk_menge_udf_opa,
 udf_pass_agg.vk_menge_sa_udf,
 udf_pass_agg.vk_menge_af_udf,
 udf_pass_agg.menge_prognose_sa_udf,
 udf_pass_agg.menge_prognose_af_udf,
 udf_pass_agg.menge_prognose_udf,
 udf_pass_agg.abs_diff_udf,
 udf_pass_agg.abs_diff_sa_udf,
 udf_pass_agg.abs_diff_af_udf,
 udf_pass_agg.menge_prognose_sa_udf_gesteuert,
 udf_pass_agg.menge_prognose_af_udf_gesteuert,
 udf_pass_agg.menge_prognose_udf_gesteuert,
 udf_pass_agg.abs_diff_udf_gesteuert,
 udf_pass_agg.abs_diff_sa_udf_gesteuert,
 udf_pass_agg.abs_diff_af_udf_gesteuert,
 fur_pass_agg.menge_prognose_sa_fur,
 fur_pass_agg.menge_prognose_af_fur,
 fur_pass_agg.menge_prognose_fur,
 fur_pass_agg.menge_prognose_max_fur,
 fur_pass_agg.vk_menge_fur,
 fur_pass_agg.vk_menge_fur_opa,
 fur_pass_agg.vk_menge_sa_fur,
 fur_pass_agg.vk_menge_af_fur,
 fur_pass_agg.abs_diff_fur,
 fur_pass_agg.abs_diff_sa_fur,
 fur_pass_agg.abs_diff_af_fur
FROM (SELECT udf_pass.mandant_id,
   udf_pass.wup_id,
   udf_pass.nb_id,
   udf_pass.dat,
   udf_pass.dat_prognoselauf,
   udf_pass.kjwo,
   udf_pass.kjmo,
   udf_pass.diagnose_id_udf,
   udf_pass.prognose_bez_udf,
   MAX(udf_pass.prognose_horizont_udf) AS prognose_horizont_udf,
   AWG.wg_id,
   SUM(udf_pass.vk_menge_udf) AS vk_menge_udf,
   SUM(udf_pass.vk_menge_udf_opa) AS vk_menge_udf_opa,
   SUM(udf_pass.vk_menge_sa_udf) AS vk_menge_sa_udf,
   SUM(udf_pass.vk_menge_af_udf) AS vk_menge_af_udf,
   SUM(udf_pass.menge_prognose_sa_udf) AS menge_prognose_sa_udf,
   SUM(udf_pass.menge_prognose_af_udf) AS menge_prognose_af_udf,
   SUM(udf_pass.menge_prognose_udf) AS menge_prognose_udf,
   SUM(udf_pass.abs_diff_udf) AS abs_diff_udf,
   SUM(udf_pass.abs_diff_sa_udf) AS abs_diff_sa_udf,
   SUM(udf_pass.abs_diff_af_udf) AS abs_diff_af_udf,
   SUM(udf_pass.menge_prognose_sa_udf_gesteuert) AS menge_prognose_sa_udf_gesteuert,
   SUM(udf_pass.menge_prognose_af_udf_gesteuert) AS menge_prognose_af_udf_gesteuert,
   SUM(udf_pass.menge_prognose_udf_gesteuert) AS menge_prognose_udf_gesteuert,
   SUM(udf_pass.abs_diff_udf_gesteuert) AS abs_diff_udf_gesteuert,
   SUM(udf_pass.abs_diff_sa_udf_gesteuert) AS abs_diff_sa_udf_gesteuert,
   SUM(udf_pass.abs_diff_af_udf_gesteuert) AS abs_diff_af_udf_gesteuert
  FROM (SELECT p_udf_aktion.mandant_id,
     p_udf_aktion.wup_id,
     p_udf_aktion.nb_id,
     p_udf_aktion.art_id,
     p_udf_aktion.dat,
     p_udf_aktion.dat_prognoselauf,
     T0.kjwo,
     T0.kjmo,
     p_udf_aktion.diagnose_id AS diagnose_id_udf,
     'LEGACY_ATTR_DO_NOT_USE' AS prognose_bez_udf,
     p_udf_aktion.prognose_horizont AS prognose_horizont_udf,
     COALESCE(artbew.vk_menge, 0) AS vk_menge_udf,
      COALESCE(artbew.vk_menge, 0) - COALESCE(CASE
        WHEN artbew.mandant_id = 1
        THEN absch_de.menge_preisabschriften
        ELSE absch_kmo.menge_preisabschriften
        END, 0) AS vk_menge_udf_opa,
     COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_udf,
     COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_udf,
     p_udf_aktion.menge_prognose_sa_udf,
     p_udf_aktion.menge_prognose_af_udf,
     p_udf_aktion.menge_prognose AS menge_prognose_udf,
     ABS(p_udf_aktion.menge_prognose - COALESCE(artbew.vk_menge, 0)) AS abs_diff_udf,
     ABS(p_udf_aktion.menge_prognose_sa_udf - COALESCE(artbew.vk_menge_sa, 0)) AS abs_diff_sa_udf,
     ABS(p_udf_aktion.menge_prognose_af_udf - COALESCE(artbew.vk_menge_af, 0)) AS abs_diff_af_udf,
     p_udf_aktion.menge_prognose_sa_udf_gesteuert,
     p_udf_aktion.menge_prognose_af_udf_gesteuert,
     p_udf_aktion.menge_prognose_gesteuert AS menge_prognose_udf_gesteuert,
     ABS(p_udf_aktion.menge_prognose_gesteuert - COALESCE(artbew.vk_menge, 0)) AS abs_diff_udf_gesteuert,
     ABS(p_udf_aktion.menge_prognose_sa_udf_gesteuert - COALESCE(artbew.vk_menge_sa, 0)) AS abs_diff_sa_udf_gesteuert,
     ABS(p_udf_aktion.menge_prognose_af_udf_gesteuert - COALESCE(artbew.vk_menge_af, 0)) AS abs_diff_af_udf_gesteuert
    FROM (SELECT P_UDF.mandant_id,
       P_UDF.wup_id,
       P_UDF.nb_id,
       P_UDF.art_id,
       P_UDF.dat,
       P_UDF.dat_prognoselauf,
       P_UDF.diagnose_id,
       MAX(P_UDF.prognose_horizont) AS prognose_horizont,
       SUM(P_UDF.menge_prognose_sa) AS menge_prognose_sa_udf,
       SUM(P_UDF.menge_prognose_af) AS menge_prognose_af_udf,
       SUM(CASE
         WHEN P_UDF.menge_prognose_sa IS NULL AND P_UDF.menge_prognose_af IS NULL
         THEN NULL
         ELSE COALESCE(P_UDF.menge_prognose_sa, 0) + COALESCE(P_UDF.menge_prognose_af, 0)
         END) AS menge_prognose,
       SUM(CASE
         WHEN aktion_list.aktionslistung_fg = 1
         THEN P_UDF.menge_prognose_gesteuert
         ELSE NULL
         END) AS menge_prognose_sa_udf_gesteuert,
       SUM(CASE
         WHEN aktion_list.aktionslistung_fg IS NULL
         THEN P_UDF.menge_prognose_gesteuert
         ELSE NULL
         END) AS menge_prognose_af_udf_gesteuert,
       SUM(P_UDF.menge_prognose_gesteuert) AS menge_prognose_gesteuert
      FROM kfl_production_dbp_view.v_udf_prognose_1 AS P_UDF
       LEFT JOIN (SELECT DISTINCT AAW.mandant_id,
         AAW.wup_id,
         AAW.art_id,
         T.dat,
         1 AS aktionslistung_fg
        FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS AAW
         INNER JOIN kfl_production_dbp_view.v_aktion_1 AS A ON AAW.aktion_id = A.aktion_id AND AAW.mandant_id = A.mandant_id
           
         INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN A.dat_von AND A.dat_bis
        WHERE AAW.mandant_id <> 1 AND AAW.dat_preisaktiviert <> DATE '1900-01-01' AND AAW.vk_aktion_brutto > 0
         OR AAW.mandant_id = 1 AND AAW.dat_sperrung IS NULL) AS aktion_list ON P_UDF.mandant_id = aktion_list.mandant_id
            AND P_UDF.wup_id = aktion_list.wup_id AND P_UDF.art_id = aktion_list.art_id AND P_UDF.dat = aktion_list.dat
      WHERE P_UDF.diagnose_id = ''
      GROUP BY P_UDF.mandant_id,
       P_UDF.wup_id,
       P_UDF.nb_id,
       P_UDF.art_id,
       P_UDF.dat,
       P_UDF.dat_prognoselauf,
       P_UDF.diagnose_id) AS p_udf_aktion
     LEFT JOIN (SELECT dat,
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
      FROM kfl_production_dbp_view.v_artbew_1 AS V01
      GROUP BY dat,
       art_id,
       mandant_id,
       nb_id,
       wup_id) AS artbew_1 ON p_udf_aktion.mandant_id = artbew.mandant_id AND p_udf_aktion.wup_id = artbew.wup_id AND
        p_udf_aktion.dat = artbew.dat AND p_udf_aktion.art_id = artbew.art_id
     INNER JOIN kfl_production_dbp_view.v_tag_1 AS T0 ON p_udf_aktion.dat = T0.dat -- marktabschriften_1 de

     LEFT JOIN (SELECT mandant_id,
       wup_id,
       art_id,
       dat,
       SUM(CASE
         WHEN abschrift_menge_einh_id = 'G'
         THEN menge_abschrift / 1000
         ELSE menge_abschrift
         END) AS menge_preisabschriften
      FROM kfl_production_dbp_view.v_marktabschriften_1 AS V01
      WHERE mandant_id = 1
       AND abschriftart_id IN (5, 7)
      GROUP BY mandant_id,
       wup_id,
       art_id,
       dat) AS absch_de ON p_udf_aktion.mandant_id = absch_de.mandant_id AND p_udf_aktion.wup_id = absch_de.wup_id AND
        p_udf_aktion.art_id = absch_de.art_id AND p_udf_aktion.dat = absch_de.dat -- marktabschriften_1 kmo

     LEFT JOIN (SELECT mandant_id,
       wup_id,
       art_id,
       dat_umbew AS dat,
       SUM(menge_erf) AS menge_preisabschriften
      FROM kfl_production_dbp_view.v_art_umbewertung_1 AS ABSCH
      WHERE mandant_id = 6 AND preis_aend_grund_id = 2
       OR mandant_id IN (2, 4, 5, 7, 8) AND preis_aend_grund_id = 7
       OR mandant_id = 3 AND preis_aend_grund_id = 11
      GROUP BY mandant_id,
       wup_id,
       art_id,
       dat) AS absch_kmo ON p_udf_aktion.mandant_id = absch_kmo.mandant_id AND p_udf_aktion.wup_id = absch_kmo.wup_id
       AND p_udf_aktion.art_id = absch_kmo.art_id AND p_udf_aktion.dat = absch_kmo.dat) AS udf_pass
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS AWG ON udf_pass.mandant_id = AWG.mandant_id AND udf_pass.art_id
      = AWG.art_id
  WHERE AWG.arthiertyp_id = 2
   AND AWG.dat_bis = DATE '9999-12-31'
  GROUP BY udf_pass.mandant_id,
   udf_pass.wup_id,
   udf_pass.nb_id,
   udf_pass.dat,
   udf_pass.dat_prognoselauf,
   udf_pass.kjwo,
   udf_pass.kjmo,
   udf_pass.diagnose_id_udf,
   udf_pass.prognose_bez_udf,
   AWG.wg_id) AS udf_pass_agg_1
 FULL JOIN (SELECT fur_pass.mandant_id,
   fur_pass.wup_id,
   fur_pass.nb_id,
   fur_pass.dat,
   fur_pass.dat_prognoselauf,
   fur_pass.kjwo,
   fur_pass.kjmo,
   fur_pass.diagnose_id_fur,
   fur_pass.prognose_bez_fur,
   MAX(fur_pass.prognose_horizont_fur) AS prognose_horizont_fur,
   AWG0.wg_id,
   SUM(fur_pass.menge_prognose_sa_fur) AS menge_prognose_sa_fur,
   SUM(fur_pass.menge_prognose_af_fur) AS menge_prognose_af_fur,
   SUM(fur_pass.menge_prognose_fur) AS menge_prognose_fur,
   SUM(fur_pass.menge_prognose_max_fur) AS menge_prognose_max_fur,
   SUM(fur_pass.vk_menge_fur) AS vk_menge_fur,
   SUM(fur_pass.vk_menge_fur_opa) AS vk_menge_fur_opa,
   SUM(fur_pass.vk_menge_sa_fur) AS vk_menge_sa_fur,
   SUM(fur_pass.vk_menge_af_fur) AS vk_menge_af_fur,
   SUM(fur_pass.abs_diff_fur) AS abs_diff_fur,
   SUM(fur_pass.abs_diff_sa_fur) AS abs_diff_sa_fur,
   SUM(fur_pass.abs_diff_af_fur) AS abs_diff_af_fur
  FROM (SELECT P_FUR.mandant_id,
     P_FUR.wup_id,
     P_FUR.nb_id,
     P_FUR.art_id,
     P_FUR.dat,
      CASE
      WHEN P_FUR.dat <= CURRENT_DATE
      THEN DATE_SUB(P_FUR.dat, INTERVAL 1 DAY)
      ELSE CURRENT_DATE
      END AS dat_prognoselauf,
     T1.kjwo,
     T1.kjmo,
     '    ' AS diagnose_id_fur,
     'LEGACY_ATTR_DO_NOT_USE' AS prognose_bez_fur,
     P_FUR.prognose_horizont AS prognose_horizont_fur,
     P_FUR.menge_prognose_aktion AS menge_prognose_sa_fur,
      CASE
      WHEN P_FUR.menge_prognose_aktion > 0
      THEN 0
      ELSE P_FUR.menge_prognose
      END AS menge_prognose_af_fur,
      CASE
      WHEN P_FUR.menge_prognose_aktion > 0
      THEN P_FUR.menge_prognose_aktion
      ELSE P_FUR.menge_prognose
      END AS menge_prognose_fur,
     P_FUR.menge_prognose_max AS menge_prognose_max_fur,
     COALESCE(artbew.vk_menge, 0) AS vk_menge_fur,
      COALESCE(artbew.vk_menge, 0) - COALESCE(CASE
        WHEN artbew.mandant_id = 1
        THEN absch_de.menge_preisabschriften
        ELSE absch_kmo.menge_preisabschriften
        END, 0) AS vk_menge_fur_opa,
     COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_fur,
     COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_fur,
     ABS(CASE
        WHEN P_FUR.menge_prognose_aktion > 0
        THEN P_FUR.menge_prognose_aktion
        ELSE P_FUR.menge_prognose
        END - COALESCE(artbew.vk_menge, 0)) AS abs_diff_fur,
     ABS(P_FUR.menge_prognose_aktion - COALESCE(artbew.vk_menge_sa, 0)) AS abs_diff_sa_fur,
     ABS(CASE
        WHEN P_FUR.menge_prognose_aktion > 0
        THEN 0
        ELSE P_FUR.menge_prognose
        END - COALESCE(artbew.vk_menge_af, 0)) AS abs_diff_af_fur
    FROM kfl_production_dbp_view.v_fur_prognose_1 AS P_FUR
     LEFT JOIN (SELECT dat,
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
      FROM kfl_production_dbp_view.v_artbew_1 AS V01
      GROUP BY dat,
       art_id,
       mandant_id,
       nb_id,
       wup_id) AS artbew_1 ON P_FUR.mandant_id = artbew.mandant_id AND P_FUR.wup_id = artbew.wup_id AND P_FUR.dat = artbew_1
        .dat AND P_FUR.art_id = artbew.art_id
     INNER JOIN kfl_production_dbp_view.v_tag_1 AS T1_1 ON P_FUR.dat = T1.dat -- marktabschriften_1 de

     LEFT JOIN (SELECT mandant_id,
       wup_id,
       art_id,
       dat,
       SUM(CASE
         WHEN abschrift_menge_einh_id = 'G'
         THEN menge_abschrift / 1000
         ELSE menge_abschrift
         END) AS menge_preisabschriften
      FROM kfl_production_dbp_view.v_marktabschriften_1 AS V01
      WHERE mandant_id = 1
       AND abschriftart_id IN (5, 7)
      GROUP BY mandant_id,
       wup_id,
       art_id,
       dat) AS absch_de ON P_FUR.mandant_id = absch_de.mandant_id AND P_FUR.wup_id = absch_de.wup_id AND P_FUR.art_id =
        absch_de.art_id AND P_FUR.dat = absch_de.dat -- marktabschriften_1 kmo

     LEFT JOIN (SELECT mandant_id,
       wup_id,
       art_id,
       dat_umbew AS dat,
       SUM(menge_erf) AS menge_preisabschriften
      FROM kfl_production_dbp_view.v_art_umbewertung_1 AS ABSCH
      WHERE mandant_id = 6 AND preis_aend_grund_id = 2
       OR mandant_id IN (2, 4, 5, 7, 8) AND preis_aend_grund_id = 7
       OR mandant_id = 3 AND preis_aend_grund_id = 11
      GROUP BY mandant_id,
       wup_id,
       art_id,
       dat) AS absch_kmo ON P_FUR.mandant_id = absch_kmo.mandant_id AND P_FUR.wup_id = absch_kmo.wup_id AND P_FUR.art_id
         = absch_kmo.art_id AND P_FUR.dat = absch_kmo.dat) AS fur_pass
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS AWG0 ON fur_pass.mandant_id = AWG0.mandant_id AND fur_pass.art_id
      = AWG0.art_id
  WHERE AWG0.arthiertyp_id = 2
   AND AWG0.dat_bis = DATE '9999-12-31'
  GROUP BY fur_pass.mandant_id,
   fur_pass.wup_id,
   fur_pass.nb_id,
   fur_pass.dat,
   fur_pass.dat_prognoselauf,
   fur_pass.kjwo,
   fur_pass.kjmo,
   fur_pass.diagnose_id_fur,
   fur_pass.prognose_bez_fur,
   AWG0.wg_id) AS fur_pass_agg_1 ON udf_pass_agg.mandant_id = fur_pass_agg.mandant_id AND udf_pass_agg.wup_id =
      fur_pass_agg.wup_id AND udf_pass_agg.nb_id = fur_pass_agg.nb_id AND udf_pass_agg.dat = fur_pass_agg.dat AND
   udf_pass_agg.wg_id = fur_pass_agg.wg_id -- ??? weitere CROSS JOIN Kriterien

 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON fur_pass_agg.mandant_id
    -- AND v05.wup_id = CASE WHEN TRY_CAST(fur_pass_agg.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(fur_pass_agg.wup_id AS INTEGER) END

    = V05.mandant_id AND fur_pass_agg.wup_id = V05.wup_id AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id
       = - 1 AND V05.wup_id = 0);