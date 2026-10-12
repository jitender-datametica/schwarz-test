CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_art_wup_zu_1 AS SELECT AKT0.mandant_id,
 AKT0.aktion_id,
 AKT0.aktionsart_id,
 AKT0.kjwo_von,
 AKT0.dat_von,
 AKT0.dat_bis,
 AKT_ART.wup_id,
 AKT_ART.nb_id,
 AKT_ART.art_id,
 AKT_ART.wrg_id,
 AKT_ART.vk_aktion_brutto,
 ART_WUP.vk_brutto,
 art_kolli.menge_einh_id,
 art_kolli.umrech_faktor,
 RANK() OVER (PARTITION BY CAST(AKT_ART.mandant_id AS STRING), CAST(AKT_ART.wup_id AS STRING), CAST(AKT_ART.art_id AS STRING)
    ORDER BY AKT_ART.mandant_id IS NULL, AKT_ART.mandant_id, AKT_ART.wup_id IS NULL, AKT_ART.wup_id, AKT_ART.art_id
    IS NULL, AKT_ART.art_id, AKT0.kjwo_von IS NULL, AKT0.kjwo_von) AS rang_kw,
 ART_WUP.bezugsweg_id,
 AKT0.werbe_kat_id,
 WERBE_KAT.werbe_kat_bez,
 AKT_ART.aktion_thema_id,
 AKT_THEMA.aktion_thema_bez,
 AKT0.preisaktiviert_fg
FROM kfl_production_dbp_view.v_aktion_1 AS AKT0
 INNER JOIN kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS AKT_ART ON AKT0.aktion_id = AKT_ART.aktion_id AND AKT0.mandant_id
    = AKT_ART.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wup_zu_per_1 AS ART_WUP ON AKT_ART.art_id = ART_WUP.art_id AND AKT_ART.mandant_id
      = ART_WUP.mandant_id AND AKT_ART.wup_id = ART_WUP.wup_id AND AKT0.dat_von BETWEEN ART_WUP.dat_von AND ART_WUP.dat_bis
   
 INNER JOIN kfl_production_dbp_view.v_aktion_thema_spr_zu_1 AS AKT_THEMA ON AKT_ART.aktion_thema_id = AKT_THEMA.aktion_thema_id
     AND AKT_ART.mandant_id = AKT_THEMA.mandant_id AND AKT_THEMA.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_werbekat_spr_zu_1 AS WERBE_KAT ON AKT0.werbe_kat_id = WERBE_KAT.werbe_kat_id AND
    AKT0.mandant_id = WERBE_KAT.mandant_id AND WERBE_KAT.spr_id = 22
 INNER JOIN (SELECT art_bzw.art_id,
   art_bzw.mandant_id,
   art_bzw.menge_einh_id,
   art_bzw.bezugsweg_id,
   COALESCE(art_um.umrech_faktor, 1) AS umrech_faktor
  FROM (SELECT art_id,
      mandant_id,
      best_menge_einh_id AS menge_einh_id,
      1 AS bezugsweg_id
     FROM kfl_production_dbp_view.v_art_1
     WHERE dat_bis = DATE '9999-12-31'
     UNION ALL
     SELECT art_id,
      mandant_id,
      ausg_menge_einh_id AS menge_einh_id,
      4 AS bezugsweg_id
     FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1
     WHERE dat_bis = DATE '9999-12-31') AS art_bzw
   LEFT JOIN (SELECT art_id,
     mandant_id,
     altnv_menge_einh_id AS menge_einh_id,
     umrech_faktor
    FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
    WHERE dat_bis = DATE '9999-12-31') AS art_um ON art_bzw.art_id = art_um.art_id AND art_bzw.mandant_id = art_um.mandant_id
       AND art_bzw.menge_einh_id = art_um.menge_einh_id) AS art_kolli ON ART_WUP.art_id = art_kolli.art_id AND ART_WUP.mandant_id
     = art_kolli.mandant_id AND ART_WUP.bezugsweg_id = art_kolli.bezugsweg_id
WHERE AKT_ART.grund_sperrung IS NULL
 AND AKT0.dat_von BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY));