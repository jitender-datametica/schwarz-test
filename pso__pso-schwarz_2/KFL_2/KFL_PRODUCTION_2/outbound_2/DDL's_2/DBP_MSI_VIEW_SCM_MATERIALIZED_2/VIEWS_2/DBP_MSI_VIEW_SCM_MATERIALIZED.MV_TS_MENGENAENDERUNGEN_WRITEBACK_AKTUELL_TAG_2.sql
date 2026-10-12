CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_mengenaenderungen_writeback_aktuell_tag_2 (mandant_id
, aktion_id, offer_id, dat_ab, dat_bis, art_id, gp_id, dat_beladung, kjwo, kjwo_ww, tage_bis_aktionsstart, genehmigt_fg
, menge_ohne_bestand_genehmigt_fg, menge_mit_bestand_genehmigt_fg, utp_lieferant_bestaetigt_fg, mandant_id_vz,
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
bestellmenge_estimation_2_mit_bestand_ame) AS WITH PMR_COUNTS AS (SELECT mandant_id,
   dat_von,
   dat_bis,
   art_id,
   wup_id,
   nb_id,
   STRING_AGG(`A11869`, '|' ORDER BY distinct_wup_count IS NULL, distinct_wup_count) AS wup_count_angebot,
   STRING_AGG(`A118611`, '|' ORDER BY distinct_art_count IS NULL, distinct_art_count) AS art_count_angebot
  FROM (SELECT mandant_id,
     dat_von,
     dat_bis,
     art_id,
     wup_id,
     nb_id,
     COUNT(wup_id) OVER (PARTITION BY art_id, mandant_id, dat_von, dat_bis, angebot_id RANGE BETWEEN UNBOUNDED PRECEDING
      AND UNBOUNDED FOLLOWING) AS distinct_wup_count,
     COUNT(art_id) OVER (PARTITION BY mandant_id, dat_von, dat_bis, angebot_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS distinct_art_count,
     CAST(COUNT(wup_id) OVER (PARTITION BY art_id, mandant_id, dat_von, dat_bis, angebot_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING)
     AS `A11869`,
     '|' AS `A118610`,
     CAST(COUNT(art_id) OVER (PARTITION BY mandant_id, dat_von, dat_bis, angebot_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING)
     AS `A118611`
    FROM kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_2 AS V05B
    WHERE dat_von >= CURRENT_DATE
    GROUP BY mandant_id,
     dat_von,
     dat_bis,
     angebot_id,
     art_id,
     wup_id,
     nb_id) AS t2
  GROUP BY mandant_id,
   dat_von,
   dat_bis,
   art_id,
   wup_id,
   nb_id), GP_COUNT AS (SELECT mandant_id,
   art_id,
   dat_ab AS dat_von,
   dat_bis,
   min_platzierung_markt_cluster_id,
   dat_beladung,
   COUNT(DISTINCT gp_id) AS gp_count
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS V01
  WHERE dat_beladung = CURRENT_DATE
  GROUP BY mandant_id,
   art_id,
   dat_von,
   dat_bis,
   dat_beladung,
   min_platzierung_markt_cluster_id) (SELECT t11.mandant_id,
   t11.aktion_id,
   t11.offer_id,
   t11.dat_ab,
   t11.dat_bis,
   t11.art_id,
   t11.gp_id_,
   t11.dat_beladung,
   t11.kjwo,
   t11.kjwo_ww,
   t11.tage_bis_aktionsstart,
   t11.genehmigt_fg,
   t11.genehmigt_fg AS menge_ohne_bestand_genehmigt_fg,
   t11.menge_mit_bestand_genehmigt_fg,
   t11.dm__operand0,
   t11.mandant_id_vz,
         SUBSTR(TRIM(SUBSTR(CAST(t11.kjwo AS STRING), 1, 39)), 5, 2) || '/' || SUBSTR(TRIM(SUBSTR(CAST(t11.kjwo AS STRING)
           , 1, 39)), 1, 4) || ' / ' || FORMAT_DATE('%d.%m.%Y', t11.dat_ab) || ' - ' || FORMAT_DATE('%d.%m.%Y', t11.dat_bis
     ) AS aktionszeitraum,
   t11.count_maerkte,
   t11.count_maerkte_vergleich,
   SUM(t11.count_maerkte_vergleich) OVER (PARTITION BY t11.mandant_id, t11.art_id, t11.dat_ab, t11.dat_bis, t11.dat_beladung
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_maerkte_agg,
   SUM(t11.a0) OVER (PARTITION BY t11.mandant_id, t11.art_id, t11.dat_ab, t11.dat_bis, t11.dat_beladung RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_artikelneuanlage_agg,
   SUM(t11.a0_0) OVER (PARTITION BY t11.mandant_id, t11.art_id, t11.dat_ab, t11.dat_bis, t11.dat_beladung RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_artikelentfernung_agg,
   t11.gk_fg_,
   t11.titel_fg,
   t11.rueckseite_fg,
   t11.fixmenge_fg,
   t11.tv_fg,
   t11.stille_aktion_fg,
   t11.max_best_generiert_fg,
   t11.aktion_reihenfolge_zukunft_nr,
   t11.nur_online_fg,
   t11.preis_normal,
   t11.preis_aktion,
    CASE
    WHEN (SUM(t11.a0) OVER (PARTITION BY t11.mandant_id, t11.art_id, t11.dat_ab, t11.dat_bis, t11.dat_beladung
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = (SUM(t11.count_maerkte_vergleich) OVER (PARTITION BY
         t11.mandant_id, t11.art_id, t11.dat_ab, t11.dat_bis, t11.dat_beladung RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING))
    THEN 1
    ELSE 0
    END AS werbeaenderung_artikelneuanlage_fg,
    CASE
    WHEN (SUM(t11.a0_0) OVER (PARTITION BY t11.mandant_id, t11.art_id, t11.dat_ab, t11.dat_bis, t11.dat_beladung
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = (SUM(t11.count_maerkte_vergleich) OVER (PARTITION BY
         t11.mandant_id, t11.art_id, t11.dat_ab, t11.dat_bis, t11.dat_beladung RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING))
    THEN 1
    ELSE 0
    END AS werbeaenderung_artikelentfernung_fg,
   t11.werbeaenderung_marktanzahlerhoehung_fg,
   t11.werbeaenderung_marktanzahlreduktion_fg,
   t11.werbeaenderung_abbildungsaenderung_fg,
   COALESCE(t11.a0_1, 0) AS gesteuerte_prognose_fg,
   t11.prognose_werbezeitraum_bme,
   0 AS bestellmenge_final_ame,
   t11.bestellmenge_ohne_bestand_ame,
   t11.bestellmenge_mit_bestand_ame,
   t11.bestellmenge_ohne_bestand_ame_kolli,
   t11.bestellmenge_mit_bestand_ame_kolli,
   t11.werbeaenderung_menge_vorlauf,
   t11.projizierter_bestand_vor_werbung_bme,
   t11.preis_normal_vorlauf,
   t11.preis_aktion_vorlauf,
   t11.bestellung_lieferant_menge,
   t11.menge_zuletzt_dc_promo,
   t11.werbeaenderung_menge_uebertragen,
   t11.fixmenge_bme,
    t11.a0_2 / t11.a0_3,
    t11.a0_4 / t11.a0_6 AS menge_mindestplatzierung_cluster_1_ame_,
    t11.a0_7 / t11.a0_9 AS menge_mindestplatzierung_cluster_2_ame_,
    t11.a0_10 / t11.a0_12 AS menge_mindestplatzierung_cluster_3_ame_,
   t11.wfl_geprueft_fg,
    CASE
    WHEN COALESCE(CASE
       WHEN t11.wfl_nutzer_kommentar_txt = '-'
       THEN ''
       ELSE t11.wfl_nutzer_kommentar_txt
       END, t11.a0_13) = ''
    THEN NULL
    ELSE COALESCE(CASE
      WHEN t11.wfl_nutzer_kommentar_txt = '-'
      THEN ''
      ELSE t11.wfl_nutzer_kommentar_txt
      END, t11.a0_13)
    END AS wfl_nutzer_kommentar_txt_,
   CONCAT(t11.a0_14, t11.a0_15, t11.a0_16, t11.a0_17, t11.a0_18, t11.a0_19, t11.a0_20, t11.a0_21, t11.a0_22, t11.a0_23,
    t11.a0_24, t11.a0_25, t11.a0_26, t11.a0_27, t11.a0_28, t11.a0_29, t11.a0_30, t11.a0_31, t11.a0_32, t11.a0_33) AS
   wbs_compound_fg,
   CONCAT(t11.a0_14, t11.a0_15, t11.a0_16, t11.a0_17, t11.a0_18, t11.a0_19, t11.a0_20, t11.a0_21, t11.a0_22, t11.a0_23,
    t11.a0_24, t11.a0_25, t11.a0_26, t11.a0_27, t11.a0_28, t11.a0_29, t11.a0_30, t11.a0_31, t11.a0_32, t11.a0_33) AS
   wbs_compound_fg_de,
   CONCAT(t11.a0_34, t11.a0_35, t11.a0_36, t11.a0_37, t11.a0_38, t11.a0_39, t11.a0_40, t11.a0_41, t11.a0_42, t11.a0_43,
    t11.a0_44, t11.a0_45, t11.a0_46, t11.a0_47, t11.a0_48, t11.a0_49, t11.a0_50, t11.a0_51, t11.a0_52, t11.a0_53) AS
   wbs_compound_fg_pl,
   CONCAT(t11.a0_54, t11.a0_55, t11.a0_56, t11.a0_57, t11.a0_58, t11.a0_59, t11.a0_60, t11.a0_61, t11.a0_62, t11.a0_63,
    t11.a0_64, t11.a0_65, t11.a0_66, t11.a0_67, t11.a0_68, t11.a0_69, t11.a0_70, t11.a0_71, t11.a0_72, t11.a0_73) AS
   wbs_compound_fg_bg,
   CONCAT(t11.a0_74, t11.a0_75, t11.a0_76, t11.a0_77, t11.a0_78, t11.a0_79, t11.a0_80, t11.a0_81, t11.a0_82, t11.a0_83,
    t11.a0_84, t11.a0_85, t11.a0_86, t11.a0_87, t11.a0_88, t11.a0_89, t11.a0_90, t11.a0_91, t11.a0_92, t11.a0_93) AS
   wbs_compound_fg_sk,
   CONCAT(t11.a0_94, t11.a0_95, t11.a0_96, t11.a0_97, t11.a0_98, t11.a0_99, t11.a0_100, t11.a0_101, t11.a0_102, t11.a0_103
    , t11.a0_104, t11.a0_105, t11.a0_106, t11.a0_107, t11.a0_108, t11.a0_109, t11.a0_110, t11.a0_111, t11.a0_112, t11.a0_113
    ) AS wbs_compound_fg_ro,
   CONCAT(t11.a0_114, t11.a0_115, t11.a0_116, t11.a0_117, t11.a0_118, t11.a0_119, t11.a0_120, t11.a0_121, t11.a0_122,
    t11.a0_123, t11.a0_124, t11.a0_125, t11.a0_126, t11.a0_127, t11.a0_128, t11.a0_129, t11.a0_130, t11.a0_131, t11.a0_132
    , t11.a0_133) AS wbs_compound_fg_cz,
   CONCAT(t11.a0_134, t11.a0_135, t11.a0_136, t11.a0_137, t11.a0_138, t11.a0_139, t11.a0_140, t11.a0_141, t11.a0_142,
    t11.a0_143, t11.a0_144, t11.a0_145, t11.a0_146, t11.a0_147, t11.a0_148, t11.a0_149, t11.a0_150, t11.a0_151, t11.a0_152
    , t11.a0_153) AS wbs_compound_fg_hr,
   DENSE_RANK() OVER (PARTITION BY t11.art_id, t11.mandant_id_vz0 ORDER BY t11.dat_beladung IS NULL, t11.dat_beladung)
   AS rank_aktion_beladung,
   t11.ausliefergruppe_id,
   t11.estimation_id_,
   t11.estimation_bez,
   t11.adjustment_id_,
   t11.adjustment_bez,
   DATE(t11.td_update),
   t11.bonuskauf_promotionstyp,
   t11.wup_count_angebot,
   t11.art_count_angebot,
   t11.multi_offer_id_fg,
   t11.estimation_change_fg,
   t11.adjustment_change_fg,
   t11.wfl_menge_geprueft_fg_change_fg,
   t11.wfl_nutzer_kommentar_txt_change_fg,
   t11.fixmenge_wfl_bme_change_fg,
   t11.menge_mindestplatzierung_cluster_1_ame_change_fg,
   t11.menge_mindestplatzierung_cluster_2_ame_change_fg,
   t11.menge_mindestplatzierung_cluster_3_ame_change_fg,
   t11.menge_mit_bestand_genehmigt_fg_change_fg,
   t11.menge_ohne_bestand_genehmigt_fg_change_fg,
   t11.bedarf_estimation_2_bme,
   t11.bestellmenge_estimation_2_ohne_bestand_ame,
   t11.bestellmenge_estimation_2_mit_bestand_ame
  FROM (SELECT V01.mandant_id,
     V01.aktion_id,
     V01.offer_id,
     COALESCE(CASE
       WHEN V01.gp_id = 0
       THEN CAST(-1 AS BIGNUMERIC)
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
     COALESCE(V01.utp_lieferant_bestaetigt_fg, 0) AS dm__operand0,
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
      CASE
      WHEN V01.estimation_id <> V02.estimation_id AND DATE(V02.td_update) = CURRENT_DATE
      THEN 1
      ELSE 0
      END AS estimation_change_fg,
      CASE
      WHEN IFNULL(V01.adjustment_id, 0) <> V02.adjustment_id AND DATE(V02.td_update) = CURRENT_DATE
      THEN 1
      ELSE 0
      END AS adjustment_change_fg,
      CASE
      WHEN V01.wfl_menge_geprueft_fg <> V02.wfl_menge_geprueft_fg AND DATE(V02.td_update) = CURRENT_DATE
      THEN 1
      ELSE 0
      END AS wfl_menge_geprueft_fg_change_fg,
      CASE
      WHEN COALESCE(V01.wfl_nutzer_kommentar_txt, '-') <> V02.wfl_nutzer_kommentar_txt AND DATE(V02.td_update) =
        CURRENT_DATE
      THEN 1
      ELSE 0
      END AS wfl_nutzer_kommentar_txt_change_fg,
      CASE
      WHEN V01.fixmenge_wfl_bme <> V02.fixmenge_wfl_bme AND DATE(V02.td_update) = CURRENT_DATE
      THEN 1
      ELSE 0
      END AS fixmenge_wfl_bme_change_fg,
      CASE
      WHEN V02.menge_mit_bestand_genehmigt_fg = 1 AND DATE(V02.td_update) = CURRENT_DATE
      THEN 1
      ELSE 0
      END AS menge_mit_bestand_genehmigt_fg_change_fg,
      CASE
      WHEN V02.menge_ohne_bestand_genehmigt_fg = 1 AND DATE(V02.td_update) = CURRENT_DATE
      THEN 1
      ELSE 0
      END AS menge_ohne_bestand_genehmigt_fg_change_fg,
     COALESCE(V02.gk_fg, V01.gk_fg) AS gk_fg_,
     COUNT(DISTINCT CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg = 1
       THEN NULL
       ELSE V01.wup_id
       END) AS count_maerkte,
     COUNT(DISTINCT V01.wup_id) AS count_maerkte_vergleich,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.werbeaenderung_artikelneuanlage_fg
       ELSE NULL
       END) AS a0,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.werbeaenderung_artikelentfernung_fg
       ELSE NULL
       END) AS a0_0,
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
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.prognose_werbezeitraum_bme
       ELSE NULL
       END) AS prognose_werbezeitraum_bme,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bestellmenge_ohne_bestand_ame
       ELSE NULL
       END) AS bestellmenge_ohne_bestand_ame,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bestellmenge_mit_bestand_ame
       ELSE NULL
       END) AS bestellmenge_mit_bestand_ame,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bestellmenge_ohne_bestand_ame * V01.kollifaktor
       ELSE NULL
       END) AS bestellmenge_ohne_bestand_ame_kolli,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bestellmenge_mit_bestand_ame * V01.kollifaktor
       ELSE NULL
       END) AS bestellmenge_mit_bestand_ame_kolli,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.werbeaenderung_menge_vorlauf
       ELSE NULL
       END) AS werbeaenderung_menge_vorlauf,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.projizierter_bestand_vor_werbung_bme
       ELSE NULL
       END) AS projizierter_bestand_vor_werbung_bme,
     AVG(COALESCE(V01.preis_normal_vorlauf, 0)) AS preis_normal_vorlauf,
     AVG(COALESCE(V01.preis_aktion_vorlauf, 0)) AS preis_aktion_vorlauf,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bestellung_lieferant_menge
       ELSE NULL
       END) AS bestellung_lieferant_menge,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.menge_zuletzt_dc_promo
       ELSE NULL
       END) AS menge_zuletzt_dc_promo,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V02.werbeaenderung_menge_uebertragen
       ELSE NULL
       END) AS werbeaenderung_menge_uebertragen,
     AVG(V01.fixmenge_bme) AS fixmenge_bme,
     AVG(CAST(COALESCE(V02.fixmenge_wfl_bme, V01.fixmenge_wfl_bme) AS BIGNUMERIC)) AS a0_2,
     MAX(IF(v06.gp_count = 0, NULL, v06.gp_count)) AS a0_3,
     AVG(V02.menge_mindestplatzierung_cluster_1_ame) AS a0_4,
     MAX(CASE
       WHEN V01.min_platzierung_markt_cluster_id = 1
       THEN V01.menge_mindestplatzierung_bme / V01.kollifaktor
       ELSE NULL
       END) AS a0_5,
     MAX(CASE
       WHEN V01.min_platzierung_markt_cluster_id = 1
       THEN IF(v06.gp_count = 0, NULL, v06.gp_count)
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
       THEN IF(v06.gp_count = 0, NULL, v06.gp_count)
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
       THEN IF(v06.gp_count = 0, NULL, v06.gp_count)
       ELSE NULL
       END) AS a0_12,
     MAX(CASE
       WHEN V01.wfl_nutzer_kommentar_txt = '-'
       THEN NULL
       ELSE V01.wfl_nutzer_kommentar_txt
       END) AS a0_13,
     MAX(CASE
       WHEN V01.werbeaenderung_werbethema_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Werbethema'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_14,
     MAX(CASE
       WHEN V01.werbeaenderung_sonstiges_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Sonstiges'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_15,
     MAX(CASE
       WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Radio TV Billboard'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_16,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Normalpreisreduktion'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_17,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Normalpreiserhöhung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_18,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Marktanzahlreduktion'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_19,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Marktanzahlerhöhung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_20,
     MAX(CASE
       WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Kolliinhaltsänderung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_21,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Artikelneuanlage'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_22,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Artikelentfernung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_23,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Angebotspreisreduktion'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_24,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Angebotspreiserhöhung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_25,
     MAX(CASE
       WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Abbildungsänderung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_26,
     MAX(CASE
       WHEN V01.gesteuerte_prognose_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Prognosesteuerung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_27,
     MAX(CASE
       WHEN V01.rabattaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Rabattänderung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_28,
     MAX(CASE
       WHEN V01.werbelistung_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Werbelistungsänderung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_29,
     MAX(CASE
       WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Aktionsreihenfolgeänderung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_30,
     MAX(CASE
       WHEN V01.posten_kz_sap_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| Postenänderung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_31,
     MAX(CASE
       WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| KDN/KDP Änderung'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_32,
     MAX(CASE
       WHEN V01.werbeaenderung_bonuskauf_promotionstyp_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 22
        THEN '| AKART'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_33,
     MAX(CASE
       WHEN V01.werbeaenderung_werbethema_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Temat promocji'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_34,
     MAX(CASE
       WHEN V01.werbeaenderung_sonstiges_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Inne'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_35,
     MAX(CASE
       WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Radio TV billboard'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_36,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Obniżka ceny standardowej'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_37,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Wzrost ceny standardowej'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_38,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Redukcja liczby sklepów'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_39,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Wzrost liczby sklepów'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_40,
     MAX(CASE
       WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Koli zmiana'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_41,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Artykuł in'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_42,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Artykuł out'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_43,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Obniżka ceny promocyjnej'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_44,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Wzrost ceny promocyjnej'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_45,
     MAX(CASE
       WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Pano zmiana'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_46,
     MAX(CASE
       WHEN V01.gesteuerte_prognose_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Kontrola prognozy'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_47,
     MAX(CASE
       WHEN V01.rabattaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Zmiana rabatu'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_48,
     MAX(CASE
       WHEN V01.werbelistung_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Zmiana zalistowania promo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_49,
     MAX(CASE
       WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Zmiana rangi promo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_50,
     MAX(CASE
       WHEN V01.posten_kz_sap_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Zmiana Posten'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_51,
     MAX(CASE
       WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| Zmiana KDN/KDP'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_52,
     MAX(CASE
       WHEN V01.werbeaenderung_bonuskauf_promotionstyp_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 90
        THEN '| AKART'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_53,
     MAX(CASE
       WHEN V01.werbeaenderung_werbethema_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Промо тема'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_54,
     MAX(CASE
       WHEN V01.werbeaenderung_sonstiges_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Други'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_55,
     MAX(CASE
       WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Radio TV билборд'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_56,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Намаление на стандартна цена'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_57,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Увеличение на стандартна цена'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_58,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Намаляване броя на магазините'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_59,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Увеличаване броя на магазините'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_60,
     MAX(CASE
       WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Промяна на Колифактор'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_61,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Артикул добавен'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_62,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Артикул OUT'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_63,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Намаление на акционна цена'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_64,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Увеличение на акционна цена'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_65,
     MAX(CASE
       WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Промяна на пано'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_66,
     MAX(CASE
       WHEN V01.gesteuerte_prognose_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Контрол на прогнозата'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_67,
     MAX(CASE
       WHEN V01.rabattaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Промяна на отстъпката'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_68,
     MAX(CASE
       WHEN V01.werbelistung_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Промяна в промо листинга'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_69,
     MAX(CASE
       WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Промяна в промоционалния ранк'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_70,
     MAX(CASE
       WHEN V01.posten_kz_sap_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| Posten промяна'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_71,
     MAX(CASE
       WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| KDN/KDP промяна'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_72,
     MAX(CASE
       WHEN V01.werbeaenderung_bonuskauf_promotionstyp_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 18
        THEN '| AKART'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_73,
     MAX(CASE
       WHEN V01.werbeaenderung_werbethema_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Téma akcie'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_74,
     MAX(CASE
       WHEN V01.werbeaenderung_sonstiges_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Iné'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_75,
     MAX(CASE
       WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Rádio TV Billboard'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_76,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zníženie PC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_77,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zvýšenie PC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_78,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zníženie počtu filiálok'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_79,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zvýšenie počtu filiálok'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_80,
     MAX(CASE
       WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zmena Kolli'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_81,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Artikel_2 IN'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_82,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Artikel_2 OUT'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_83,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zníženie APC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_84,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zvýšenie APC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_85,
     MAX(CASE
       WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zmena pano'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_86,
     MAX(CASE
       WHEN V01.gesteuerte_prognose_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Kontrola FC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_87,
     MAX(CASE
       WHEN V01.rabattaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zmena zľavy'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_88,
     MAX(CASE
       WHEN V01.werbelistung_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zmena listovania  do akcie'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_89,
     MAX(CASE
       WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Zmena obdobia akcie'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_90,
     MAX(CASE
       WHEN V01.posten_kz_sap_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| Posten zmena'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_91,
     MAX(CASE
       WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| KDN/KDP zmena'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_92,
     MAX(CASE
       WHEN V01.werbeaenderung_bonuskauf_promotionstyp_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 108
        THEN '| AKART'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_93,
     MAX(CASE
       WHEN V01.werbeaenderung_werbethema_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Tema promotie'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_94,
     MAX(CASE
       WHEN V01.werbeaenderung_sonstiges_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Altele'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_95,
     MAX(CASE
       WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Panou publicitar Radio TV'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_96,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Reducere normala de pret'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_97,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Crestere normala de pret'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_98,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Reducerea numarului de filiale'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_99,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Cresterea numarului de filiale'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_100,
     MAX(CASE
       WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Modificare Kolli'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_101,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Articol IN'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_102,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Articol OUT'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_103,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Reducerea pretului de promo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_104,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Cresterea pretrului de promo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_105,
     MAX(CASE
       WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Pano schimbare'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_106,
     MAX(CASE
       WHEN V01.gesteuerte_prognose_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Forecast control'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_107,
     MAX(CASE
       WHEN V01.rabattaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Modificare discount'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_108,
     MAX(CASE
       WHEN V01.werbelistung_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Modificare listare promo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_109,
     MAX(CASE
       WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Modificare rang promo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_110,
     MAX(CASE
       WHEN V01.posten_kz_sap_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Modificare Posten'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_111,
     MAX(CASE
       WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| Modificare KDN/KDP'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_112,
     MAX(CASE
       WHEN V01.werbeaenderung_bonuskauf_promotionstyp_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 95
        THEN '| AKART'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_113,
     MAX(CASE
       WHEN V01.werbeaenderung_werbethema_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Téma akce'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_114,
     MAX(CASE
       WHEN V01.werbeaenderung_sonstiges_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Jiné'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_115,
     MAX(CASE
       WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Rádio TV billboard'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_116,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Snížení normální ceny'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_117,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Zvýšení normální ceny'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_118,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Snížení počtu filiálek'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_119,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Zvýšení počtu filiálek'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_120,
     MAX(CASE
       WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Změna kolli'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_121,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Zadání nového artiklu'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_122,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '|Odebrání artiklu'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_123,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Snížení akční ceny de promo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_124,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Zvýšení akční ceny'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_125,
     MAX(CASE
       WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Ilustrační změna'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_126,
     MAX(CASE
       WHEN V01.gesteuerte_prognose_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Kontrola prognózy'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_127,
     MAX(CASE
       WHEN V01.rabattaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Změna slevy'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_128,
     MAX(CASE
       WHEN V01.werbelistung_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Změna listování do akce'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_129,
     MAX(CASE
       WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Změna pořadí akce'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_130,
     MAX(CASE
       WHEN V01.posten_kz_sap_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| Posten Change'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_131,
     MAX(CASE
       WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| KDN/KDP Change'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_132,
     MAX(CASE
       WHEN V01.werbeaenderung_bonuskauf_promotionstyp_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 124
        THEN '| AKART'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_133,
     MAX(CASE
       WHEN V01.werbeaenderung_werbethema_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| tema akcije'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_134,
     MAX(CASE
       WHEN V01.werbeaenderung_sonstiges_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| ostalo'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_135,
     MAX(CASE
       WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| Radio, TV, ostala oglašavanja'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_136,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| sniženje normalne MPC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_137,
     MAX(CASE
       WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| povećanje normalne MPC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_138,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| smanjenje broja poslovnica'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_139,
     MAX(CASE
       WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| povećanje broja poslovnica'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_140,
     MAX(CASE
       WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| promjena pakiranja kolija'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_141,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| artikl ulazi'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_142,
     MIN(CASE
       WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| artikl izlazi'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_143,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| sniženje akcijske MPC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_144,
     MAX(CASE
       WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| povećanje akcijske MPC'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_145,
     MAX(CASE
       WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| promjena pozicije u akciji'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_146,
     MAX(CASE
       WHEN V01.gesteuerte_prognose_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| kontrola prognoze'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_147,
     MAX(CASE
       WHEN V01.rabattaenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| promjena % sniženja cijene'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_148,
     MAX(CASE
       WHEN V01.werbelistung_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| promjena broja poslovnica u akciji'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_149,
     MAX(CASE
       WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| promjena redoslijeda akcije u nizu'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_150,
     MAX(CASE
       WHEN V01.posten_kz_sap_aenderung_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| Posten promjena'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_151,
     MAX(CASE
       WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| KDN/KDP promjena'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_152,
     MAX(CASE
       WHEN V01.werbeaenderung_bonuskauf_promotionstyp_fg <> 0
       THEN CASE
        WHEN SPR.spr_id = 65
        THEN '| AKART'
        ELSE NULL
        END
       ELSE ''
       END) AS a0_153,
     MAX(V01.bonuskauf_promotionstyp_liste_txt) AS bonuskauf_promotionstyp,
     MAX(v05a.wup_count_angebot) AS wup_count_angebot,
     MAX(v05a.art_count_angebot) AS art_count_angebot,
     MAX(V01.multi_offer_id_fg) AS multi_offer_id_fg,
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
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bedarf_estimation_id_2_bme
       ELSE NULL
       END) AS bedarf_estimation_2_bme,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bestellmenge_estimation_id_2_ohne_bestand_ame
       ELSE NULL
       END) AS bestellmenge_estimation_2_ohne_bestand_ame,
     SUM(CASE
       WHEN SPR.spr_id = 22
       THEN V01.bestellmenge_estimation_id_2_mit_bestand_ame
       ELSE NULL
       END) AS bestellmenge_estimation_2_mit_bestand_ame
    FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS V01
     LEFT JOIN kfl_production_dbp_view.v_ts_mengenaenderungen_writeback_2 AS V02 ON V01.mandant_id = V02.mandant_id AND
            V01.aktion_id = V02.aktion_id AND V01.offer_id = V02.angebot_id AND V01.dat_ab = V02.dat_von AND V01.dat_bis
          = V02.dat_bis AND V01.art_id = V02.art_id AND V01.dat_beladung = V02.dat_beladung
     LEFT JOIN PMR_COUNTS AS v05a ON V01.mandant_id = v05a.mandant_id AND V01.dat_ab = v05a.dat_von AND V01.dat_bis =
          v05a.dat_bis AND V01.art_id = v05a.art_id AND V01.wup_id = v05a.wup_id AND V01.nb_id = v05a.nb_id
     LEFT JOIN GP_COUNT AS v06 ON V01.mandant_id = v06.mandant_id AND V01.dat_ab = v06.dat_von AND V01.dat_bis = v06.dat_bis
          AND V01.art_id = v06.art_id AND V01.min_platzierung_markt_cluster_id = v06.min_platzierung_markt_cluster_id
     LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation_2 AS V03 ON COALESCE(V02.estimation_id, V01.estimation_id) = V03
       .estimation_id AND V01.mandant_id = V03.mandant_id
     LEFT JOIN kfl_production_dbp_view.v_wbs_l_adjustment_2 AS V03A ON COALESCE(COALESCE(V02.adjustment_id, V01.adjustment_id
         ), 0) = V03A.adjustment_id AND V01.mandant_id = V03A.mandant_id
     LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS V9 ON V01.mandant_id = V9.mandant_id AND V01.dat_ab = V9.dat
     INNER JOIN kfl_production_dbp_view.v_spr_2 AS SPR_2 ON SPR.spr_id IN (22, 124, 108, 65, 90, 95, 18)
    WHERE V01.dat_beladung = CURRENT_DATE
     AND V01.dat_ab >= CURRENT_DATE
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
     dm__operand0,
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
     estimation_change_fg,
     adjustment_change_fg,
     wfl_menge_geprueft_fg_change_fg,
     wfl_nutzer_kommentar_txt_change_fg,
     fixmenge_wfl_bme_change_fg,
     menge_mit_bestand_genehmigt_fg_change_fg,
     menge_ohne_bestand_genehmigt_fg_change_fg,
     gk_fg_) AS t11);