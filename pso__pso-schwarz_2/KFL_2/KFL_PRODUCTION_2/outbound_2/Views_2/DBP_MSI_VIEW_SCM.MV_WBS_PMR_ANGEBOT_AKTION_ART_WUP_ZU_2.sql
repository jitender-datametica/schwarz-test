CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_pmr_angebot_aktion_art_wup_zu_2 AS WITH ALL_AKTION AS (SELECT
    mandant_id,
    art_id,
    aktion_id,
    'not pmr' AS fg,
    wup_id,
    nb_id,
    vk_aktion_brutto,
    vk_vor_aktion_brutto,
    wrg_id
   FROM kfl_production_dbp_view.v_aktion_art_wup_zu_2 AS A_ART_W
   WHERE grund_sperrung IS NULL
    AND COALESCE(geloescht_sap_fg, 0) <> 1
    AND NOT EXISTS (SELECT 1
     FROM kfl_production_dbp_view.v_angebot_art_wup_zu_2 AS A_WUP
      INNER JOIN kfl_production_dbp_view.v_angebot_2 AS A ON A_WUP.angebot_nr = A.angebot_nr AND A_WUP.mandant_id = A.mandant_id
        
     WHERE A_ART_W.mandant_id = A_WUP.mandant_id
      AND A_ART_W.art_id = A_WUP.art_id
      AND A_ART_W.aktion_id = A.aktion_id
      AND A_ART_W.wup_id = A_WUP.wup_id)
   UNION ALL
   SELECT A_WUP.mandant_id,
    A_WUP.art_id,
    A.aktion_id,
    'pmr' AS fg,
    A_WUP.wup_id,
    A_WUP.nb_id,
    A_WUP.preis_vk_brutto_aktion,
    A_WUP.preis_vk_brutto,
    A_WUP.wrg_id
   FROM kfl_production_dbp_view.v_angebot_art_wup_zu_2 AS A_WUP
    INNER JOIN kfl_production_dbp_view.v_angebot_2 AS A ON A_WUP.angebot_nr = A.angebot_nr AND A_WUP.mandant_id = A.mandant_id
      ), AB AS (SELECT t12.aktion_id,
   AB.mandant_id,
   AB.wup_id,
   AB.art_id,
   SUM(AB.menge) AS menge,
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
  FROM ALL_AKTION AS t12
   INNER JOIN kfl_production_dbp_view.v_aktion_2 AS A1 ON t12.mandant_id = A1.mandant_id AND t12.aktion_id = A1.aktion_id
   INNER JOIN kfl_production_dbp_view.v_artbew_2 AS AB ON t12.mandant_id = AB.mandant_id AND t12.wup_id = AB.wup_id AND
      t12.art_id = AB.art_id AND AB.dat BETWEEN A1.dat_von AND A1.dat_bis
   INNER JOIN kfl_production_dbp_data.tag_2 AS T0 ON A1.dat_von = T0.dat
  WHERE T0.akt_kj BETWEEN -2 AND 0
  GROUP BY t12.aktion_id,
   AB.mandant_id,
   AB.wup_id,
   AB.art_id) (SELECT t5.mandant_id,
   A_PER.mutter_wb_id,
    CASE
    WHEN A_PER.mutter_wb_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS in_gruppe_fg_,
    CASE
    WHEN CASE
      WHEN A_PER.mutter_wb_id IS NOT NULL
      THEN 1
      ELSE 0
      END = 1
    THEN COUNT(t5.art_id) OVER (PARTITION BY t5.mandant_id, t5.wup_id, A0.dat_von, A0.dat_bis, A_PER.mutter_wb_id
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    ELSE NULL
    END AS anz_art_in_gruppe,
   t5.art_id,
   t5.aktion_id,
   V05.aktuell_wup_id AS wup_id,
   t5.nb_id,
   A0.dat_von,
   A0.dat_bis,
   T.kjwo AS kjwo_von,
    DATE_DIFF(A0.dat_bis, A0.dat_von, DAY) + 1 AS aktion_dauer,
   t5.fg,
   ab_agg.menge,
   ab_agg.absatz_af_n_loyalty_schm_bby,
   ab_agg.absatz_af_loyalty_schm_bby,
   ab_agg.absatz_af_n_loyalty_bby,
   ab_agg.absatz_af_loyalty_bby,
   ab_agg.absatz_sa_n_loyalty,
   ab_agg.absatz_sa_loyalty,
   ab_agg.absatz_sa_n_loyalty_bby,
   ab_agg.absatz_sa_loyalty_bby,
   ab_agg.absatz_sa_loyalty_kk_bby,
   ab_agg.absatz_sa_loyalty_kk_c_bby,
   ab_agg.sales_fg,
   WBS_AA_PER.zeitraum_korrigierte_menge,
   t5.vk_aktion_brutto,
   t5.vk_vor_aktion_brutto,
   t5.wrg_id,
   COALESCE(ROUND(SAFE_CAST(a_pmr.angebot_nr AS BIGNUMERIC), 0), -1) AS angebot_id,
   COALESCE(LPAD(CAST(a_pmr.bonuskauf_geschaeftsvorfall_id AS STRING), 2, '0'), '-1') AS bonuskauf_geschaeftsvorfall_id
   ,
   COALESCE(a_pmr.bonuskauf_anreiztyp, 'n/a') AS bonuskauf_anreiztyp,
   a_pmr.preis_niedrigster,
   a_pmr.preis_niedrigster_diff_perc,
   a_pmr.opv_prospekt_fg,
   a_pmr.opv_markt_fg,
   aa.stimmung_fg,
   aa.preishammer_fg,
   aa.gondelkopf_fg,
   aa.ek_art_id_ref,
   COALESCE(WBS_AA_PER.gk_fg, -1) AS gk_fg,
   COALESCE(a_pmr.bonuskauf_fg, CASE
     WHEN COALESCE(CAST(lb.aktion_id AS BIGNUMERIC), 0) = 0
     THEN 0
     ELSE 1
     END) AS bonuskauf_fg,
    CASE
    WHEN COALESCE(COUNT(ROUND(SAFE_CAST(a_pmr.angebot_nr AS BIGNUMERIC), 0)) OVER (PARTITION BY t5.mandant_id, t5.wup_id
         , t5.art_id, A0.dat_von, A0.dat_bis RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) > 1
    THEN 1
    ELSE 0
    END AS multi_offer_id_fg,
   pmr_a_werf_agg.nur_online_fg,
   pmr_a_werf_agg.kundenkarte_personalisiert_fg,
   pmr_a_werf_agg.stille_aktion_fg,
   pmr_a_werf_agg.stille_aktion_mit_menge_fg,
   pmr_a_werf_agg.tv_fg,
   pmr_a_werf_agg.titelseite_fg,
   pmr_a_werf_agg.rueckseite_fg
  FROM ALL_AKTION AS t5
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON t5.mandant_id = V05.mandant_id AND t5.wup_id = V05.wup_id AND (V05
        .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
   INNER JOIN kfl_production_dbp_view.v_aktion_2 AS A0 ON t5.mandant_id = A0.mandant_id AND t5.aktion_id = A0.aktion_id
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON A0.dat_von = T.dat
   LEFT JOIN (SELECT aktion_id,
     wup_id,
     art_id,
     mandant_id,
     MAX(CASE
       WHEN menge > 0
       THEN 1
       ELSE 0
       END) AS sales_fg,
     SUM(menge) AS menge,
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
    GROUP BY aktion_id,
     wup_id,
     art_id,
     mandant_id) AS ab_agg ON t5.mandant_id = ab_agg.mandant_id AND t5.wup_id = ab_agg.wup_id AND t5.art_id = ab_agg.art_id
       AND t5.aktion_id = ab_agg.aktion_id
   LEFT JOIN (SELECT DISTINCT aktion_id,
     mandant_id
    FROM kfl_production_dbp_view.v_l_bonuskauf_2) AS lb ON t5.mandant_id = lb.mandant_id AND t5.aktion_id = lb.aktion_id
   LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS A_PER ON t5.art_id = A_PER.art_id AND t5.mandant_id = A_PER.mandant_id
       AND (A_PER.dat_bis BETWEEN A0.dat_von AND A0.dat_bis OR A_PER.dat_bis = DATE '9999-12-31')
   LEFT JOIN kfl_production_dbp_view.v_wbs_art_aktion_per_2 AS WBS_AA_PER ON t5.mandant_id = WBS_AA_PER.mandant_id AND t5
        .aktion_id = WBS_AA_PER.aktion_id AND A0.dat_von = WBS_AA_PER.dat_von AND t5.art_id = WBS_AA_PER.art_id AND t5.wup_id
      = WBS_AA_PER.wup_id
   LEFT JOIN (SELECT A2.mandant_id,
     A2.angebot_nr,
     AW.art_id,
     AW.wup_id,
     A2.aktion_id,
     AW.opv_prospekt_fg,
     AW.opv_markt_fg,
     A2.bonuskauf_fg,
     A2.geschaeftsvorfall_id AS bonuskauf_geschaeftsvorfall_id,
     A2.aktion_typ_id AS bonuskauf_anreiztyp,
     0 AS preis_niedrigster,
     0 AS preis_niedrigster_diff_perc
    FROM kfl_production_dbp_view.v_angebot_2 AS A2
     INNER JOIN kfl_production_dbp_view.v_angebot_art_wup_zu_2 AS AW ON A2.mandant_id = AW.mandant_id AND A2.angebot_nr =
       AW.angebot_nr
    WHERE A2.angebot_geloescht_fg = 0) AS a_pmr ON t5.mandant_id = a_pmr.mandant_id AND t5.aktion_id = a_pmr.aktion_id
     AND t5.wup_id = a_pmr.wup_id AND t5.art_id = a_pmr.art_id
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
    FROM kfl_production_dbp_view.v_angebot_attribut_zu_2
    WHERE angebot_attribut_id BETWEEN 40 AND 53
    GROUP BY mandant_id,
     angebot_nr) AS aa ON a_pmr.mandant_id = aa.mandant_id AND a_pmr.angebot_nr = aa.angebot_nr
   LEFT JOIN (SELECT mandant_id,
     ROUND(SAFE_CAST(angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
     MAX(COALESCE(CASE
        WHEN CAST(werbemittelkanal_id AS STRING) = '0900' AND werbemittel_id IN (11, 21, 31) OR werbemittelkanal_id IN (992
            , 993) AND werbemittel_id IN (10, 20, 30)
        THEN 1
        ELSE 0
        END, -1)) AS nur_online_fg,
     MAX(COALESCE(CASE
        WHEN CAST(werbemittelkanal_id AS STRING) = '0999' AND werbemittel_id = 90
        THEN 1
        ELSE 0
        END, -1)) AS kundenkarte_personalisiert_fg,
     MAX(COALESCE(CASE
        WHEN CAST(werbemittelkanal_id AS STRING) = '0920' AND werbemittel_id = 40
        THEN 1
        ELSE 0
        END, -1)) AS stille_aktion_fg,
     MAX(COALESCE(CASE
        WHEN CAST(werbemittelkanal_id AS STRING) = '0920' AND werbemittel_id = 50
        THEN 1
        ELSE 0
        END, -1)) AS stille_aktion_mit_menge_fg,
     MAX(COALESCE(CASE
        WHEN CAST(werbemittelkanal_id AS STRING) = '0200' AND werbemittel_id IN (20)
        THEN 1
        ELSE 0
        END, -1)) AS tv_fg,
     MAX(COALESCE(CASE
        WHEN CAST(werbemittelkanal_id AS STRING) = '0900' AND werbemittel_id IN (10)
        THEN 1
        ELSE 0
        END, -1)) AS titelseite_fg,
     MAX(COALESCE(CASE
        WHEN CAST(werbemittelkanal_id AS STRING) = '0900' AND werbemittel_id IN (20)
        THEN 1
        ELSE 0
        END, -1)) AS rueckseite_fg
    FROM kfl_production_dbp_view.v_angebot_werbemittel_promotion_event_zu_2 AS W
    GROUP BY mandant_id,
     angebot_id) AS pmr_a_werf_agg ON a_pmr.mandant_id = pmr_a_werf_agg.mandant_id AND ROUND(SAFE_CAST(a_pmr.angebot_nr
       AS BIGNUMERIC), 0) = pmr_a_werf_agg.angebot_id
  WHERE T.akt_kj BETWEEN -2 AND 0
   AND A0.dat_von <= CURRENT_DATE);