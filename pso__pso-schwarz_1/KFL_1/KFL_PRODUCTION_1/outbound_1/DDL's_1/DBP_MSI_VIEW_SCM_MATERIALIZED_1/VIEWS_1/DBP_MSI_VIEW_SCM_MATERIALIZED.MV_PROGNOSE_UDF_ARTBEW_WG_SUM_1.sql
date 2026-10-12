CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_prognose_udf_artbew_wg_sum_1 (mandant_id, wup_id,
nb_id, dat, dat_prognoselauf, kjwo, kjmo, diagnose_id_udf, prognose_bez_udf, prognose_horizont_udf, wg_id, vk_menge_udf
, vk_menge_udf_opa, vk_menge_sa_udf, vk_menge_af_udf, menge_prognose_sa_udf, menge_prognose_af_udf, menge_prognose_udf,
menge_prognose_sa_udf_gesteuert, menge_prognose_af_udf_gesteuert, menge_prognose_udf_gesteuert, abs_diff_udf,
abs_diff_sa_udf, abs_diff_af_udf, abs_diff_udf_gesteuert, abs_diff_sa_udf_gesteuert, abs_diff_af_udf_gesteuert) AS
SELECT udf_pass.mandant_id,
 V05.aktuell_wup_id AS wup_id_,
 udf_pass.nb_id,
 udf_pass.dat,
 udf_pass.dat_prognoselauf,
 udf_pass.kjwo,
 udf_pass.kjmo,
 udf_pass.diagnose_id_udf,
 udf_pass.prognose_bez_udf,
 udf_pass.prognose_horizont_udf,
 AWG.wg_id,
 SUM(udf_pass.vk_menge_udf) AS vk_menge_udf,
 SUM(udf_pass.vk_menge_udf_opa) AS vk_menge_udf_opa,
 SUM(udf_pass.vk_menge_sa_udf) AS vk_menge_sa_udf,
 SUM(udf_pass.vk_menge_af_udf) AS vk_menge_af_udf,
 SUM(udf_pass.menge_prognose_sa_udf) AS menge_prognose_sa_udf,
 SUM(udf_pass.menge_prognose_af_udf) AS menge_prognose_af_udf,
 SUM(udf_pass.menge_prognose_udf) AS menge_prognose_udf,
 SUM(udf_pass.menge_prognose_sa_udf_gesteuert) AS menge_prognose_sa_udf_gesteuert,
 SUM(udf_pass.menge_prognose_af_udf_gesteuert) AS menge_prognose_af_udf_gesteuert,
 SUM(udf_pass.menge_prognose_udf_gesteuert) AS menge_prognose_udf_gesteuert,
 SUM(udf_pass.abs_diff_udf) AS abs_diff_udf,
 SUM(udf_pass.abs_diff_sa_udf) AS abs_diff_sa_udf,
 SUM(udf_pass.abs_diff_af_udf) AS abs_diff_af_udf,
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
     LEFT JOIN (SELECT AAW.mandant_id,
       AAW.wup_id,
       AAW.art_id,
       T.dat,
       1 AS aktionslistung_fg
      FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS AAW
       INNER JOIN kfl_production_dbp_view.v_aktion_1 AS A ON AAW.aktion_id = A.aktion_id AND AAW.mandant_id = A.mandant_id
         
       INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN A.dat_von AND A.dat_bis
      WHERE AAW.mandant_id <> 1 AND AAW.dat_preisaktiviert <> DATE '1900-01-01' AND AAW.vk_aktion_brutto > 0
       OR A.mandant_id = 1 AND AAW.dat_sperrung IS NULL
      GROUP BY AAW.mandant_id,
       AAW.wup_id,
       AAW.art_id,
       T.dat,
       aktionslistung_fg) AS aktion_list ON P_UDF.mandant_id = aktion_list.mandant_id AND P_UDF.wup_id = aktion_list.wup_id
          AND P_UDF.art_id = aktion_list.art_id AND P_UDF.dat = aktion_list.dat
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
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T0 ON p_udf_aktion.dat = T0.dat
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
      p_udf_aktion.art_id = absch_de.art_id AND p_udf_aktion.dat = absch_de.dat
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
     dat) AS absch_kmo ON p_udf_aktion.mandant_id = absch_kmo.mandant_id AND p_udf_aktion.wup_id = absch_kmo.wup_id AND
      p_udf_aktion.art_id = absch_kmo.art_id AND p_udf_aktion.dat = absch_kmo.dat) AS udf_pass
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON udf_pass.mandant_id = V05.mandant_id AND udf_pass.wup_id = V05.wup_id
     AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS AWG ON udf_pass.mandant_id = AWG.mandant_id AND udf_pass.art_id =
   AWG.art_id
WHERE AWG.arthiertyp_id = 2
 AND AWG.dat_bis = DATE '9999-12-31'
GROUP BY udf_pass.mandant_id,
 wup_id_,
 udf_pass.nb_id,
 udf_pass.dat,
 udf_pass.dat_prognoselauf,
 udf_pass.kjwo,
 udf_pass.kjmo,
 udf_pass.diagnose_id_udf,
 udf_pass.prognose_bez_udf,
 udf_pass.prognose_horizont_udf,
 AWG.wg_id;