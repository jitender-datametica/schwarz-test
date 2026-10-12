CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_pmr_angebot_aktion_art_wup_zu_2 AS WITH ALL_AKTION AS (SELECT
    mandant_id,
    art_id,
    aktion_id,
    'NOT PMR' AS fg,
    wup_id,
    nb_id,
    vk_aktion_brutto,
    vk_vor_aktion_brutto,
    wrg_id
   FROM kfl_production_dbp_view.v_aktion_art_wup_zu_2 AS A_ART_W
   WHERE grund_sperrung IS NULL
    AND COALESCE(geloescht_sap_fg, 0) <> 1
    AND NOT EXISTS (SELECT 1
     FROM kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_2 AS A_ART_W_PMR
     WHERE A_ART_W.mandant_id = mandant_id
      AND A_ART_W.art_id = art_id
      AND A_ART_W.aktion_id = aktion_id
      AND A_ART_W.wup_id = wup_id)
   UNION ALL
   SELECT mandant_id,
    art_id,
    aktion_id,
    'PMR' AS fg,
    wup_id,
    nb_id,
    preis_aktion,
    preis_normal,
    wrg_id
   FROM kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_2 AS A_ART_W_PMR), AB AS (SELECT t12.aktion_id,
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
   INNER JOIN kfl_production_dbp_view.v_aktion_2 AS A0 ON t12.mandant_id = A0.mandant_id AND t12.aktion_id = A0.aktion_id
   INNER JOIN kfl_production_dbp_view.v_artbew_2 AS AB ON t12.mandant_id = AB.mandant_id AND t12.wup_id = AB.wup_id AND
      t12.art_id = AB.art_id AND AB.dat BETWEEN A0.dat_von AND A0.dat_bis
   INNER JOIN kfl_production_dbp_data.tag_2 AS T0 ON A0.dat_von = T0.dat
  WHERE T0.akt_kj BETWEEN - 2 AND 0
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
    THEN COUNT(t5.art_id) OVER (PARTITION BY CAST(t5.mandant_id AS STRING), CAST(t5.wup_id AS STRING), A.dat_von, A.dat_bis
       , CAST(A_PER.mutter_wb_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    ELSE NULL
    END AS anz_art_in_gruppe,
   t5.art_id,
   t5.aktion_id,
   V05.aktuell_wup_id AS wup_id,
   t5.nb_id,
   A.dat_von,
   A.dat_bis,
   T.kjwo AS kjwo_von,
    DATE_DIFF(A.dat_bis, A.dat_von, DAY) + 1 AS aktion_dauer,
   t5.fg,
   AB_AGG.menge,
   AB_AGG.absatz_af_n_loyalty_schm_bby,
   AB_AGG.absatz_af_loyalty_schm_bby,
   AB_AGG.absatz_af_n_loyalty_bby,
   AB_AGG.absatz_af_loyalty_bby,
   AB_AGG.absatz_sa_n_loyalty,
   AB_AGG.absatz_sa_loyalty,
   AB_AGG.absatz_sa_n_loyalty_bby,
   AB_AGG.absatz_sa_loyalty_bby,
   AB_AGG.absatz_sa_loyalty_kk_bby,
   AB_AGG.absatz_sa_loyalty_kk_c_bby,
   AB_AGG.sales_fg,
   WBS_AA_PER.zeitraum_korrigierte_menge,
   t5.vk_aktion_brutto,
   t5.vk_vor_aktion_brutto,
   t5.wrg_id,
   COALESCE(PMR_A.angebot_id, -1) AS angebot_id,
   COALESCE(LPAD(CAST(PMR_A.bonuskauf_geschaeftsvorfall_id AS STRING), 2, '0'), '-1') AS bonuskauf_geschaeftsvorfall_id
   ,
   COALESCE(PMR_A.bonuskauf_anreiztyp, 'N/A') AS bonuskauf_anreiztyp,
   PMR_A.preis_niedrigster,
   PMR_A.preis_niedrigster_diff_perc,
   PMR_A.opv_prospekt_fg,
   PMR_A.opv_markt_fg,
   PMR_A.stimmung_fg,
   PMR_A.preishammer_fg,
   PMR_A.gondelkopf_fg,
   PMR_A.ek_art_id_ref,
   COALESCE(WBS_AA_PER.gk_fg, - 1) AS gk_fg,
   COALESCE(PMR_A.bonuskauf_fg, CASE
     WHEN COALESCE(CAST(LB.aktion_id AS BIGNUMERIC), 0) = 0
     THEN 0
     ELSE 1
     END) AS bonuskauf_fg,
    CASE
    WHEN COALESCE(COUNT(PMR_A.angebot_id) OVER (PARTITION BY CAST(t5.mandant_id AS STRING), CAST(t5.wup_id AS STRING), CAST(t5.art_id AS STRING)
         , A.dat_von, A.dat_bis RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) > 1
    THEN 1
    ELSE 0
    END AS multi_offer_id_fg,
   PMR_A_WERF_AGG.nur_online_fg,
   PMR_A_WERF_AGG.kundenkarte_personalisiert_fg,
   PMR_A_WERF_AGG.stille_aktion_fg,
   PMR_A_WERF_AGG.stille_aktion_mit_menge_fg,
   PMR_A_WERF_AGG.tv_fg,
   PMR_A_WERF_AGG.titelseite_fg,
   PMR_A_WERF_AGG.rueckseite_fg
  FROM ALL_AKTION AS t5
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON t5.mandant_id = V05.mandant_id AND t5.wup_id = V05.wup_id AND (V05
        .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
   INNER JOIN kfl_production_dbp_view.v_aktion_2 AS A ON t5.mandant_id = A.mandant_id AND t5.aktion_id = A.aktion_id
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON A.dat_von = T.dat
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
     mandant_id) AS AB_AGG ON t5.mandant_id = AB_AGG.mandant_id AND t5.wup_id = AB_AGG.wup_id AND t5.art_id = AB_AGG.art_id
       AND t5.aktion_id = AB_AGG.aktion_id
   LEFT JOIN (SELECT DISTINCT aktion_id,
     mandant_id
    FROM kfl_production_dbp_view.v_l_bonuskauf_2) AS LB ON t5.mandant_id = LB.mandant_id AND t5.aktion_id = LB.aktion_id
   LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS A_PER ON t5.art_id = A_PER.art_id AND t5.mandant_id = A_PER.mandant_id
       AND (A_PER.dat_bis BETWEEN A.dat_von AND A.dat_bis OR A_PER.dat_bis = DATE '9999-12-31')
   LEFT JOIN kfl_production_dbp_view.v_wbs_art_aktion_per_2 AS WBS_AA_PER ON t5.mandant_id = WBS_AA_PER.mandant_id AND t5
        .aktion_id = WBS_AA_PER.aktion_id AND A.dat_von = WBS_AA_PER.dat_von AND t5.art_id = WBS_AA_PER.art_id AND t5.wup_id
      = WBS_AA_PER.wup_id
   LEFT JOIN kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_2 AS PMR_A ON t5.mandant_id = PMR_A.mandant_id AND t5.aktion_id
        = PMR_A.aktion_id AND t5.wup_id = PMR_A.wup_id AND t5.art_id = PMR_A.art_id
   LEFT JOIN (SELECT mandant_id,
     angebot_id,
     MAX(COALESCE(CASE
        WHEN werbemittel_art_id = '0900' AND werbemittel_id IN (11, 21, 31) OR werbemittel_art_id IN ('0992', '0993')
          AND werbemittel_id IN (10, 20, 30)
        THEN 1
        ELSE 0
        END, - 1)) AS nur_online_fg,
     MAX(COALESCE(CASE
        WHEN werbemittel_art_id = '0999' AND werbemittel_id = 90
        THEN 1
        ELSE 0
        END, - 1)) AS kundenkarte_personalisiert_fg,
     MAX(COALESCE(CASE
        WHEN werbemittel_art_id = '0920' AND werbemittel_id = 40
        THEN 1
        ELSE 0
        END, - 1)) AS stille_aktion_fg,
     MAX(COALESCE(CASE
        WHEN werbemittel_art_id = '0920' AND werbemittel_id = 50
        THEN 1
        ELSE 0
        END, - 1)) AS stille_aktion_mit_menge_fg,
     MAX(COALESCE(CASE
        WHEN werbemittel_art_id = '0200' AND werbemittel_id IN (20)
        THEN 1
        ELSE 0
        END, - 1)) AS tv_fg,
     MAX(COALESCE(CASE
        WHEN werbemittel_art_id = '0900' AND werbemittel_id IN (10)
        THEN 1
        ELSE 0
        END, - 1)) AS titelseite_fg,
     MAX(COALESCE(CASE
        WHEN werbemittel_art_id = '0900' AND werbemittel_id IN (20)
        THEN 1
        ELSE 0
        END, - 1)) AS rueckseite_fg
    FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_2 AS PMR_A_WERF
    GROUP BY mandant_id,
     angebot_id) AS PMR_A_WERF_AGG ON PMR_A.mandant_id = PMR_A_WERF_AGG.mandant_id AND PMR_A.angebot_id = PMR_A_WERF_AGG
     .angebot_id
  WHERE T.akt_kj BETWEEN - 2 AND 0
   AND A.dat_von <= CURRENT_DATE);