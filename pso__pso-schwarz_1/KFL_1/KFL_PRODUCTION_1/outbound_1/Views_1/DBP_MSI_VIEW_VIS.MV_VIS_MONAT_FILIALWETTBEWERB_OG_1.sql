CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_filialwettbewerb_og_1 AS WITH ZEIT_1 AS (SELECT gj,
   akt_gj,
    akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) AS akt_gj_mo,
   kjmo,
   kjmo_vj,
   akt_mo,
   min_dat,
   max_dat
  FROM kfl_production_dbp_data.monat_1 AS ZEIT_1
  WHERE akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) = 0
   AND akt_mo < 0), WUP_1 AS (SELECT mandant_id,
   nb_id,
   vs_id,
   aktuell_wup_id,
   wup_id,
   COALESCE(dat_eroeffnung_alt, dat_eroeffnung) AS neo_dat,
   IF(wup_aenderung_grund_id = 3, '9999-12-31', NULL) AS dat_umgl,
   COALESCE(IF(wup_aenderung_grund_id = 3, '9999-12-31', NULL), SUBSTR(CAST(dat_bis AS STRING), 1, 20)) AS stl_dat,
    EXTRACT(YEAR FROM COALESCE(dat_eroeffnung_alt, dat_eroeffnung)) - IF(EXTRACT(MONTH FROM COALESCE(dat_eroeffnung_alt
        , dat_eroeffnung)) < 3, 1, 0) AS neo_gj,
    EXTRACT(YEAR FROM CAST(COALESCE(IF(wup_aenderung_grund_id = 3, '9999-12-31', NULL), SUBSTR(CAST(dat_bis AS STRING),
        1, 20)) AS DATETIME)) - IF(EXTRACT(MONTH FROM CAST(COALESCE(IF(wup_aenderung_grund_id = 3, '9999-12-31', NULL), SUBSTR(CAST(dat_bis AS STRING)
          , 1, 20)) AS DATETIME)) < 3, 1, 0) AS stl_gj,
    CASE
    WHEN mandant_id = 1 AND wup_id IN (1263, 1273, 3166, 6623, 8120, 8563, 8940, 5876) OR mandant_id = 3 AND wup_id IN (1010
         ) OR mandant_id = 7 AND wup_id IN (1110, 1410, 6210, 6310, 6410)
    THEN 1
    WHEN mandant_id = 2 AND wup_id IN (1700, 6800)
    THEN 2
    ELSE 0
    END AS aus_fg
  FROM kfl_production_dbp_data.wup_1 AS WUP_1
  WHERE nb_id = 0
   AND dat_eroeffnung < DATE '2090-12-31') (SELECT vis.mandant_id,
   vis.nb_id,
   vis.vs_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.kjmo,
   vis.offen_ist AS ogm_offen,
   vishwg.ums_netto_ist AS ogm_ums_netto_ist,
   vishwg.ums_netto_vj AS ogm_ums_netto_kvj,
    vishwg.ums_netto_ist / IF(vishwg.ums_netto_vj = 0, NULL, vishwg.ums_netto_vj) AS ogm_ums_netto,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY vishwg.ums_netto_ist / IF(vishwg.ums_netto_vj
          = 0, NULL, vishwg.ums_netto_vj) NULLS LAST) AS ogm_ums_netto_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY vishwg.ums_netto_ist / IF(vishwg
         .ums_netto_vj = 0, NULL, vishwg.ums_netto_vj) NULLS LAST) AS ogm_ums_netto_dense,
   vis.ums_netto_fil_ist AS ogm_ums_netto_fil_ist,
   vis.ums_netto_fil_kvj AS ogm_ums_netto_fil_kvj,
    vishwg.ums_netto_ist / IF(vis.ums_netto_fil_ist = 0, NULL, vis.ums_netto_fil_ist) AS ogm_umsatzanteil_netto_ist,
    vishwg.ums_netto_vj / IF(vis.ums_netto_fil_kvj = 0, NULL, vis.ums_netto_fil_kvj) AS ogm_umsatzanteil_netto_kvj,
     vishwg.ums_netto_ist / IF(vis.ums_netto_fil_ist = 0, NULL, vis.ums_netto_fil_ist) - IF(vishwg.ums_netto_vj / IF(vis
         .ums_netto_fil_kvj = 0, NULL, vis.ums_netto_fil_kvj) = 0, NULL, vishwg.ums_netto_vj / IF(vis.ums_netto_fil_kvj
        = 0, NULL, vis.ums_netto_fil_kvj)) AS ogm_umsatzanteil_netto,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY vishwg.ums_netto_ist / IF(vis.ums_netto_fil_ist
           = 0, NULL, vis.ums_netto_fil_ist) - IF(vishwg.ums_netto_vj / IF(vis.ums_netto_fil_kvj = 0, NULL, vis.ums_netto_fil_kvj
           ) = 0, NULL, vishwg.ums_netto_vj / IF(vis.ums_netto_fil_kvj = 0, NULL, vis.ums_netto_fil_kvj)) NULLS LAST) AS
   ogm_umsatzanteil_netto_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY vishwg.ums_netto_ist / IF(vis
          .ums_netto_fil_ist = 0, NULL, vis.ums_netto_fil_ist) - IF(vishwg.ums_netto_vj / IF(vis.ums_netto_fil_kvj = 0,
           NULL, vis.ums_netto_fil_kvj) = 0, NULL, vishwg.ums_netto_vj / IF(vis.ums_netto_fil_kvj = 0, NULL, vis.ums_netto_fil_kvj
          )) NULLS LAST) AS ogm_umsatzanteil_netto_dense,
   visabs.abs_op_ist AS ogm_abs_op_ist,
   planowg.abs_owg_plan AS ogm_abs_owg_plan,
   planowg.ums_owg_plan AS ogm_ums_owg_plan,
    visabs.abs_op_ist / IF(vishwg.ums_netto_ist = 0, NULL, vishwg.ums_netto_ist) AS ogm_abschrift_op_ist,
    planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan) AS ogm_abschrift_op_plan,
     visabs.abs_op_ist / IF(vishwg.ums_netto_ist = 0, NULL, vishwg.ums_netto_ist) - IF(planowg.abs_owg_plan / IF(planowg
         .ums_owg_plan = 0, NULL, planowg.ums_owg_plan) = 0, NULL, planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0,
       NULL, planowg.ums_owg_plan)) AS ogm_abschrift_op,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY visabs.abs_op_ist / IF(vishwg.ums_netto_ist
           = 0, NULL, vishwg.ums_netto_ist) - IF(planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan
           ) = 0, NULL, planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan)) NULLS LAST) AS
   ogm_abschrift_op_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY visabs.abs_op_ist / IF(vishwg
          .ums_netto_ist = 0, NULL, vishwg.ums_netto_ist) - IF(planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL
           , planowg.ums_owg_plan) = 0, NULL, planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan
          )) NULLS LAST) AS ogm_abschrift_op_dense,
   visabs.preisabs_ist AS ogm_preisabs_ist,
    visabs.preisabs_ist / IF(visabs.abs_op_ist = 0, NULL, visabs.abs_op_ist) AS ogm_preisabs,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY visabs.preisabs_ist / IF(visabs.abs_op_ist
          = 0, NULL, visabs.abs_op_ist) NULLS LAST) AS ogm_preisabs_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY visabs.preisabs_ist / IF(visabs
         .abs_op_ist = 0, NULL, visabs.abs_op_ist) NULLS LAST) AS ogm_preisabs_dense,
   kunde_hwg.anzahl_kunden_ist AS ogm_anzahl_kunden_ist,
   kunde_hwg.anzahl_kunden_kvj AS ogm_anzahl_kunden_kvj,
    kunde_hwg.anzahl_kunden_ist / IF(kunde_hwg.anzahl_kunden_kvj = 0, NULL, kunde_hwg.anzahl_kunden_kvj) AS
   ogm_anzahl_kunden,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY kunde_hwg.anzahl_kunden_ist / IF(kunde_hwg
         .anzahl_kunden_kvj = 0, NULL, kunde_hwg.anzahl_kunden_kvj) NULLS LAST) AS ogm_anzahl_kunden_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY kunde_hwg.anzahl_kunden_ist
       / IF(kunde_hwg.anzahl_kunden_kvj = 0, NULL, kunde_hwg.anzahl_kunden_kvj) NULLS LAST) AS ogm_anzahl_kunden_dense,
   vis.anz_kunden_fil_ist AS ogm_anzahl_kunden_fil_ist,
   vis.anz_kunden_fil_kvj AS ogm_anzahl_kunden_fil_kvj,
    kunde_hwg.anzahl_kunden_ist / IF(vis.anz_kunden_fil_ist = 0, NULL, vis.anz_kunden_fil_ist) AS ogm_kundenanteil_ist,
    kunde_hwg.anzahl_kunden_kvj / IF(vis.anz_kunden_fil_kvj = 0, NULL, vis.anz_kunden_fil_kvj) AS ogm_kundenanteil_kvj,
     kunde_hwg.anzahl_kunden_ist / IF(vis.anz_kunden_fil_ist = 0, NULL, vis.anz_kunden_fil_ist) - IF(kunde_hwg.anzahl_kunden_kvj
        / IF(vis.anz_kunden_fil_kvj = 0, NULL, vis.anz_kunden_fil_kvj) = 0, NULL, kunde_hwg.anzahl_kunden_kvj / IF(vis.anz_kunden_fil_kvj
         = 0, NULL, vis.anz_kunden_fil_kvj)) AS ogm_kundenanteil,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY kunde_hwg.anzahl_kunden_ist / IF(vis
          .anz_kunden_fil_ist = 0, NULL, vis.anz_kunden_fil_ist) - IF(kunde_hwg.anzahl_kunden_kvj / IF(vis.anz_kunden_fil_kvj
             = 0, NULL, vis.anz_kunden_fil_kvj) = 0, NULL, kunde_hwg.anzahl_kunden_kvj / IF(vis.anz_kunden_fil_kvj = 0,
          NULL, vis.anz_kunden_fil_kvj)) NULLS LAST) AS ogm_kundenantiel_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY kunde_hwg.anzahl_kunden_ist
        / IF(vis.anz_kunden_fil_ist = 0, NULL, vis.anz_kunden_fil_ist) - IF(kunde_hwg.anzahl_kunden_kvj / IF(vis.anz_kunden_fil_kvj
             = 0, NULL, vis.anz_kunden_fil_kvj) = 0, NULL, kunde_hwg.anzahl_kunden_kvj / IF(vis.anz_kunden_fil_kvj = 0,
          NULL, vis.anz_kunden_fil_kvj)) NULLS LAST) AS ogm_kundenanteil_dense,
   inv.inventur_wert_netto AS ogm_inventur_wert_netto,
   inv.inventur_ums_netto AS ogm_inventur_ums_netto,
    inv.inventur_wert_netto / IF(inv.inventur_ums_netto = 0, NULL, inv.inventur_ums_netto) AS ogm_inventur,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY inv.inventur_wert_netto / IF(inv.inventur_ums_netto
          = 0, NULL, inv.inventur_ums_netto) NULLS LAST) AS ogm_inventur_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY inv.inventur_wert_netto / IF(inv
         .inventur_ums_netto = 0, NULL, inv.inventur_ums_netto) NULLS LAST) AS ogm_inventur_dense,
    vishwg.ums_netto_ist / IF(kunde_hwg.anzahl_kunden_ist = 0, NULL, kunde_hwg.anzahl_kunden_ist) AS ogm_avg_bon_ist,
    vishwg.ums_netto_vj / IF(kunde_hwg.anzahl_kunden_kvj = 0, NULL, kunde_hwg.anzahl_kunden_kvj) AS ogm_avg_bon_kvj,
     vishwg.ums_netto_ist / IF(kunde_hwg.anzahl_kunden_ist = 0, NULL, kunde_hwg.anzahl_kunden_ist) / IF(vishwg.ums_netto_vj
        / IF(kunde_hwg.anzahl_kunden_kvj = 0, NULL, kunde_hwg.anzahl_kunden_kvj) = 0, NULL, vishwg.ums_netto_vj / IF(kunde_hwg
        .anzahl_kunden_kvj = 0, NULL, kunde_hwg.anzahl_kunden_kvj)) AS ogm_avg_bon,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY vishwg.ums_netto_ist / IF(kunde_hwg
          .anzahl_kunden_ist = 0, NULL, kunde_hwg.anzahl_kunden_ist) / IF(vishwg.ums_netto_vj / IF(kunde_hwg.anzahl_kunden_kvj
             = 0, NULL, kunde_hwg.anzahl_kunden_kvj) = 0, NULL, vishwg.ums_netto_vj / IF(kunde_hwg.anzahl_kunden_kvj = 0
           , NULL, kunde_hwg.anzahl_kunden_kvj)) NULLS LAST) AS ogm_avg_bon_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY vishwg.ums_netto_ist / IF(kunde_hwg
          .anzahl_kunden_ist = 0, NULL, kunde_hwg.anzahl_kunden_ist) / IF(vishwg.ums_netto_vj / IF(kunde_hwg.anzahl_kunden_kvj
             = 0, NULL, kunde_hwg.anzahl_kunden_kvj) = 0, NULL, vishwg.ums_netto_vj / IF(kunde_hwg.anzahl_kunden_kvj = 0
           , NULL, kunde_hwg.anzahl_kunden_kvj)) NULLS LAST) AS ogm_avg_bon_dense,
   ueq.best_vor AS ogm_ueq_best_vor,
   ueq.best_man AS ogm_ueq_best_man,
   ueq.best_kor AS ogm_ueq_best_kor,
     (ueq.best_vor - ueq.best_kor) / (ueq.best_vor + ueq.best_man) AS ogm_ueq,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY (ueq.best_vor - ueq.best_kor) / (ueq
         .best_vor + ueq.best_man) NULLS LAST) AS ogm_ueq_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY (ueq.best_vor - ueq.best_kor
         ) / (ueq.best_vor + ueq.best_man) NULLS LAST) AS ogm_ueq_dense,
   kmr.kmr_ergebnis_nok AS ogm_kmr_kc_og_ergebnis_nok,
   kmr.kmr_ergebnis_anz AS ogm_kmr_kc_og_ergebnis_anz,
   kmr.kmr_pruefung_anz AS ogm_kmr_kc_og_pruefung_anz,
    kmr.kmr_ergebnis_nok / IF(kmr.kmr_ergebnis_anz = 0, NULL, kmr.kmr_ergebnis_anz) AS ogm_kmr_kc_og_nok,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY kmr.kmr_ergebnis_nok / IF(kmr.kmr_ergebnis_anz
          = 0, NULL, kmr.kmr_ergebnis_anz) NULLS LAST) AS ogm_kmr_kc_og_nok_rank,
   DENSE_RANK() OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY kmr.kmr_ergebnis_nok / IF(kmr
         .kmr_ergebnis_anz = 0, NULL, kmr.kmr_ergebnis_anz) NULLS LAST) AS ogm_kmr_kc_og_nok_dense,
   NULL AS ogm_kc_sauberkeit_fest,
   NULL AS ogm_kc_sauberkeit_ges,
   NULL AS ogm_kc_sauberkeit_nok,
   NULL AS ogm_kc_sauberkeit_nok_rank,
   NULL AS ogm_kc_sauberkeit_nok_dense,
   NULL AS ogm_kc_warenfrische_og_fest,
   NULL AS ogm_kc_warenfrische_og_ges,
   NULL AS ogm_kc_warenfrische_og_nok,
   NULL AS ogm_kc_warenfrische_og_nok_rank,
   NULL AS ogm_kc_warenfrische_og_nok_dense,
   NULL AS ogm_kc_warenfrische_pfl_fest,
   NULL AS ogm_kc_warenfrische_pfl_ges,
   NULL AS ogm_kc_warenfrische_pfl_nok,
   NULL AS ogm_kc_warenfrische_pfl_nok_rank,
   NULL AS ogm_kc_warenfrische_pfl_nok_dense,
   NULL AS ogm_kc_warenverfuegbarkeit_fest,
   NULL AS ogm_kc_warenverfuegbarkeit_ges,
   NULL AS ogm_kc_warenverfuegbarkeit_nok,
   NULL AS ogm_kc_warenverfuegbarkeit_nok_rank,
   NULL AS ogm_kc_warenverfuegbarkeit_nok_dense
  FROM (SELECT VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     VIS0.wrg_id,
     t4.aktuell_wup_id AS wup_id,
     VIS0.gj,
     VIS0.kjmo,
     SUM(VIS0.anz_offen) AS offen_ist,
     SUM(VIS0.ums_netto) AS ums_netto_fil_ist,
     SUM(VIS0.ums_netto_kvj) AS ums_netto_fil_kvj,
     SUM(VIS0.anz_kunde) AS anz_kunden_fil_ist,
     SUM(VIS0.anz_kunde_kvj) AS anz_kunden_fil_kvj
    FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS0
     INNER JOIN ZEIT_1 AS t1_1 ON VIS0.kjmo = t1.kjmo
     INNER JOIN WUP_1 AS t4 ON VIS0.wup_id = t4.wup_id AND VIS0.mandant_id = t4.mandant_id
    WHERE t4.neo_gj < t1.gj - 1
     AND CAST(t4.stl_dat AS DATE) > t1.max_dat
     AND t4.aus_fg <> 1
     AND (t4.aus_fg <> 2 OR NOT t1.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     VIS0.wrg_id,
     wup_id,
     VIS0.gj,
     VIS0.kjmo) AS vis
   LEFT JOIN (SELECT VIS00.mandant_id,
     VIS00.wrg_id,
     t14.aktuell_wup_id AS wup_id,
     VIS00.kjmo,
     SUM(VIS00.ums_netto) AS ums_netto_ist,
     SUM(VIS00.ums_netto_kvj) AS ums_netto_vj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg_1 AS VIS00
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS00.wg_id = WG.wg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
     INNER JOIN ZEIT_1 AS t11 ON VIS00.kjmo = t11.kjmo
     INNER JOIN WUP_1 AS t14 ON VIS00.wup_id = t14.wup_id AND VIS00.mandant_id = t14.mandant_id
    WHERE t14.neo_gj < t11.gj - 1
     AND CAST(t14.stl_dat AS DATE) > t11.max_dat
     AND t14.aus_fg <> 1
     AND (t14.aus_fg <> 2 OR NOT t11.kjmo BETWEEN 202409 AND 202602)
     AND OWG.hwg_id = 64
    GROUP BY VIS00.mandant_id,
     VIS00.wrg_id,
     wup_id,
     VIS00.kjmo) AS vishwg ON vis.wup_id = vishwg.wup_id AND vis.mandant_id = vishwg.mandant_id AND vis.wrg_id = vishwg
      .wrg_id AND vis.kjmo = vishwg.kjmo
   LEFT JOIN (SELECT VIS01.mandant_id,
     VIS01.wrg_id,
     t24.aktuell_wup_id AS wup_id,
     VIS01.kjmo,
     SUM(CASE
        WHEN VIS01.mandant_id IN (6) AND VIS01.abschriftart_id = 2 OR VIS01.mandant_id IN (3) AND VIS01.abschriftart_id
              = 11 OR VIS01.mandant_id IN (2, 4, 5, 7, 8) AND VIS01.abschriftart_id = 7 OR VIS01.mandant_id IN (2, 5)
           AND VIS01.abschriftart_id = 10 OR VIS01.abschriftart_id = 20 AND VIS01.mandant_id NOT IN (1)
        THEN 1
        ELSE -1
        END * VIS01.abschrift_netto) AS abs_op_ist,
     SUM(CASE
        WHEN VIS01.mandant_id IN (6) AND ABS_THEMA.abschriftart_thema_int_id = 4 AND VIS01.abschriftart_id = 2 OR VIS01
               .mandant_id IN (3) AND ABS_THEMA.abschriftart_thema_int_id = 4 AND VIS01.abschriftart_id = 11 OR VIS01.mandant_id
               IN (2, 4, 5, 7, 8) AND ABS_THEMA.abschriftart_thema_int_id = 4 AND VIS01.abschriftart_id = 7 OR VIS01.mandant_id
              IN (2, 5) AND ABS_THEMA.abschriftart_thema_int_id = 4 AND VIS01.abschriftart_id = 10 OR ABS_THEMA.abschriftart_thema_int_id
             = 4 AND VIS01.abschriftart_id = 20 AND VIS01.mandant_id NOT IN (1)
        THEN 1
        WHEN ABS_THEMA.abschriftart_thema_int_id = 4
        THEN -1
        ELSE 0
        END * VIS01.abschrift_netto) AS preisabs_ist
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_abschriften_wg_1 AS VIS01
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_1 AS ABS_ART ON VIS01.abschriftart_id = ABS_ART.abschriftart_id
        AND VIS01.mandant_id = ABS_ART.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_1 AS ABS_THEMA ON ABS_ART.abschriftart_int_id
       = ABS_THEMA.abschriftart_int_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG0 ON VIS01.wg_id = WG0.wg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG0 ON WG0.owg_id = OWG0.owg_id
     INNER JOIN ZEIT_1 AS t21 ON VIS01.kjmo = t21.kjmo
     INNER JOIN WUP_1 AS t24 ON VIS01.wup_id = t24.wup_id AND VIS01.mandant_id = t24.mandant_id
    WHERE t24.neo_gj < t21.gj - 1
     AND CAST(t24.stl_dat AS DATE) > t21.max_dat
     AND t24.aus_fg <> 1
     AND (t24.aus_fg <> 2 OR NOT t21.kjmo BETWEEN 202409 AND 202602)
     AND ABS_THEMA.abschriftart_thema_int_id IN (1, 4)
     AND OWG0.hwg_id = 64
    GROUP BY VIS01.mandant_id,
     VIS01.wrg_id,
     wup_id,
     VIS01.kjmo) AS visabs ON vis.wup_id = visabs.wup_id AND vis.mandant_id = visabs.mandant_id AND vis.wrg_id = visabs
      .wrg_id AND vis.kjmo = visabs.kjmo
   LEFT JOIN (SELECT VIS02.mandant_id,
     VIS02.wrg_id,
     t34.aktuell_wup_id AS wup_id,
     VIS02.kjmo,
     SUM(VIS02.abschriften_netto_operativ_plan) AS abs_owg_plan,
     SUM(VIS02.umsatz_netto_plan) AS ums_owg_plan
    FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS VIS02
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG1 ON VIS02.owg_id = OWG1.owg_id
     INNER JOIN ZEIT_1 AS t31 ON VIS02.kjmo = t31.kjmo
     INNER JOIN WUP_1 AS t34 ON VIS02.wup_id = t34.wup_id AND VIS02.mandant_id = t34.mandant_id
    WHERE t34.neo_gj < t31.gj - 1
     AND CAST(t34.stl_dat AS DATE) > t31.max_dat
     AND t34.aus_fg <> 1
     AND (t34.aus_fg <> 2 OR NOT t31.kjmo BETWEEN 202409 AND 202602)
     AND OWG1.hwg_id = 64
    GROUP BY VIS02.mandant_id,
     VIS02.wrg_id,
     wup_id,
     VIS02.kjmo) AS planowg ON vis.wup_id = planowg.wup_id AND vis.mandant_id = planowg.mandant_id AND vis.wrg_id =
      planowg.wrg_id AND vis.kjmo = planowg.kjmo
   LEFT JOIN (SELECT VIS03.mandant_id,
     t44.aktuell_wup_id AS wup_id,
     t41.kjmo,
     SUM(VIS03.anz_kunde_hwg) AS anzahl_kunden_ist,
     SUM(VIS03.anz_kunde_hwg_kvj) AS anzahl_kunden_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_kunde_hwg_1 AS VIS03
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS ZEIT00 ON VIS03.dat = ZEIT00.dat
     INNER JOIN ZEIT_1 AS t41 ON ZEIT00.kjmo = t41.kjmo
     INNER JOIN WUP_1 AS t44 ON VIS03.wup_id = t44.wup_id AND VIS03.mandant_id = t44.mandant_id
    WHERE t44.neo_gj < t41.gj - 1
     AND CAST(t44.stl_dat AS DATE) > t41.max_dat
     AND t44.aus_fg <> 1
     AND (t44.aus_fg <> 2 OR NOT t41.kjmo BETWEEN 202409 AND 202602)
     AND VIS03.hwg_id = 64
    GROUP BY VIS03.mandant_id,
     wup_id,
     t41.kjmo) AS kunde_hwg ON vis.mandant_id = kunde_hwg.mandant_id AND vis.wup_id = kunde_hwg.wup_id AND vis.kjmo =
     kunde_hwg.kjmo
   LEFT JOIN (SELECT VIS04.mandant_id,
     VIS04.wrg_id,
     t54.aktuell_wup_id AS wup_id,
     t51.kjmo,
     SUM(VIS04.inventur_wert_netto) AS inventur_wert_netto,
     SUM(VIS04.inventur_ums_netto) AS inventur_ums_netto
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_1 AS VIS04
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG2 ON VIS04.owg_id = OWG2.owg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS ZEIT01 ON VIS04.dat_plan_zaehlung = ZEIT01.dat
     INNER JOIN ZEIT_1 AS t51 ON ZEIT01.kjmo = t51.kjmo
     INNER JOIN WUP_1 AS t54 ON VIS04.wup_id = t54.wup_id AND VIS04.mandant_id = t54.mandant_id
    WHERE t54.neo_gj < t51.gj - 1
     AND CAST(t54.stl_dat AS DATE) > t51.max_dat
     AND t54.aus_fg <> 1
     AND (t54.aus_fg <> 2 OR NOT t51.kjmo BETWEEN 202409 AND 202602)
     AND VIS04.hwg_id = 64
     AND VIS04.inventurart_int_id = 7
    GROUP BY VIS04.mandant_id,
     VIS04.wrg_id,
     wup_id,
     t51.kjmo) AS inv ON vis.mandant_id = inv.mandant_id AND vis.wup_id = inv.wup_id AND vis.wrg_id = inv.wrg_id AND vis
     .kjmo = inv.kjmo
   LEFT JOIN (SELECT VIS05.mandant_id,
     t64.aktuell_wup_id AS wup_id,
     t61.kjmo,
     SUM(CASE
       WHEN VIS05.status_1 NOT IN ('0B', '0N')
       THEN 1
       ELSE 0
       END) AS best_vor,
     SUM(CASE
       WHEN VIS05.status_1 IN ('0B')
       THEN 1
       ELSE 0
       END) AS best_man,
     SUM(CASE
       WHEN VIS05.status_1 IN ('V0', 'V-', 'V+')
       THEN 1
       ELSE 0
       END) AS best_kor
    FROM kfl_production_dbp_msi_view_vis.mv_bsch_bestvor_det_1 AS VIS05
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_art_wg_zu_1 AS ART_1 ON VIS05.art_id = ART.art_id AND VIS05.mandant_id =
       ART.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG1 ON ART.wg_id = WG1.wg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG3 ON WG1.owg_id = OWG3.owg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS ZEIT02 ON VIS05.dat_plan = ZEIT02.dat
     INNER JOIN ZEIT_1 AS t61 ON ZEIT02.kjmo = t61.kjmo
     INNER JOIN WUP_1 AS t64 ON VIS05.wup_id = t64.wup_id AND VIS05.mandant_id = t64.mandant_id
    WHERE t64.neo_gj < t61.gj - 1
     AND CAST(t64.stl_dat AS DATE) > t61.max_dat
     AND t64.aus_fg <> 1
     AND (t64.aus_fg <> 2 OR NOT t61.kjmo BETWEEN 202409 AND 202602)
     AND OWG3.hwg_id = 64
     AND VIS05.status_1 NOT IN ('0N')
    GROUP BY VIS05.mandant_id,
     wup_id,
     t61.kjmo) AS ueq ON vis.mandant_id = ueq.mandant_id AND vis.wup_id = ueq.wup_id AND vis.kjmo = ueq.kjmo
   LEFT JOIN (SELECT t74.mandant_id,
     t74.aktuell_wup_id AS wup_id,
     t71.kjmo,
     SUM(CASE
       WHEN t74.mandant_id <> 1 AND KMR_FRG.ergebnis_num = 1
       THEN 1
       ELSE 0
       END) AS kmr_ergebnis_nok,
     SUM(CASE
       WHEN t74.mandant_id <> 1 AND KMR_FRG.ergebnis_num >= 0
       THEN 1
       ELSE 0
       END) AS kmr_ergebnis_anz,
     COUNT(DISTINCT CASE
       WHEN t74.mandant_id <> 1
       THEN KMR_KAP.pruefung_id
       ELSE 0
       END) AS kmr_pruefung_anz
    FROM kfl_production_dbp_view.v_kmr_frage_1 AS KMR_FRG
     INNER JOIN kfl_production_dbp_view.v_kmr_pruefprogramm_kapitel_1 AS KMR_KAP ON KMR_FRG.kapitel_id = KMR_KAP.kapitel_id
        AND KMR_FRG.amx_system_id = KMR_KAP.amx_system_id
     INNER JOIN kfl_production_dbp_view.v_kmr_pruefung_1 AS KMR_PRF ON KMR_KAP.pruefung_id = KMR_PRF.pruefung_id AND
       KMR_KAP.amx_system_id = KMR_PRF.amx_system_id
     INNER JOIN kfl_production_dbp_view.v_kmr_l_organisationseinheit_1 AS KMR_LOE ON KMR_PRF.gepr_oe_id = KMR_LOE.orga_einheit_id
        AND KMR_PRF.amx_system_id = KMR_LOE.amx_system_id
     INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT03 ON KMR_PRF.dat_pruef_zeitraum_bis = ZEIT03.dat
     INNER JOIN ZEIT_1 AS t71 ON ZEIT03.kjmo = t71.kjmo
     INNER JOIN WUP_1 AS t74 ON KMR_LOE.wup_id = t74.wup_id AND KMR_LOE.mandant_id = t74.mandant_id
    WHERE t74.neo_gj < t71.gj - 1
     AND CAST(t74.stl_dat AS DATE) > t71.max_dat
     AND t74.aus_fg <> 1
     AND (t74.aus_fg <> 2 OR NOT t71.kjmo BETWEEN 202409 AND 202602)
     AND KMR_FRG.amx_system_id = 1
     AND KMR_PRF.pruefung_klasse_id IN (100003)
     AND KMR_PRF.pruefung_status_id IN (100005, 100041)
     AND ROUND(SAFE_CAST(SUBSTR(KMR_FRG.sort_nr, 14, 2) AS BIGNUMERIC), 0) IN (5)
    GROUP BY t74.mandant_id,
     wup_id,
     t71.kjmo) AS kmr ON vis.mandant_id = kmr.mandant_id AND vis.wup_id = kmr.wup_id AND vis.kjmo = kmr.kjmo);