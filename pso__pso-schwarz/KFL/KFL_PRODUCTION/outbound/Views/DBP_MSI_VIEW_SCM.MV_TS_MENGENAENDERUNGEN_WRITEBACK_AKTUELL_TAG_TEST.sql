CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_mengenaenderungen_writeback_aktuell_tag_test (mandant_id,
aktion_id, offer_id, dat_ab, dat_bis, art_id, gp_id, dat_beladung, kjwo, kjwo_ww, tage_bis_aktionsstart, genehmigt_fg,
menge_ohne_bestand_genehmigt_fg, menge_mit_bestand_genehmigt_fg, utp_lieferant_bestaetigt_fg, mandant_id_vz,
aktionszeitraum, count_maerkte, count_maerkte_vergleich, anzahl_maerkte_agg, anzahl_artikelneuanlage_agg,
anzahl_artikelentfernung_agg, gk_fg, titel_fg, rueckseite_fg, fixmenge_fg, tv_fg, stille_aktion_fg,
max_best_generiert_fg, aktion_reihenfolge_zukunft_nr, nur_online_fg, preis_normal, preis_aktion,
werbeaenderung_artikelneuanlage_fg, werbeaenderung_artikelentfernung_fg, werbeaenderung_marktanzahlerhoehung_fg,
werbeaenderung_marktanzahlreduktion_fg, werbeaenderung_abbildungsaenderung_fg, gesteuerte_prognose_fg,
prognose_werbezeitraum_bme, bestellmenge_final_ame, bestellmenge_ohne_bestand_ame, bestellmenge_mit_bestand_ame,
bestellmenge_ohne_bestand_ame_kolli, bestellmenge_mit_bestand_ame_kolli, werbeaenderung_menge_vorlauf,
projizierter_bestand_vor_werbung_bme, preis_normal_vorlauf, preis_aktion_vorlauf, bestellung_lieferant_menge,
menge_zuletzt_dc_promo, werbeaenderung_menge_uebertragen, fixmenge_bme, fixmenge_wfl_bme,
menge_mindestplatzierung_cluster_1_ame, menge_mindestplatzierung_cluster_2_ame, menge_mindestplatzierung_cluster_3_ame,
wfl_geprueft_fg, wfl_nutzer_kommentar_txt, wbs_compound_fg, wbs_compound_fg_de, wbs_compound_fg_pl, wbs_compound_fg_bg,
wbs_compound_fg_sk, wbs_compound_fg_ro, wbs_compound_fg_cz, wbs_compound_fg_hr, rank_aktion_beladung,
auslieferungsgruppe_id, estimation_id, estimation_bez, adjustment_id, adjustment_bez, td_update, bonuskauf_promotionstyp
, wup_count_angebot, art_count_angebot, multi_offer_id_fg, estimation_change_fg, adjustment_change_fg,
wfl_menge_geprueft_fg_change_fg, wfl_nutzer_kommentar_txt_change_fg, fixmenge_wfl_bme_change_fg,
menge_mindestplatzierung_cluster_1_ame_change_fg, menge_mindestplatzierung_cluster_2_ame_change_fg,
menge_mindestplatzierung_cluster_3_ame_change_fg, menge_mit_bestand_genehmigt_fg_change_fg,
menge_ohne_bestand_genehmigt_fg_change_fg, bedarf_estimation_2_bme, bestellmenge_estimation_2_ohne_bestand_ame,
bestellmenge_estimation_2_mit_bestand_ame) AS SELECT t1.mandant_id,
 t1.aktion_id,
 t1.offer_id,
 t1.tage_bis_aktionsstart AS dat_ab,
 t1.dat_bis,
 t1.art_id,
 t1.gp_id_,
 t1.tage_bis_aktionsstart AS dat_beladung,
 t1.kjwo,
 t1.kjwo_ww,
 t1.tage_bis_aktionsstart,
 t1.genehmigt_fg,
 t1.genehmigt_fg AS menge_ohne_bestand_genehmigt_fg,
 t1.menge_mit_bestand_genehmigt_fg,
 t1.utp_lieferant_bestaetigt_fg,
 t1.mandant_id_vz,
       SUBSTR(TRIM(SUBSTR(CAST(t1.kjwo AS STRING), 1, 10)), 5, 2) || '/' || SUBSTR(TRIM(SUBSTR(CAST(t1.kjwo AS STRING),
         1, 10)), 1, 4) || ' / ' || FORMAT_DATE('%d.%m.%Y', t1.dat_ab) || ' - ' || FORMAT_DATE('%d.%m.%Y', t1.dat_bis)
 AS aktionszeitraum,
 t1.count_maerkte,
 t1.count_maerkte_vergleich,
 SUM(t1.count_maerkte_vergleich) OVER (PARTITION BY t1.mandant_id, t1.art_id, t1.dat_ab, t1.dat_bis, t1.dat_beladung
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_maerkte_agg,
 SUM(t1.a0) OVER (PARTITION BY t1.mandant_id, t1.art_id, t1.dat_ab, t1.dat_bis, t1.dat_beladung RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_artikelneuanlage_agg,
 SUM(t1.a0_0) OVER (PARTITION BY t1.mandant_id, t1.art_id, t1.dat_ab, t1.dat_bis, t1.dat_beladung RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_artikelentfernung_agg,
 t1.gk_fg_,
 t1.titel_fg,
 t1.rueckseite_fg,
 t1.fixmenge_fg,
 t1.tv_fg,
 t1.stille_aktion_fg,
 t1.max_best_generiert_fg,
 t1.aktion_reihenfolge_zukunft_nr,
 t1.nur_online_fg,
 t1.preis_normal,
 t1.preis_aktion,
  CASE
  WHEN (SUM(t1.a0) OVER (PARTITION BY t1.mandant_id, t1.art_id, t1.dat_ab, t1.dat_bis, t1.dat_beladung RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = (SUM(t1.count_maerkte_vergleich) OVER (PARTITION BY t1.mandant_id,
       t1.art_id, t1.dat_ab, t1.dat_bis, t1.dat_beladung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN 1
  ELSE 0
  END AS werbeaenderung_artikelneuanlage_fg,
  CASE
  WHEN (SUM(t1.a0_0) OVER (PARTITION BY t1.mandant_id, t1.art_id, t1.dat_ab, t1.dat_bis, t1.dat_beladung RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = (SUM(t1.count_maerkte_vergleich) OVER (PARTITION BY t1.mandant_id,
       t1.art_id, t1.dat_ab, t1.dat_bis, t1.dat_beladung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN 1
  ELSE 0
  END AS werbeaenderung_artikelentfernung_fg,
 t1.werbeaenderung_marktanzahlerhoehung_fg,
 t1.werbeaenderung_marktanzahlreduktion_fg,
 t1.werbeaenderung_abbildungsaenderung_fg,
 COALESCE(t1.a0_1, 0) AS gesteuerte_prognose_fg,
 t1.prognose_werbezeitraum_bme,
 0 AS bestellmenge_final_ame,
 t1.bestellmenge_ohne_bestand_ame,
 t1.bestellmenge_mit_bestand_ame,
 t1.bestellmenge_ohne_bestand_ame_kolli,
 t1.bestellmenge_mit_bestand_ame_kolli,
 t1.werbeaenderung_menge_vorlauf,
 t1.projizierter_bestand_vor_werbung_bme,
 t1.preis_normal_vorlauf,
 t1.preis_aktion_vorlauf,
 t1.bestellung_lieferant_menge,
 t1.menge_zuletzt_dc_promo,
 t1.werbeaenderung_menge_uebertragen,
 t1.fixmenge_bme,
  t1.a0_2 / t1.a0_3 AS fixmenge_wfl_bme,
  t1.a0_4 / t1.a0_6 AS menge_mindestplatzierung_cluster_1_ame_,
  t1.a0_7 / t1.a0_9 AS menge_mindestplatzierung_cluster_2_ame_,
  t1.a0_10 / t1.a0_12 AS menge_mindestplatzierung_cluster_3_ame_,
 t1.wfl_geprueft_fg,
  CASE
  WHEN COALESCE(CASE
     WHEN t1.wfl_nutzer_kommentar_txt = '-'
     THEN ''
     ELSE t1.wfl_nutzer_kommentar_txt
     END, t1.a0_13) = ''
  THEN NULL
  ELSE COALESCE(CASE
    WHEN t1.wfl_nutzer_kommentar_txt = '-'
    THEN ''
    ELSE t1.wfl_nutzer_kommentar_txt
    END, t1.a0_13)
  END AS wfl_nutzer_kommentar_txt_,
 t1.wbs_compound_fg,
 t1.wbs_compound_fg_de,
 t1.wbs_compound_fg_pl,
 t1.wbs_compound_fg_bg,
 t1.wbs_compound_fg_sk,
 t1.wbs_compound_fg_ro,
 t1.wbs_compound_fg_cz,
 t1.wbs_compound_fg_hr,
 DENSE_RANK() OVER (PARTITION BY t1.art_id, t1.mandant_id_vz0 ORDER BY t1.dat_beladung NULLS LAST) AS
 rank_aktion_beladung,
 t1.ausliefergruppe_id AS auslieferungsgruppe_id,
 t1.estimation_id_,
 t1.estimation_bez,
 t1.adjustment_id_,
 t1.adjustment_bez,
 DATE(t1.td_update) AS td_update,
 t1.bonuskauf_promotionstyp,
 t1.wup_count_angebot,
 t1.art_count_angebot,
 t1.multi_offer_id_fg,
 t1.estimation_change_fg,
 t1.adjustment_change_fg,
 t1.wfl_menge_geprueft_fg_change_fg,
 t1.wfl_nutzer_kommentar_txt_change_fg,
 t1.fixmenge_wfl_bme_change_fg,
 t1.menge_mindestplatzierung_cluster_1_ame_change_fg,
 t1.menge_mindestplatzierung_cluster_2_ame_change_fg,
 t1.menge_mindestplatzierung_cluster_3_ame_change_fg,
 t1.menge_mit_bestand_genehmigt_fg_change_fg,
 t1.menge_ohne_bestand_genehmigt_fg_change_fg,
 t1.bedarf_estimation_2_bme,
 t1.bestellmenge_estimation_2_ohne_bestand_ame,
 t1.bestellmenge_estimation_2_mit_bestand_ame
FROM (SELECT V01.mandant_id,
   V01.aktion_id,
   V01.offer_id,
   COALESCE(CASE
     WHEN V01.gp_id = 0
     THEN -1
     ELSE V01.gp_id
     END, -1) AS gp_id_,
   V01.dat_ab,
   V01.dat_bis,
   V01.art_id,
   V01.dat_beladung,
   V01.kjwo,
   DATE_DIFF(V01.dat_ab, V01.dat_beladung, DAY) AS tage_bis_aktionsstart,
   COALESCE(V02.menge_ohne_bestand_genehmigt_fg, 0) AS genehmigt_fg,
   COALESCE(V02.menge_mit_bestand_genehmigt_fg, 0) AS menge_mit_bestand_genehmigt_fg,
   V01.utp_lieferant_bestaetigt_fg,
    CASE
    WHEN V01.wup_id_vz = 6140
    THEN 4
    ELSE V01.mandant_id_vz
    END AS mandant_id_vz,
   V01.mandant_id_vz AS mandant_id_vz0,
   COALESCE(V02.wfl_menge_geprueft_fg, COALESCE(V01.wfl_menge_geprueft_fg, 0)) AS wfl_geprueft_fg,
   V02.wfl_nutzer_kommentar_txt,
   V01.ausliefergruppe_id,
   COALESCE(V02.estimation_id, V01.estimation_id) AS estimation_id_,
   V03.estimation_bez,
   COALESCE(COALESCE(V02.adjustment_id, V01.adjustment_id), 0) AS adjustment_id_,
   V03A.adjustment_bez,
   V9.kjwo_ww,
   V02.td_update,
   V07.wbs_compound_fg,
   V07.wbs_compound_fg_de,
   V07.wbs_compound_fg_pl,
   V07.wbs_compound_fg_bg,
   V07.wbs_compound_fg_sk,
   V07.wbs_compound_fg_ro,
   V07.wbs_compound_fg_cz,
   V07.wbs_compound_fg_hr,
   COUNT(DISTINCT CASE
     WHEN V01.werbeaenderung_artikelentfernung_fg = 1
     THEN NULL
     ELSE V01.wup_id
     END) AS count_maerkte,
   COUNT(DISTINCT V01.wup_id) AS count_maerkte_vergleich,
   SUM(V01.werbeaenderung_artikelneuanlage_fg) AS a0,
   SUM(V01.werbeaenderung_artikelentfernung_fg) AS a0_0,
   MAX(COALESCE(V02.gk_fg, V01.gk_fg)) AS gk_fg_,
   MAX(V01.titel_fg) AS titel_fg,
   MAX(V01.rueckseite_fg) AS rueckseite_fg,
   MAX(V01.fixmenge_fg) AS fixmenge_fg,
   MAX(V01.tv_fg) AS tv_fg,
   MAX(V01.stille_aktion_fg) AS stille_aktion_fg,
   MAX(V01.best_generiert_fg) AS max_best_generiert_fg,
   MAX(V01.aktion_reihenfolge_zukunft_nr) AS aktion_reihenfolge_zukunft_nr,
   MAX(V01.nur_online_fg) AS nur_online_fg,
   AVG(COALESCE(V01.preis_normal, 0)) AS preis_normal,
   AVG(COALESCE(V01.preis_aktion, 0)) AS preis_aktion,
   MAX(V01.werbeaenderung_marktanzahlerhoehung_fg) AS werbeaenderung_marktanzahlerhoehung_fg,
   MAX(V01.werbeaenderung_marktanzahlreduktion_fg) AS werbeaenderung_marktanzahlreduktion_fg,
   MAX(V01.werbeaenderung_abbildungsaenderung_fg) AS werbeaenderung_abbildungsaenderung_fg,
   MAX(V01.gesteuerte_prognose_fg) AS a0_1,
   SUM(V01.prognose_werbezeitraum_bme) AS prognose_werbezeitraum_bme,
   SUM(V01.bestellmenge_ohne_bestand_ame) AS bestellmenge_ohne_bestand_ame,
   SUM(V01.bestellmenge_mit_bestand_ame) AS bestellmenge_mit_bestand_ame,
   SUM(V01.bestellmenge_ohne_bestand_ame * V01.kollifaktor) AS bestellmenge_ohne_bestand_ame_kolli,
   SUM(V01.bestellmenge_mit_bestand_ame * V01.kollifaktor) AS bestellmenge_mit_bestand_ame_kolli,
   SUM(V01.werbeaenderung_menge_vorlauf) AS werbeaenderung_menge_vorlauf,
   SUM(V01.projizierter_bestand_vor_werbung_bme) AS projizierter_bestand_vor_werbung_bme,
   AVG(COALESCE(V01.preis_normal_vorlauf, 0)) AS preis_normal_vorlauf,
   AVG(COALESCE(V01.preis_aktion_vorlauf, 0)) AS preis_aktion_vorlauf,
   SUM(V01.bestellung_lieferant_menge) AS bestellung_lieferant_menge,
   SUM(V01.menge_zuletzt_dc_promo) AS menge_zuletzt_dc_promo,
   SUM(V02.werbeaenderung_menge_uebertragen) AS werbeaenderung_menge_uebertragen,
   AVG(V01.fixmenge_bme) AS fixmenge_bme,
   AVG(CAST(COALESCE(V02.fixmenge_wfl_bme, V01.fixmenge_wfl_bme) AS BIGNUMERIC)) AS a0_2,
   MAX(IF(V06.gp_count = 0, NULL, V06.gp_count)) AS a0_3,
   AVG(V02.menge_mindestplatzierung_cluster_1_ame) AS a0_4,
   MAX(CASE
     WHEN V01.min_platzierung_markt_cluster_id = 1
     THEN V01.menge_mindestplatzierung_bme / V01.kollifaktor
     ELSE NULL
     END) AS a0_5,
   MAX(CASE
     WHEN V01.min_platzierung_markt_cluster_id = 1
     THEN IF(V06.gp_count = 0, NULL, V06.gp_count)
     ELSE NULL
     END) AS a0_6,
   AVG(V02.menge_mindestplatzierung_cluster_2_ame) AS a0_7,
   MAX(CASE
     WHEN V01.min_platzierung_markt_cluster_id = 2
     THEN V01.menge_mindestplatzierung_bme / V01.kollifaktor
     ELSE NULL
     END) AS a0_8,
   MAX(CASE
     WHEN V01.min_platzierung_markt_cluster_id = 2
     THEN IF(V06.gp_count = 0, NULL, V06.gp_count)
     ELSE NULL
     END) AS a0_9,
   AVG(V02.menge_mindestplatzierung_cluster_3_ame) AS a0_10,
   MAX(CASE
     WHEN V01.min_platzierung_markt_cluster_id = 3
     THEN V01.menge_mindestplatzierung_bme / V01.kollifaktor
     ELSE NULL
     END) AS a0_11,
   MAX(CASE
     WHEN V01.min_platzierung_markt_cluster_id = 3
     THEN IF(V06.gp_count = 0, NULL, V06.gp_count)
     ELSE NULL
     END) AS a0_12,
   MAX(CASE
     WHEN V01.wfl_nutzer_kommentar_txt = '-'
     THEN NULL
     ELSE V01.wfl_nutzer_kommentar_txt
     END) AS a0_13,
   MAX(V01.bonuskauf_promotionstyp_liste_txt) AS bonuskauf_promotionstyp,
   MAX(V05A.wup_count_angebot) AS wup_count_angebot,
   MAX(V05A.art_count_angebot) AS art_count_angebot,
   MAX(V01.multi_offer_id_fg) AS multi_offer_id_fg,
   MAX(CASE
     WHEN V01.estimation_id <> V02.estimation_id AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS estimation_change_fg,
   MAX(CASE
     WHEN IFNULL(V01.adjustment_id, 0) <> V02.adjustment_id AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS adjustment_change_fg,
   MAX(CASE
     WHEN V01.wfl_menge_geprueft_fg <> V02.wfl_menge_geprueft_fg AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS wfl_menge_geprueft_fg_change_fg,
   MAX(CASE
     WHEN COALESCE(V01.wfl_nutzer_kommentar_txt, '-') <> V02.wfl_nutzer_kommentar_txt AND DATE(V02.td_update) =
       CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS wfl_nutzer_kommentar_txt_change_fg,
   MAX(CASE
     WHEN V01.fixmenge_wfl_bme <> V02.fixmenge_wfl_bme AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS fixmenge_wfl_bme_change_fg,
   MAX(CASE
     WHEN CASE
        WHEN V01.min_platzierung_markt_cluster_id = 1
        THEN V01.menge_mindestplatzierung_bme / V01.kollifaktor
        ELSE 0
        END <> COALESCE(V02.menge_mindestplatzierung_cluster_1_ame, 0) AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS menge_mindestplatzierung_cluster_1_ame_change_fg,
   MAX(CASE
     WHEN CASE
        WHEN V01.min_platzierung_markt_cluster_id = 2
        THEN V01.menge_mindestplatzierung_bme / V01.kollifaktor
        ELSE 0
        END <> COALESCE(V02.menge_mindestplatzierung_cluster_2_ame, 0) AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS menge_mindestplatzierung_cluster_2_ame_change_fg,
   MAX(CASE
     WHEN CASE
        WHEN V01.min_platzierung_markt_cluster_id = 3
        THEN V01.menge_mindestplatzierung_bme / V01.kollifaktor
        ELSE 0
        END <> COALESCE(V02.menge_mindestplatzierung_cluster_3_ame, 0) AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS menge_mindestplatzierung_cluster_3_ame_change_fg,
   MAX(CASE
     WHEN V02.menge_mit_bestand_genehmigt_fg = 1 AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS menge_mit_bestand_genehmigt_fg_change_fg,
   MAX(CASE
     WHEN V02.menge_ohne_bestand_genehmigt_fg = 1 AND DATE(V02.td_update) = CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS menge_ohne_bestand_genehmigt_fg_change_fg,
   SUM(V01.bedarf_estimation_id_2_bme) AS bedarf_estimation_2_bme,
   SUM(V01.bestellmenge_estimation_id_2_ohne_bestand_ame) AS bestellmenge_estimation_2_ohne_bestand_ame,
   SUM(V01.bestellmenge_estimation_id_2_mit_bestand_ame) AS bestellmenge_estimation_2_mit_bestand_ame
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS V01
   LEFT JOIN kfl_production_dbp_view.v_ts_mengenaenderungen_writeback AS V02 ON V01.mandant_id = V02.mandant_id AND V01
          .aktion_id = V02.aktion_id AND V01.offer_id = V02.angebot_id AND V01.dat_ab = V02.dat_von AND V01.dat_bis =
       V02.dat_bis AND V01.art_id = V02.art_id AND V01.dat_beladung = V02.dat_beladung
   LEFT JOIN kfl_production_dbp_msi_view_scm.mv_dt_werbeaenderung_zum_vortag AS V07 ON V01.mandant_id = V07.mandant_id
        AND V01.dat_ab = V07.dat_ab AND V01.dat_bis = V07.dat_bis AND V01.art_id = V07.art_id AND V01.offer_id = V07.offer_id
       AND V01.aktion_id = V07.aktion_id
   LEFT JOIN kfl_production_dbp_msi_view_scm.mv_dt_pmr_counts AS V05A ON V01.mandant_id = V05A.mandant_id AND V01.dat_ab
          = V05A.dat_von AND V01.dat_bis = V05A.dat_bis AND V01.art_id = V05A.art_id AND V01.wup_id = V05A.wup_id AND
     V01.nb_id = V05A.nb_id
   LEFT JOIN kfl_production_dbp_msi_view_scm.mv_dt_gp_counts AS V06 ON V01.mandant_id = V06.mandant_id AND V01.dat_ab =
        V06.dat_von AND V01.dat_bis = V06.dat_bis AND V01.art_id = V06.art_id AND V01.min_platzierung_markt_cluster_id =
     V06.min_platzierung_markt_cluster_id
   LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation AS V03 ON COALESCE(V02.estimation_id, V01.estimation_id) = V03.estimation_id
      AND V01.mandant_id = V03.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_wbs_l_adjustment AS V03A ON COALESCE(COALESCE(V02.adjustment_id, V01.adjustment_id
       ), 0) = V03A.adjustment_id AND V01.mandant_id = V03A.mandant_id
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl AS V9 ON V01.mandant_id = V9.mandant_id AND V01.dat_ab = V9.dat
  WHERE V01.dat_beladung = CURRENT_DATE
   AND V01.werbeaenderung_artikelentfernung_fg = 0
  GROUP BY V01.mandant_id,
   V01.aktion_id,
   V01.offer_id,
   gp_id_,
   V01.dat_ab,
   V01.dat_bis,
   V01.art_id,
   V01.dat_beladung,
   V01.kjwo,
   tage_bis_aktionsstart,
   genehmigt_fg,
   menge_mit_bestand_genehmigt_fg,
   V01.utp_lieferant_bestaetigt_fg,
   mandant_id_vz,
   mandant_id_vz0,
   wfl_geprueft_fg,
   V02.wfl_nutzer_kommentar_txt,
   V01.ausliefergruppe_id,
   estimation_id_,
   V03.estimation_bez,
   adjustment_id_,
   V03A.adjustment_bez,
   V9.kjwo_ww,
   V02.td_update,
   V07.wbs_compound_fg,
   V07.wbs_compound_fg_de,
   V07.wbs_compound_fg_pl,
   V07.wbs_compound_fg_bg,
   V07.wbs_compound_fg_sk,
   V07.wbs_compound_fg_ro,
   V07.wbs_compound_fg_cz,
   V07.wbs_compound_fg_hr) AS t1;