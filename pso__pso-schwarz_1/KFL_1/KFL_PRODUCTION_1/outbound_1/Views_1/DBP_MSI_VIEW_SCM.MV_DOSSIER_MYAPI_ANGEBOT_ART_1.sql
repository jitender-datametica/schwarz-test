CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_dossier_myapi_angebot_art_1 AS WITH AB AS (SELECT A_ART_WUP0.angebot_nr
   ,
   AB.mandant_id,
   AB.wup_id,
   AB.art_id,
   SUM(AB.menge) AS menge,
   SUM(AB.umsatz_netto) AS umsatz_netto,
   SUM(CASE
     WHEN AB.bewart_det_id = 100110
     THEN AB.menge
     ELSE 0
     END) AS absatz_af_n_loyalty_schm_bby,
   SUM(CASE
     WHEN AB.bewart_det_id = 100111
     THEN AB.menge
     ELSE 0
     END) AS absatz_af_loyalty_schm_bby,
   SUM(CASE
     WHEN AB.bewart_det_id = 100130
     THEN AB.menge
     ELSE 0
     END) AS absatz_af_n_loyalty_bby,
   SUM(CASE
     WHEN AB.bewart_det_id = 100131
     THEN AB.menge
     ELSE 0
     END) AS absatz_af_loyalty_bby,
   SUM(CASE
     WHEN AB.bewart_det_id = 100210
     THEN AB.menge
     ELSE 0
     END) AS absatz_sa_n_loyalty,
   SUM(CASE
     WHEN AB.bewart_det_id = 100211
     THEN AB.menge
     ELSE 0
     END) AS absatz_sa_loyalty,
   SUM(CASE
     WHEN AB.bewart_det_id = 100220
     THEN AB.menge
     ELSE 0
     END) AS absatz_sa_n_loyalty_bby,
   SUM(CASE
     WHEN AB.bewart_det_id = 100221
     THEN AB.menge
     ELSE 0
     END) AS absatz_sa_loyalty_bby,
   SUM(CASE
     WHEN AB.bewart_det_id = 100231
     THEN AB.menge
     ELSE 0
     END) AS absatz_sa_loyalty_kk_bby,
   SUM(CASE
     WHEN AB.bewart_det_id = 100241
     THEN AB.menge
     ELSE 0
     END) AS absatz_sa_loyalty_kk_c_bby
  FROM kfl_production_dbp_data.angebot_art_wup_zu_1 AS A_ART_WUP0
   INNER JOIN kfl_production_dbp_data.angebot_1 AS A0 ON A_ART_WUP0.mandant_id = A0.mandant_id AND A_ART_WUP0.angebot_nr =
     A0.angebot_nr
   INNER JOIN kfl_production_dbp_view.v_artbew_1 AS AB ON A_ART_WUP0.mandant_id = AB.mandant_id AND A_ART_WUP0.wup_id = AB
       .wup_id AND A_ART_WUP0.art_id = AB.art_id AND AB.dat BETWEEN A0.dat_angebot_gueltig_von AND (LEAST(A0.dat_angebot_gueltig_bis
       , CURRENT_DATE))
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON A0.dat_angebot_gueltig_von = T.dat
  WHERE CURRENT_DATE BETWEEN A0.dat_angebot_gueltig_von AND A0.dat_angebot_gueltig_bis
   AND T.akt_kj = 0
  GROUP BY A_ART_WUP0.angebot_nr,
   AB.mandant_id,
   AB.wup_id,
   AB.art_id) (SELECT A_ART_WUP.mandant_id,
   M.mandant_bez,
   A_ART_WUP.wup_id,
   A_ART_WUP.angebot_nr,
   A_ART_WUP.art_id,
   ART.art_bez,
   A_ART_WUP.nb_id,
   A_ART_WUP.verkaufsorganisation_id,
   A.dat_angebot_gueltig_von,
   A.dat_angebot_gueltig_bis,
   A_ART_WUP.preis_vk_brutto_aktion,
   A_ART_WUP.preis_vk_brutto,
   A_ART_WUP.proz_preisnachlass,
   A_ATTR.bestand_bme,
   A_ATTR.mindestmenge_bme,
   A_ATTR.maximalmenge_bme,
   A_ART_WUP.art_nis_fg,
   A.aktion_id,
   A_ATTR.masterbonus_fg,
   A_ATTR.gondelkopf_fg,
   A_ATTR.topartikel_fg,
   A_WER_P_E.werbethema_id,
   A_WER_P_E.werbethema_bez,
   A.aktion_typ_id,
   A.geschaeftsvorfall_id,
   A.konditionsart_id,
   A.anz_angebot_limit,
   A.bonuskauf_fg,
   A_ART_WUP.art_werbe_prod_gruppe_name,
   A_ART_WUP.anz_bonuskauf_bezahlt,
   A_ART_WUP.menge_bonuskauf_min,
   A_ART_WUP.rabatt_typ_id,
   A_ART_WUP.proz_bonuskauf_rabatt,
   A.angebot_typ_cd,
   A_ART_WUP.opv_prospekt_fg,
   A_ART_WUP.opv_markt_fg,
   A_ATTR.stimmung_fg,
   A_ATTR.preishammer_fg,
   A_ATTR.ek_art_id_ref,
   AGW.mandant_id AS mandant_id_vz,
    CASE
    WHEN LENGTH(CAST(ABS(AGW.gp_id) AS STRING)) <= 4
    THEN AGW.gp_id
    ELSE -9
    END AS wup_id_vz,
    CASE
    WHEN AGW.auslieferungsgruppe_id = 'VEN'
    THEN A_GP.gp_id
    ELSE AGW.gp_id
    END AS gp_id,
   -111 AS nb_id_vz,
   AGW.auslieferungsgruppe_id AS ausliefergruppe_id,
   T0.kjwo,
   WW.kjwo_ww,
    DATE_DIFF(A.dat_angebot_gueltig_bis, A.dat_angebot_gueltig_von, DAY) + 1 AS anz_tage_werbung,
   AVQ_W.wbs_estimation_id,
   AVQ_W.wbs_adjustment_id,
    AVQ_W.menge_plan_wbs + AVQ_W.menge_plan_upload AS planmenge_wbs,
   AVQ_W.menge_bestand_aktionsstart AS marktbestand_aktionsstart,
   AVQ_W.menge_we_in_aktion AS we_in_aktion,
   AVQ_W.menge_we_vor_aktion AS we_vor_aktion,
   AVQ_W.anz_nullbestand_tag1 AS nullbestandquote_tag_1,
   AVQ_W.anz_nullbestand_gesamt AS nullbestandquote,
   AVQ_W.menge_gesamt AS absatz_in_aktion,
   AVQ_W.menge_nur_tag1 AS absatz_in_aktion_tag_1,
   COALESCE(ab_agg.menge, 0) AS menge,
   COALESCE(ab_agg.umsatz_netto, 0) AS umsatz_netto,
   COALESCE(ab_agg.absatz_af_n_loyalty_schm_bby, 0) AS absatz_af_n_loyalty_schm_bby,
   COALESCE(ab_agg.absatz_af_loyalty_schm_bby, 0) AS absatz_af_loyalty_schm_bby,
   COALESCE(ab_agg.absatz_af_n_loyalty_bby, 0) AS absatz_af_n_loyalty_bby,
   COALESCE(ab_agg.absatz_af_loyalty_bby, 0) AS absatz_af_loyalty_bby,
   COALESCE(ab_agg.absatz_sa_n_loyalty, 0) AS absatz_sa_n_loyalty,
   COALESCE(ab_agg.absatz_sa_loyalty, 0) AS absatz_sa_loyalty,
   COALESCE(ab_agg.absatz_sa_n_loyalty_bby, 0) AS absatz_sa_n_loyalty_bby,
   COALESCE(ab_agg.absatz_sa_loyalty_bby, 0) AS absatz_sa_loyalty_bby,
   COALESCE(ab_agg.absatz_sa_loyalty_kk_bby, 0) AS absatz_sa_loyalty_kk_bby,
   COALESCE(ab_agg.absatz_sa_loyalty_kk_c_bby, 0) AS absatz_sa_loyalty_kk_c_bby,
   COALESCE(ab_agg.sales_fg, 0) AS sales_fg
  FROM kfl_production_dbp_data.angebot_art_wup_zu_1 AS A_ART_WUP
   INNER JOIN kfl_production_dbp_data.angebot_1 AS A ON A_ART_WUP.angebot_nr = A.angebot_nr AND A_ART_WUP.mandant_id = A.mandant_id
       AND A.angebot_geloescht_fg = 0
   LEFT JOIN kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu_1 AS A_WER_P_E ON A.angebot_nr = A_WER_P_E.angebot_nr
       AND A.mandant_id = A_WER_P_E.mandant_id AND (A_WER_P_E.werbemittelkanal_bez <> 'keine Information verfügbar' OR
        A_WER_P_E.werbethema_bez <> '' OR A_WER_P_E.werbeflaechenabschnitt_name <> '')
   LEFT JOIN (SELECT mandant_id,
     angebot_nr,
     MAX(CASE
       WHEN angebot_attribut_id = 44
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS bestand_bme,
     MAX(CASE
       WHEN angebot_attribut_id = 42
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS mindestmenge_bme,
     MAX(CASE
       WHEN angebot_attribut_id = 43
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS maximalmenge_bme,
     MAX(CASE
       WHEN angebot_attribut_id = 41
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS masterbonus_fg,
     MAX(CASE
       WHEN angebot_attribut_id = 49
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS gondelkopf_fg,
     MAX(CASE
       WHEN angebot_attribut_id = 47
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS stimmung_fg,
     MAX(CASE
       WHEN angebot_attribut_id = 48
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS preishammer_fg,
     MAX(CASE
       WHEN angebot_attribut_id = 53
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS ek_art_id_ref,
     MAX(CASE
       WHEN angebot_attribut_id = 46
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS topartikel_fg
    FROM kfl_production_dbp_data.angebot_attribut_zu_1
    WHERE angebot_attribut_id BETWEEN 40 AND 53
    GROUP BY mandant_id,
     angebot_nr) AS A_ATTR ON A.angebot_nr = A_ATTR.angebot_nr AND A.mandant_id = A_ATTR.mandant_id
   LEFT JOIN kfl_production_dbp_data.avq_werbung_1 AS AVQ_W ON A.dat_angebot_gueltig_von = AVQ_W.dat_aktion_von AND A.dat_angebot_gueltig_bis
         = AVQ_W.dat_aktion_bis AND A_ART_WUP.art_id = AVQ_W.art_id AND A_ART_WUP.mandant_id = AVQ_W.mandant_id AND
     A_ART_WUP.wup_id = AVQ_W.wup_id
   LEFT JOIN (SELECT angebot_nr,
     wup_id,
     art_id,
     mandant_id,
     MAX(CASE
       WHEN menge > 0
       THEN 1
       ELSE 0
       END) AS sales_fg,
     SUM(menge) AS menge,
     SUM(umsatz_netto) AS umsatz_netto,
     SUM(absatz_af_n_loyalty_schm_bby) AS absatz_af_n_loyalty_schm_bby,
     SUM(absatz_af_loyalty_schm_bby) AS absatz_af_loyalty_schm_bby,
     SUM(absatz_af_n_loyalty_bby) AS absatz_af_n_loyalty_bby,
     SUM(absatz_af_loyalty_bby) AS absatz_af_loyalty_bby,
     SUM(absatz_sa_n_loyalty) AS absatz_sa_n_loyalty,
     SUM(absatz_sa_loyalty) AS absatz_sa_loyalty,
     SUM(absatz_sa_n_loyalty_bby) AS absatz_sa_n_loyalty_bby,
     SUM(absatz_sa_loyalty_bby) AS absatz_sa_loyalty_bby,
     SUM(absatz_sa_loyalty_kk_bby) AS absatz_sa_loyalty_kk_bby,
     SUM(absatz_sa_loyalty_kk_c_bby) AS absatz_sa_loyalty_kk_c_bby
    FROM AB
    GROUP BY angebot_nr,
     wup_id,
     art_id,
     mandant_id) AS ab_agg ON A_ART_WUP.mandant_id = ab_agg.mandant_id AND A_ART_WUP.wup_id = ab_agg.wup_id AND
      A_ART_WUP.art_id = ab_agg.art_id AND A_ART_WUP.angebot_nr = ab_agg.angebot_nr
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS WW ON A.mandant_id = WW.mandant_id AND A.dat_angebot_gueltig_von
      = WW.dat
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T0 ON A.dat_angebot_gueltig_von = T0.dat
   INNER JOIN kfl_production_dbp_view.v_art_gp_wup_dts_zu_per_1 AS AGW ON CASE
         WHEN A_ART_WUP.mandant_id = 4
         THEN 7
         ELSE A_ART_WUP.mandant_id
         END = AGW.mandant_id AND A_ART_WUP.art_id = AGW.art_id AND A_ART_WUP.wup_id = AGW.wup_id AND A_ART_WUP.nb_id =
      COALESCE(AGW.nb_id, 0) AND AGW.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS A_GP ON A_ART_WUP.art_id = A_GP.art_id AND A_ART_WUP.mandant_id
         = A_GP.mandant_id AND A_ART_WUP.wup_id = A_GP.wup_id AND A_ART_WUP.nb_id = A_GP.nb_id AND A_GP.dat_bis =
     DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_msi_view_scm.mv_dt_art_spr_zu_1 AS ART_1 ON A_ART_WUP.art_id = ART.art_id AND A_ART_WUP.mandant_id
      = ART.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_scm.mv_mandant_1 AS M ON A_ART_WUP.mandant_id = M.mandant_id
  WHERE AGW.loesch_fg = 0
   AND A.angebot_status_id IN (4, 6)
   AND A.transfer_status_id IN (0, 3, 5, 6)
   AND A.angebot_geloescht_fg = 0
   AND CASE
     WHEN A_ART_WUP.mandant_id = 7 AND A.angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM') OR A_ART_WUP.mandant_id = 1 AND A
         .angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM') OR A.angebot_typ_cd NOT IN ('0009', 'ZAI', 'ZAIR', 'ZAIM',
        '0010', 'ZB09', 'ZB10')
     THEN 1
     ELSE 0
     END = 1
   AND EXISTS (SELECT 1
    FROM kfl_production_dbp_view.v_art_list_wup_zu_per_1 AS V_ART_LIST
    WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN dat_von AND dat_bis
     AND A_ART_WUP.mandant_id = mandant_id
     AND A_ART_WUP.wup_id = wup_id
     AND A_ART_WUP.art_id = art_id)
   AND CURRENT_DATE BETWEEN A.dat_angebot_gueltig_von AND A.dat_angebot_gueltig_bis
   AND T0.akt_kj = 0
   AND A_ART_WUP.art_id NOT IN (0, -1));