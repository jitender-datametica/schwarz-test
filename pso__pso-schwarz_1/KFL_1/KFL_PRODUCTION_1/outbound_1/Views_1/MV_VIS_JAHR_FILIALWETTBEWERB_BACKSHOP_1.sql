CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jahr_filialwettbewerb_backshop_1 AS WITH ZEIT_1 AS (SELECT gj
   ,
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
        1, 20)) AS DATETIME)) - IF(EXTRACT(MONTH FROM SAFE_CAST(COALESCE(IF(wup_aenderung_grund_id = 3, '9999-12-31',
          NULL), SUBSTR(CAST(dat_bis AS STRING), 1, 20)) as DATETIME)) < 3, 1, 0) AS stl_gj,
    CASE
    WHEN mandant_id = 1 AND wup_id IN (1263, 1273, 3166, 6623, 8120, 8563, 8940, 5876) OR mandant_id = 3 AND wup_id IN (1010
          ) OR mandant_id = 7 AND wup_id IN (1110, 1410, 6210, 6310, 6410) OR mandant_id = 1 AND wup_id IN (2380)
    THEN 1
    WHEN mandant_id = 2 AND wup_id IN (1700, 6800)
    THEN 2
    ELSE 0
    END AS aus_fg
  FROM kfl_production_dbp_data.wup_1 AS WUP_1
  WHERE nb_id = 0
   AND dat_eroeffnung < DATE '2090-12-31') (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.vs_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.gj,
   VIS.kjmo_max AS bsj_kjmo,
   VIS.offen_ist AS bsj_offen,
   VISHWG.ums_netto_ist AS bsj_ums_netto_ist,
   VISHWG.ums_netto_kvj AS bsj_ums_netto_kvj,
    VISHWG.ums_netto_ist / IF(VISHWG.ums_netto_kvj = 0, NULL, VISHWG.ums_netto_kvj) AS bsj_ums_netto,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISHWG.ums_netto_ist / IF(VISHWG.ums_netto_kvj = 0, NULL, VISHWG.ums_netto_kvj)) IS NULL, VISHWG.ums_netto_ist
        / IF(VISHWG.ums_netto_kvj = 0, NULL, VISHWG.ums_netto_kvj)) AS bsj_ums_netto_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISHWG.ums_netto_ist / IF(VISHWG.ums_netto_kvj = 0, NULL, VISHWG.ums_netto_kvj)) IS NULL, VISHWG.ums_netto_ist
        / IF(VISHWG.ums_netto_kvj = 0, NULL, VISHWG.ums_netto_kvj)) AS bsj_ums_netto_dense,
   VIS.ums_netto_fil_ist AS bsj_ums_netto_fil_ist,
   VIS.ums_netto_fil_kvj AS bsj_ums_netto_fil_kvj,
    VISHWG.ums_netto_ist / IF(VIS.ums_netto_fil_ist = 0, NULL, VIS.ums_netto_fil_ist) AS bsj_umsatzanteil_netto_ist,
    VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj) AS bsj_umsatzanteil_netto_kvj,
     VISHWG.ums_netto_ist / IF(VIS.ums_netto_fil_ist = 0, NULL, VIS.ums_netto_fil_ist) - IF(VISHWG.ums_netto_kvj / IF(VIS
         .ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj) = 0, NULL, VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj
         = 0, NULL, VIS.ums_netto_fil_kvj)) AS bsj_umsatzanteil_netto,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISHWG.ums_netto_ist / IF(VIS.ums_netto_fil_ist = 0, NULL, VIS.ums_netto_fil_ist) - IF(VISHWG.ums_netto_kvj
            / IF(VIS.ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj) = 0, NULL, VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj
             = 0, NULL, VIS.ums_netto_fil_kvj))) IS NULL, VISHWG.ums_netto_ist / IF(VIS.ums_netto_fil_ist = 0, NULL, VIS
         .ums_netto_fil_ist) - IF(VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj) = 0
        , NULL, VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj))) AS
   bsj_umsatzanteil_netto_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISHWG.ums_netto_ist / IF(VIS.ums_netto_fil_ist = 0, NULL, VIS.ums_netto_fil_ist) - IF(VISHWG.ums_netto_kvj
            / IF(VIS.ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj) = 0, NULL, VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj
             = 0, NULL, VIS.ums_netto_fil_kvj))) IS NULL, VISHWG.ums_netto_ist / IF(VIS.ums_netto_fil_ist = 0, NULL, VIS
         .ums_netto_fil_ist) - IF(VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj) = 0
        , NULL, VISHWG.ums_netto_kvj / IF(VIS.ums_netto_fil_kvj = 0, NULL, VIS.ums_netto_fil_kvj))) AS
   bsj_umsatzanteil_netto_dense,
   VISABS.abs_op_ist AS bsj_abs_op_ist,
   PLANOWG.abs_owg_plan AS bsj_abs_owg_plan,
   PLANOWG.ums_owg_plan AS bsj_ums_owg_plan,
    VISABS.abs_op_ist / IF(VISHWG.ums_netto_ist = 0, NULL, VISHWG.ums_netto_ist) AS bsj_abschrift_op_ist,
    PLANOWG.abs_owg_plan / IF(PLANOWG.ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan) AS bsj_abschrift_op_plan,
     VISABS.abs_op_ist / IF(VISHWG.ums_netto_ist = 0, NULL, VISHWG.ums_netto_ist) - IF(PLANOWG.abs_owg_plan / IF(PLANOWG
         .ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan) = 0, NULL, PLANOWG.abs_owg_plan / IF(PLANOWG.ums_owg_plan = 0,
       NULL, PLANOWG.ums_owg_plan)) AS bsj_abschrift_op,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISABS.abs_op_ist / IF(VISHWG.ums_netto_ist = 0, NULL, VISHWG.ums_netto_ist) - IF(PLANOWG.abs_owg_plan /
           IF(PLANOWG.ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan) = 0, NULL, PLANOWG.abs_owg_plan / IF(PLANOWG.ums_owg_plan
             = 0, NULL, PLANOWG.ums_owg_plan))) IS NULL, VISABS.abs_op_ist / IF(VISHWG.ums_netto_ist = 0, NULL, VISHWG.ums_netto_ist
         ) - IF(PLANOWG.abs_owg_plan / IF(PLANOWG.ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan) = 0, NULL, PLANOWG.abs_owg_plan
          / IF(PLANOWG.ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan))) AS bsj_abschrift_op_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISABS.abs_op_ist / IF(VISHWG.ums_netto_ist = 0, NULL, VISHWG.ums_netto_ist) - IF(PLANOWG.abs_owg_plan /
           IF(PLANOWG.ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan) = 0, NULL, PLANOWG.abs_owg_plan / IF(PLANOWG.ums_owg_plan
             = 0, NULL, PLANOWG.ums_owg_plan))) IS NULL, VISABS.abs_op_ist / IF(VISHWG.ums_netto_ist = 0, NULL, VISHWG.ums_netto_ist
         ) - IF(PLANOWG.abs_owg_plan / IF(PLANOWG.ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan) = 0, NULL, PLANOWG.abs_owg_plan
          / IF(PLANOWG.ums_owg_plan = 0, NULL, PLANOWG.ums_owg_plan))) AS bsj_abschrift_op_dense,
   KUNDE_HWG.anzahl_kunden_ist AS bsj_anzahl_kunden_ist,
   KUNDE_HWG.anzahl_kunden_kvj AS bsj_anzahl_kunden_kvj,
    KUNDE_HWG.anzahl_kunden_ist / IF(KUNDE_HWG.anzahl_kunden_kvj = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj) AS
   bsj_anzahl_kunden,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KUNDE_HWG.anzahl_kunden_ist / IF(KUNDE_HWG.anzahl_kunden_kvj = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj))
      IS NULL, KUNDE_HWG.anzahl_kunden_ist / IF(KUNDE_HWG.anzahl_kunden_kvj = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj)) AS
   bsj_anzahl_kunden_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KUNDE_HWG.anzahl_kunden_ist / IF(KUNDE_HWG.anzahl_kunden_kvj = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj))
      IS NULL, KUNDE_HWG.anzahl_kunden_ist / IF(KUNDE_HWG.anzahl_kunden_kvj = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj)) AS
   bsj_anzahl_kunden_dense,
   VIS.anz_kunden_fil_ist AS bsj_anzahl_kunden_fil_ist,
   VIS.anz_kunden_fil_kvj AS bsj_anzahl_kunden_fil_kvj,
    KUNDE_HWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) AS bsj_kundenanteil_ist,
    KUNDE_HWG.anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj = 0, NULL, VIS.anz_kunden_fil_kvj) AS bsj_kundenanteil_kvj,
     KUNDE_HWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(KUNDE_HWG.anzahl_kunden_kvj
        / IF(VIS.anz_kunden_fil_kvj = 0, NULL, VIS.anz_kunden_fil_kvj) = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj
         = 0, NULL, VIS.anz_kunden_fil_kvj)) AS bsj_kundenanteil,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KUNDE_HWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(KUNDE_HWG
           .anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj = 0, NULL, VIS.anz_kunden_fil_kvj) = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj
           / IF(VIS.anz_kunden_fil_kvj = 0, NULL, VIS.anz_kunden_fil_kvj))) IS NULL, KUNDE_HWG.anzahl_kunden_ist / IF(VIS
          .anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(KUNDE_HWG.anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj
             = 0, NULL, VIS.anz_kunden_fil_kvj) = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj = 0,
          NULL, VIS.anz_kunden_fil_kvj))) AS bsj_kundenantiel_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KUNDE_HWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(KUNDE_HWG
           .anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj = 0, NULL, VIS.anz_kunden_fil_kvj) = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj
           / IF(VIS.anz_kunden_fil_kvj = 0, NULL, VIS.anz_kunden_fil_kvj))) IS NULL, KUNDE_HWG.anzahl_kunden_ist / IF(VIS
          .anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(KUNDE_HWG.anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj
             = 0, NULL, VIS.anz_kunden_fil_kvj) = 0, NULL, KUNDE_HWG.anzahl_kunden_kvj / IF(VIS.anz_kunden_fil_kvj = 0,
          NULL, VIS.anz_kunden_fil_kvj))) AS bsj_kundenanteil_dense,
   KMR.kmr_ergebnis_nok AS bsj_kmr_kc_bs_ergebnis_nok,
   KMR.kmr_ergebnis_anz AS bsj_kmr_kc_bs_ergebnis_anz,
   KMR.kmr_pruefung_anz AS bsj_kmr_kc_bs_pruefung_anz,
    KMR.kmr_ergebnis_nok / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz) AS bsj_kmr_kc_bs_nok,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KMR.kmr_ergebnis_nok / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) IS NULL, KMR.kmr_ergebnis_nok
        / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) AS bsj_kmr_kc_bs_nok_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KMR.kmr_ergebnis_nok / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) IS NULL, KMR.kmr_ergebnis_nok
        / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) AS bsj_kmr_kc_bs_nok_dense,
   INV.inventur_wert_netto AS bsj_inventur_wert_netto,
   INV.inventur_ums_netto AS bsj_inventur_ums_netto,
    INV.inventur_wert_netto / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto) AS bsj_inventur,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (INV.inventur_wert_netto / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) IS NULL, INV.inventur_wert_netto
        / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) AS bsj_inventur_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (INV.inventur_wert_netto / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) IS NULL, INV.inventur_wert_netto
        / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) AS bsj_inventur_dense,
   VISHWG.menge_ist AS bsj_menge_ist,
   VISHWG.menge_kvj AS bsj_menge_kvj,
    VISHWG.menge_ist / IF(VISHWG.menge_kvj = 0, NULL, VISHWG.menge_kvj) AS bsj_menge,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISHWG.menge_ist / IF(VISHWG.menge_kvj = 0, NULL, VISHWG.menge_kvj)) IS NULL, VISHWG.menge_ist / IF(VISHWG
         .menge_kvj = 0, NULL, VISHWG.menge_kvj)) AS bsj_menge_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISHWG.menge_ist / IF(VISHWG.menge_kvj = 0, NULL, VISHWG.menge_kvj)) IS NULL, VISHWG.menge_ist / IF(VISHWG
         .menge_kvj = 0, NULL, VISHWG.menge_kvj)) AS bsj_menge_dense,
   UEQ.best_vor AS bsj_ueq_best_vor,
   UEQ.best_man AS bsj_ueq_best_man,
   UEQ.best_kor AS bsj_ueq_best_kor,
     (UEQ.best_vor - UEQ.best_kor) / (UEQ.best_vor + UEQ.best_man) AS bsj_ueq,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY ((UEQ.best_vor - UEQ.best_kor) / (UEQ.best_vor + UEQ.best_man)) IS NULL, (UEQ.best_vor - UEQ.best_kor) /
        (UEQ.best_vor + UEQ.best_man)) AS bsj_ueq_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY ((UEQ.best_vor - UEQ.best_kor) / (UEQ.best_vor + UEQ.best_man)) IS NULL, (UEQ.best_vor - UEQ.best_kor) /
        (UEQ.best_vor + UEQ.best_man)) AS bsj_ueq_dense
  FROM (SELECT VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     t4.aktuell_wup_id AS wup_id,
     VIS0.wrg_id,
     t1.gj,
     MAX(t1.kjmo) AS kjmo_max,
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
     AND t4.aus_fg = 0
    GROUP BY VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     wup_id,
     VIS0.wrg_id,
     t1.gj) AS VIS
   LEFT JOIN (SELECT VIS00.mandant_id,
     t14.aktuell_wup_id AS wup_id,
     VIS00.wrg_id,
     t11.gj,
     SUM(VIS00.ums_netto) AS ums_netto_ist,
     SUM(VIS00.ums_netto_kvj) AS ums_netto_kvj,
     SUM(VIS00.menge) AS menge_ist,
     SUM(VIS00.menge_kvj) AS menge_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg_1 AS VIS00
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS00.wg_id = WG.wg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
     INNER JOIN ZEIT_1 AS t11 ON VIS00.kjmo = t11.kjmo
     INNER JOIN WUP_1 AS t14 ON VIS00.wup_id = t14.wup_id AND VIS00.mandant_id = t14.mandant_id
    WHERE t14.neo_gj < t11.gj - 1
     AND CAST(t14.stl_dat AS DATE) > t11.max_dat
     AND t14.aus_fg = 0
     AND OWG.hwg_id = 62
    GROUP BY VIS00.mandant_id,
     wup_id,
     VIS00.wrg_id,
     t11.gj) AS VISHWG ON VIS.wup_id = VISHWG.wup_id AND VIS.mandant_id = VISHWG.mandant_id AND VIS.gj = VISHWG.gj AND
     VIS.wrg_id = VISHWG.wrg_id
   LEFT JOIN (SELECT VIS01.mandant_id,
     VIS01.wrg_id,
     t24.aktuell_wup_id AS wup_id,
     t21.gj,
     SUM(CASE
        WHEN VIS01.mandant_id IN (6) AND VIS01.abschriftart_id = 2 OR VIS01.mandant_id IN (3) AND VIS01.abschriftart_id
              = 11 OR VIS01.mandant_id IN (2, 4, 5, 7, 8) AND VIS01.abschriftart_id = 7 OR VIS01.mandant_id IN (2, 5)
           AND VIS01.abschriftart_id = 10 OR VIS01.abschriftart_id = 20 AND VIS01.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS01.abschrift_netto) AS abs_op_ist,
     SUM(CASE
        WHEN VIS01.mandant_id IN (6) AND VIS01.abschriftart_id = 2 OR VIS01.mandant_id IN (3) AND VIS01.abschriftart_id
              = 11 OR VIS01.mandant_id IN (2, 4, 5, 7, 8) AND VIS01.abschriftart_id = 7 OR VIS01.mandant_id IN (2, 5)
           AND VIS01.abschriftart_id = 10 OR VIS01.abschriftart_id = 20 AND VIS01.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS01.abschrift_netto_kvj) AS abs_op_vj
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
     AND t24.aus_fg = 0
     AND OWG0.hwg_id = 62
     AND ABS_THEMA.abschriftart_thema_int_id IN (1, 4)
    GROUP BY VIS01.mandant_id,
     VIS01.wrg_id,
     wup_id,
     t21.gj) AS VISABS ON VIS.wup_id = VISABS.wup_id AND VIS.mandant_id = VISABS.mandant_id AND VIS.gj = VISABS.gj AND
     VIS.wrg_id = VISABS.wrg_id
   LEFT JOIN (SELECT VIS02.mandant_id,
     VIS02.wrg_id,
     t34.aktuell_wup_id AS wup_id,
     t31.gj,
     SUM(VIS02.abschriften_netto_operativ_plan) AS abs_owg_plan,
     SUM(VIS02.umsatz_netto_plan) AS ums_owg_plan
    FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS VIS02
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG1 ON VIS02.owg_id = OWG1.owg_id
     INNER JOIN ZEIT_1 AS t31 ON VIS02.kjmo = t31.kjmo
     INNER JOIN WUP_1 AS t34 ON VIS02.wup_id = t34.wup_id AND VIS02.mandant_id = t34.mandant_id
    WHERE t34.neo_gj < t31.gj - 1
     AND CAST(t34.stl_dat AS DATE) > t31.max_dat
     AND t34.aus_fg = 0
     AND OWG1.hwg_id = 62
    GROUP BY VIS02.mandant_id,
     VIS02.wrg_id,
     wup_id,
     t31.gj) AS PLANOWG ON VIS.wup_id = PLANOWG.wup_id AND VIS.mandant_id = PLANOWG.mandant_id AND VIS.gj = PLANOWG.gj
    AND VIS.wrg_id = PLANOWG.wrg_id
   LEFT JOIN (SELECT VIS03.mandant_id,
     t44.aktuell_wup_id AS wup_id,
     t41.gj,
     SUM(VIS03.anz_kunde_hwg) AS anzahl_kunden_ist,
     SUM(VIS03.anz_kunde_hwg_kvj) AS anzahl_kunden_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_kunde_hwg_1 AS VIS03
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS ZEIT00 ON VIS03.dat = ZEIT00.dat
     INNER JOIN ZEIT_1 AS t41 ON ZEIT00.kjmo = t41.kjmo
     INNER JOIN WUP_1 AS t44 ON VIS03.wup_id = t44.wup_id AND VIS03.mandant_id = t44.mandant_id
    WHERE t44.neo_gj < t41.gj - 1
     AND CAST(t44.stl_dat AS DATE) > t41.max_dat
     AND t44.aus_fg = 0
     AND VIS03.hwg_id = 62
    GROUP BY VIS03.mandant_id,
     wup_id,
     t41.gj) AS KUNDE_HWG ON VIS.mandant_id = KUNDE_HWG.mandant_id AND VIS.wup_id = KUNDE_HWG.wup_id AND VIS.gj =
     KUNDE_HWG.gj
   LEFT JOIN (SELECT VIS04.mandant_id,
     t54.aktuell_wup_id AS wup_id,
     VIS04.wrg_id,
     t51.gj,
     SUM(VIS04.inventur_wert_netto) AS inventur_wert_netto,
     SUM(VIS04.inventur_ums_netto) AS inventur_ums_netto
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_1 AS VIS04
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG2 ON VIS04.owg_id = OWG2.owg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS ZEIT01 ON VIS04.dat_plan_zaehlung = ZEIT01.dat
     INNER JOIN ZEIT_1 AS t51 ON ZEIT01.kjmo = t51.kjmo
     INNER JOIN WUP_1 AS t54 ON VIS04.wup_id = t54.wup_id AND VIS04.mandant_id = t54.mandant_id
    WHERE t54.neo_gj < t51.gj - 1
     AND CAST(t54.stl_dat AS DATE) > t51.max_dat
     AND t54.aus_fg = 0
     AND OWG2.hwg_id = 62
    GROUP BY VIS04.mandant_id,
     wup_id,
     VIS04.wrg_id,
     t51.gj) AS INV ON VIS.mandant_id = INV.mandant_id AND VIS.wup_id = INV.wup_id AND VIS.gj = INV.gj AND VIS.wrg_id =
     INV.wrg_id
   LEFT JOIN (SELECT VIS05.mandant_id,
     t64.aktuell_wup_id AS wup_id,
     t61.gj,
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
     AND t64.aus_fg = 0
     AND OWG3.hwg_id = 62
     AND VIS05.status_1 NOT IN ('0N')
    GROUP BY VIS05.mandant_id,
     wup_id,
     t61.gj) AS UEQ ON VIS.mandant_id = UEQ.mandant_id AND VIS.wup_id = UEQ.wup_id AND VIS.gj = UEQ.gj
   LEFT JOIN (SELECT t74.mandant_id,
     t74.aktuell_wup_id AS wup_id,
     t71.gj,
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
     AND t74.aus_fg = 0
     AND KMR_FRG.amx_system_id = 1
     AND KMR_PRF.pruefung_klasse_id IN (100003)
     AND KMR_PRF.pruefung_status_id IN (100005, 100041)
     AND ROUND(SAFE_CAST(SUBSTR(KMR_FRG.sort_nr, 14, 2) AS BIGNUMERIC), 0) IN (15)
    GROUP BY t74.mandant_id,
     wup_id,
     t71.gj) AS KMR ON VIS.mandant_id = KMR.mandant_id AND VIS.wup_id = KMR.wup_id AND VIS.gj = KMR.gj);