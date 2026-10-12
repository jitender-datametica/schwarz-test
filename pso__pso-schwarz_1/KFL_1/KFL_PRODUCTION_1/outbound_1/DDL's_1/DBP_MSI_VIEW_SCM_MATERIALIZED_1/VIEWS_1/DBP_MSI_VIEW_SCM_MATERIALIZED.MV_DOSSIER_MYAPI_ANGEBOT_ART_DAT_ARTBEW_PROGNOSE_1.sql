CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_dossier_myapi_angebot_art_dat_artbew_prognose_1 (mandant_id
, aktuell_wup_id, nb_id, art_id, angebot_nr, dat_angebot_gueltig_von, dat_angebot_gueltig_bis, dat, dat_prognoselauf,
vk_menge_udf, vk_menge_sa_udf, vk_menge_af_udf, umsatz_netto, absatz_af_n_loyalty_schm_bby, absatz_af_loyalty_schm_bby,
absatz_af_n_loyalty_bby, absatz_af_loyalty_bby, absatz_sa_n_loyalty, absatz_sa_loyalty, absatz_sa_n_loyalty_bby,
absatz_sa_loyalty_bby, absatz_sa_loyalty_kk_bby, absatz_sa_loyalty_kk_c_bby, menge_prognose_sa_udf,
menge_prognose_af_udf, menge_prognose_udf, menge_prognose_sa_udf_gesteuert, menge_prognose_af_udf_gesteuert,
menge_prognose_udf_gesteuert) AS SELECT A_ART_WUP.mandant_id,
 V05.aktuell_wup_id,
 A_ART_WUP.nb_id,
 A_ART_WUP.art_id,
 A_ART_WUP.angebot_nr,
 A.dat_angebot_gueltig_von,
 A.dat_angebot_gueltig_bis,
 T0.dat,
 p_udf_aktion.dat_prognoselauf,
 COALESCE(artbew.vk_menge, 0) AS vk_menge_udf,
 COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_udf,
 COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_udf,
 COALESCE(artbew.umsatz_netto, 0) AS umsatz_netto,
 COALESCE(artbew.absatz_af_n_loyalty_schm_bby, 0) AS absatz_af_n_loyalty_schm_bby,
 COALESCE(artbew.absatz_af_loyalty_schm_bby, 0) AS absatz_af_loyalty_schm_bby,
 COALESCE(artbew.absatz_af_n_loyalty_bby, 0) AS absatz_af_n_loyalty_bby,
 COALESCE(artbew.absatz_af_loyalty_bby, 0) AS absatz_af_loyalty_bby,
 COALESCE(artbew.absatz_sa_n_loyalty, 0) AS absatz_sa_n_loyalty,
 COALESCE(artbew.absatz_sa_loyalty, 0) AS absatz_sa_loyalty,
 COALESCE(artbew.absatz_sa_n_loyalty_bby, 0) AS absatz_sa_n_loyalty_bby,
 COALESCE(artbew.absatz_sa_loyalty_bby, 0) AS absatz_sa_loyalty_bby,
 COALESCE(artbew.absatz_sa_loyalty_kk_bby, 0) AS absatz_sa_loyalty_kk_bby,
 COALESCE(artbew.absatz_sa_loyalty_kk_c_bby, 0) AS absatz_sa_loyalty_kk_c_bby,
 p_udf_aktion.menge_prognose_sa_udf,
 p_udf_aktion.menge_prognose_af_udf,
 p_udf_aktion.menge_prognose AS menge_prognose_udf,
 p_udf_aktion.menge_prognose_sa_udf_gesteuert,
 p_udf_aktion.menge_prognose_af_udf_gesteuert,
 p_udf_aktion.menge_prognose_gesteuert AS menge_prognose_udf_gesteuert
FROM kfl_production_dbp_data.angebot_art_wup_zu_1 AS A_ART_WUP
 INNER JOIN kfl_production_dbp_data.angebot_1 AS A ON A_ART_WUP.mandant_id = A.mandant_id AND A_ART_WUP.angebot_nr = A.angebot_nr
   
 LEFT JOIN (SELECT P_UDF.mandant_id,
   P_UDF.wup_id,
   P_UDF.nb_id,
   P_UDF.art_id,
   P_UDF.dat,
   P_UDF.dat_prognoselauf,
   P_UDF.diagnose_id,
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
     INNER JOIN kfl_production_dbp_view.v_aktion_1 AS A0 ON AAW.aktion_id = A0.aktion_id AND AAW.mandant_id = A0.mandant_id
       
     INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN A0.dat_von AND A0.dat_bis
    WHERE A0.mandant_id <> 1 AND AAW.dat_preisaktiviert <> DATE '1900-01-01' AND AAW.vk_aktion_brutto > 0
     OR A0.mandant_id = 1 AND AAW.dat_sperrung IS NULL) AS aktion_list ON P_UDF.mandant_id = aktion_list.mandant_id AND
       P_UDF.wup_id = aktion_list.wup_id AND P_UDF.art_id = aktion_list.art_id AND P_UDF.dat = aktion_list.dat
  WHERE P_UDF.diagnose_id = ''
  GROUP BY P_UDF.mandant_id,
   P_UDF.wup_id,
   P_UDF.nb_id,
   P_UDF.art_id,
   P_UDF.dat,
   P_UDF.dat_prognoselauf,
   P_UDF.diagnose_id) AS p_udf_aktion ON A_ART_WUP.mandant_id = p_udf_aktion.mandant_id AND A_ART_WUP.wup_id =
     p_udf_aktion.wup_id AND A_ART_WUP.art_id = p_udf_aktion.art_id AND p_udf_aktion.dat BETWEEN A.dat_angebot_gueltig_von
   AND A.dat_angebot_gueltig_bis
 LEFT JOIN (SELECT dat,
   wup_id,
   nb_id,
   art_id,
   mandant_id,
   SUM(menge) AS vk_menge,
   SUM(umsatz_netto) AS umsatz_netto,
   SUM(CASE
     WHEN bewart_id = 1002
     THEN menge
     ELSE NULL
     END) AS vk_menge_sa,
   SUM(CASE
     WHEN bewart_id = 1001
     THEN menge
     ELSE NULL
     END) AS vk_menge_af,
   SUM(CASE
     WHEN bewart_det_id = 100110
     THEN menge
     ELSE 0
     END) AS absatz_af_n_loyalty_schm_bby,
   SUM(CASE
     WHEN bewart_det_id = 100111
     THEN menge
     ELSE 0
     END) AS absatz_af_loyalty_schm_bby,
   SUM(CASE
     WHEN bewart_det_id = 100130
     THEN menge
     ELSE 0
     END) AS absatz_af_n_loyalty_bby,
   SUM(CASE
     WHEN bewart_det_id = 100131
     THEN menge
     ELSE 0
     END) AS absatz_af_loyalty_bby,
   SUM(CASE
     WHEN bewart_det_id = 100210
     THEN menge
     ELSE 0
     END) AS absatz_sa_n_loyalty,
   SUM(CASE
     WHEN bewart_det_id = 100211
     THEN menge
     ELSE 0
     END) AS absatz_sa_loyalty,
   SUM(CASE
     WHEN bewart_det_id = 100220
     THEN menge
     ELSE 0
     END) AS absatz_sa_n_loyalty_bby,
   SUM(CASE
     WHEN bewart_det_id = 100221
     THEN menge
     ELSE 0
     END) AS absatz_sa_loyalty_bby,
   SUM(CASE
     WHEN bewart_det_id = 100231
     THEN menge
     ELSE 0
     END) AS absatz_sa_loyalty_kk_bby,
   SUM(CASE
     WHEN bewart_det_id = 100241
     THEN menge
     ELSE 0
     END) AS absatz_sa_loyalty_kk_c_bby
  FROM kfl_production_dbp_view.v_artbew_1 AS AB
  GROUP BY dat,
   art_id,
   mandant_id,
   nb_id,
   wup_id) AS artbew_1 ON A_ART_WUP.mandant_id = artbew.mandant_id AND A_ART_WUP.wup_id = artbew.wup_id AND A_ART_WUP.art_id
     = artbew.art_id AND artbew.dat BETWEEN A.dat_angebot_gueltig_von AND A.dat_angebot_gueltig_bis
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON A_ART_WUP.mandant_id = V05.mandant_id AND A_ART_WUP.wup_id = V05.wup_id
     AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T0 ON T0.dat BETWEEN A.dat_angebot_gueltig_von AND A.dat_angebot_gueltig_bis
     AND p_udf_aktion.dat = T0.dat AND artbew.dat = T0.dat
WHERE CURRENT_DATE BETWEEN A.dat_angebot_gueltig_von AND A.dat_angebot_gueltig_bis
 AND T0.akt_kj = 0;