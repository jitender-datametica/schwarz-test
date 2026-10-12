CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jahr_filialwettbewerb_theke AS WITH ZEIT AS (SELECT gj,
   akt_gj,
    akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) AS akt_gj_mo,
   kjmo,
   kjmo_vj,
   akt_mo,
   min_dat,
   max_dat
  FROM kfl_production_dbp_data.monat AS ZEIT
  WHERE akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) = 0
   AND akt_mo < 0), WUP AS (SELECT mandant_id,
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
                     ) OR mandant_id = 7 AND wup_id IN (1110, 1410, 6210, 6310, 6410) OR mandant_id = 1 AND wup_id IN (1300
                   , 1380, 1383, 1403, 1413, 1423, 1430, 1473, 1503, 1510) OR mandant_id = 1 AND wup_id IN (1513, 1520,
                  1563, 1583, 1613, 1663, 1690, 1760, 1830, 1863) OR mandant_id = 1 AND wup_id IN (1950, 1960, 1970,
                 2083, 2213, 2220, 2363, 2370, 2380, 2443) OR mandant_id = 1 AND wup_id IN (2590, 2613, 2733, 2753, 2800
                , 2810, 2820, 2920, 2930, 2973) OR mandant_id = 1 AND wup_id IN (3063, 3166, 3223, 3280, 3400, 3770,
               3790, 3850, 3960, 4043) OR mandant_id = 1 AND wup_id IN (4103, 4160, 4300, 4323, 4373, 4530, 4620, 4760,
              4890, 4950) OR mandant_id = 1 AND wup_id IN (4973, 4980, 5060, 5110, 5340, 5353, 5373, 5413, 5433, 5463)
         OR mandant_id = 1 AND wup_id IN (5473, 5493, 5520, 5533, 5553, 5590, 5670, 5800, 5876, 5900) OR mandant_id = 1
         AND wup_id IN (5910, 6030, 6070, 6310, 6330, 6380, 6480, 6590, 6623, 6690) OR mandant_id = 1 AND wup_id IN (6730
          , 6760, 6800, 6970, 7210, 7280, 7300, 7370, 7380, 7440) OR mandant_id = 1 AND wup_id IN (7600, 7690, 7790,
         7820, 7830, 8130, 8240, 8370, 8480, 8550) OR mandant_id = 1 AND wup_id IN (8563, 8600, 8780, 8940)
    THEN 1
    WHEN mandant_id = 2 AND wup_id IN (1700, 6800)
    THEN 2
    ELSE 0
    END AS aus_fg
  FROM kfl_production_dbp_data.wup AS WUP
  WHERE nb_id = 0
   AND dat_eroeffnung < DATE '2090-12-31') (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.vs_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.gj,
   VIS.kjmo_max AS tdj_kjmo,
   VIS.offen_ist AS tdj_offen,
   VISOWG.ums_netto_ist AS tdj_ums_netto_ist,
   VISOWG.ums_netto_kvj AS tdj_ums_netto_kvj,
    VISOWG.ums_netto_ist / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj) AS tdj_ums_netto,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISOWG.ums_netto_ist / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj)) IS NULL, VISOWG.ums_netto_ist
        / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj)) AS tdj_ums_netto_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISOWG.ums_netto_ist / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj)) IS NULL, VISOWG.ums_netto_ist
        / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj)) AS tdj_ums_netto_dense,
   VISTAG.ums_fil_ist AS tdj_ums_netto_fil_ist,
   VISTAG.ums_fil_vj AS tdj_ums_netto_fil_kvj,
    VISOWG.ums_netto_ist / IF(VISTAG.ums_fil_ist = 0, NULL, VISTAG.ums_fil_ist) AS tdj_umsatzanteil_netto_ist,
    VISOWG.ums_netto_kvj / IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj) AS tdj_umsatzanteil_netto_kvj,
     VISOWG.ums_netto_ist / IF(VISTAG.ums_fil_ist = 0, NULL, VISTAG.ums_fil_ist) - IF(VISOWG.ums_netto_kvj / IF(VISTAG.ums_fil_vj
          = 0, NULL, VISTAG.ums_fil_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj
       )) AS tdj_umsatzanteil_netto,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISOWG.ums_netto_ist / IF(VISTAG.ums_fil_ist = 0, NULL, VISTAG.ums_fil_ist) - IF(VISOWG.ums_netto_kvj /
           IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(VISTAG.ums_fil_vj = 0
            , NULL, VISTAG.ums_fil_vj))) IS NULL, VISOWG.ums_netto_ist / IF(VISTAG.ums_fil_ist = 0, NULL, VISTAG.ums_fil_ist
         ) - IF(VISOWG.ums_netto_kvj / IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj) = 0, NULL, VISOWG.ums_netto_kvj
          / IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj))) AS tdj_umsatzanteil_netto_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISOWG.ums_netto_ist / IF(VISTAG.ums_fil_ist = 0, NULL, VISTAG.ums_fil_ist) - IF(VISOWG.ums_netto_kvj /
           IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(VISTAG.ums_fil_vj = 0
            , NULL, VISTAG.ums_fil_vj))) IS NULL, VISOWG.ums_netto_ist / IF(VISTAG.ums_fil_ist = 0, NULL, VISTAG.ums_fil_ist
         ) - IF(VISOWG.ums_netto_kvj / IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj) = 0, NULL, VISOWG.ums_netto_kvj
          / IF(VISTAG.ums_fil_vj = 0, NULL, VISTAG.ums_fil_vj))) AS tdj_umsatzanteil_netto_dense,
   WCALOWG.anzahl_kunden_ist AS tdj_anzahl_kunden_ist,
   WCALOWG.anzahl_kunden_vj AS tdj_anzahl_kunden_kvj,
    WCALOWG.anzahl_kunden_ist / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj) AS tdj_anzahl_kunden,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (WCALOWG.anzahl_kunden_ist / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj)) IS NULL,
       WCALOWG.anzahl_kunden_ist / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj)) AS
   tdj_anzahl_kunden_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (WCALOWG.anzahl_kunden_ist / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj)) IS NULL,
       WCALOWG.anzahl_kunden_ist / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj)) AS
   tdj_anzahl_kunden_dense,
   VIS.anz_kunden_fil_ist AS tdj_anzahl_kunden_fil_ist,
   VIS.anz_kunden_fil_vj AS tdj_anzahl_kunden_fil_kvj,
    WCALOWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) AS tdj_kundenanteil_ist,
    WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj) AS tdj_kundenanteil_kvj,
     WCALOWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(WCALOWG.anzahl_kunden_vj
        / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj) = 0, NULL, WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj
         = 0, NULL, VIS.anz_kunden_fil_vj)) AS tdj_kundenanteil,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (WCALOWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(WCALOWG.anzahl_kunden_vj
            / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj) = 0, NULL, WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj
             = 0, NULL, VIS.anz_kunden_fil_vj))) IS NULL, WCALOWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0,
         NULL, VIS.anz_kunden_fil_ist) - IF(WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj
           ) = 0, NULL, WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj))) AS
   tdj_kundenantiel_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (WCALOWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0, NULL, VIS.anz_kunden_fil_ist) - IF(WCALOWG.anzahl_kunden_vj
            / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj) = 0, NULL, WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj
             = 0, NULL, VIS.anz_kunden_fil_vj))) IS NULL, WCALOWG.anzahl_kunden_ist / IF(VIS.anz_kunden_fil_ist = 0,
         NULL, VIS.anz_kunden_fil_ist) - IF(WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj
           ) = 0, NULL, WCALOWG.anzahl_kunden_vj / IF(VIS.anz_kunden_fil_vj = 0, NULL, VIS.anz_kunden_fil_vj))) AS
   tdj_kundenanteil_dense,
    VISOWG.ums_netto_ist / IF(WCALOWG.anzahl_kunden_ist = 0, NULL, WCALOWG.anzahl_kunden_ist) AS tdj_avg_bon_ist,
    VISOWG.ums_netto_kvj / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj) AS tdj_avg_bon_kvj,
     VISOWG.ums_netto_ist / IF(WCALOWG.anzahl_kunden_ist = 0, NULL, WCALOWG.anzahl_kunden_ist) / IF(VISOWG.ums_netto_kvj
        / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(WCALOWG
        .anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj)) AS tdj_avg_bon,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISOWG.ums_netto_ist / IF(WCALOWG.anzahl_kunden_ist = 0, NULL, WCALOWG.anzahl_kunden_ist) / IF(VISOWG.ums_netto_kvj
            / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(WCALOWG
            .anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj))) IS NULL, VISOWG.ums_netto_ist / IF(WCALOWG.anzahl_kunden_ist
           = 0, NULL, WCALOWG.anzahl_kunden_ist) / IF(VISOWG.ums_netto_kvj / IF(WCALOWG.anzahl_kunden_vj = 0, NULL,
           WCALOWG.anzahl_kunden_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj
          ))) AS tdj_avg_bon_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISOWG.ums_netto_ist / IF(WCALOWG.anzahl_kunden_ist = 0, NULL, WCALOWG.anzahl_kunden_ist) / IF(VISOWG.ums_netto_kvj
            / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(WCALOWG
            .anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj))) IS NULL, VISOWG.ums_netto_ist / IF(WCALOWG.anzahl_kunden_ist
           = 0, NULL, WCALOWG.anzahl_kunden_ist) / IF(VISOWG.ums_netto_kvj / IF(WCALOWG.anzahl_kunden_vj = 0, NULL,
           WCALOWG.anzahl_kunden_vj) = 0, NULL, VISOWG.ums_netto_kvj / IF(WCALOWG.anzahl_kunden_vj = 0, NULL, WCALOWG.anzahl_kunden_vj
          ))) AS tdj_avg_bon_dense,
   VISABS.abs_op_ist AS tdj_abs_op_ist,
   VISABS.abs_op_kvj AS tdj_abs_op_kvj,
    VISABS.abs_op_ist / IF(VISOWG.ums_netto_ist = 0, NULL, VISOWG.ums_netto_ist) AS tdj_abschrift_op_ist,
    VISABS.abs_op_kvj / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj) AS tdj_abschrift_op_kvj,
     VISABS.abs_op_ist / IF(VISOWG.ums_netto_ist = 0, NULL, VISOWG.ums_netto_ist) - IF(VISABS.abs_op_kvj / IF(VISOWG.ums_netto_kvj
          = 0, NULL, VISOWG.ums_netto_kvj) = 0, NULL, VISABS.abs_op_kvj / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj
       )) AS tdj_abschrift_op,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISABS.abs_op_ist / IF(VISOWG.ums_netto_ist = 0, NULL, VISOWG.ums_netto_ist) - IF(VISABS.abs_op_kvj / IF(VISOWG
             .ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj) = 0, NULL, VISABS.abs_op_kvj / IF(VISOWG.ums_netto_kvj = 0
           , NULL, VISOWG.ums_netto_kvj))) IS NULL, VISABS.abs_op_ist / IF(VISOWG.ums_netto_ist = 0, NULL, VISOWG.ums_netto_ist
         ) - IF(VISABS.abs_op_kvj / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj) = 0, NULL, VISABS.abs_op_kvj
          / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj))) AS tdj_abschrift_op_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (VISABS.abs_op_ist / IF(VISOWG.ums_netto_ist = 0, NULL, VISOWG.ums_netto_ist) - IF(VISABS.abs_op_kvj / IF(VISOWG
             .ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj) = 0, NULL, VISABS.abs_op_kvj / IF(VISOWG.ums_netto_kvj = 0
           , NULL, VISOWG.ums_netto_kvj))) IS NULL, VISABS.abs_op_ist / IF(VISOWG.ums_netto_ist = 0, NULL, VISOWG.ums_netto_ist
         ) - IF(VISABS.abs_op_kvj / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj) = 0, NULL, VISABS.abs_op_kvj
          / IF(VISOWG.ums_netto_kvj = 0, NULL, VISOWG.ums_netto_kvj))) AS tdj_abschrift_op_dense,
   INV.inventur_wert_netto AS tdj_inventur_wert_netto,
   INV.inventur_ums_netto AS tdj_inventur_ums_netto,
    INV.inventur_wert_netto / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto) AS tdj_inventur,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (INV.inventur_wert_netto / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) IS NULL, INV.inventur_wert_netto
        / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) AS tdj_inventur_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (INV.inventur_wert_netto / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) IS NULL, INV.inventur_wert_netto
        / IF(INV.inventur_ums_netto = 0, NULL, INV.inventur_ums_netto)) AS tdj_inventur_dense,
   KMR.kmr_ergebnis_nok AS tdj_kmr_kc_theke_ergebnis_nok,
   KMR.kmr_ergebnis_anz AS tdj_kmr_kc_theke_ergebnis_anz,
   KMR.kmr_pruefung_anz AS tdj_kmr_kc_theke_pruefung_anz,
    KMR.kmr_ergebnis_nok / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz) AS tdj_kmr_kc_theke_nok,
   RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KMR.kmr_ergebnis_nok / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) IS NULL, KMR.kmr_ergebnis_nok
        / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) AS tdj_kmr_kc_theke_nok_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.vs_id AS STRING), VIS.wrg_id, CAST(VIS.gj AS STRING)
      ORDER BY (KMR.kmr_ergebnis_nok / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) IS NULL, KMR.kmr_ergebnis_nok
        / IF(KMR.kmr_ergebnis_anz = 0, NULL, KMR.kmr_ergebnis_anz)) AS tdj_kmr_kc_theke_nok_dense,
   NULL AS tdj_warten_theke,
   NULL AS tdj_warten_theke_rank,
   NULL AS tdj_warten_theke_dense,
   NULL AS tdj_kc_warenfrische_fest,
   NULL AS tdj_kc_warenfrische_ges,
   NULL AS tdj_kc_warenfrische_nok,
   NULL AS tdj_kc_warenfrische_nok_rank,
   NULL AS tdj_kc_warenfrische_nok_dense,
   NULL AS tdj_kc_sauberkeit_fest,
   NULL AS tdj_kc_sauberkeit_ges,
   NULL AS tdj_kc_sauberkeit_nok,
   NULL AS tdj_kc_sauberkeit_nok_rank,
   NULL AS tdj_kc_sauberkeit_nok_dense
  FROM (SELECT VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     t4.aktuell_wup_id AS wup_id,
     VIS0.wrg_id,
     t1.gj,
     MAX(VIS0.kjmo) AS kjmo_max,
     SUM(VIS0.anz_offen) AS offen_ist,
     SUM(VIS0.anz_kunde) AS anz_kunden_fil_ist,
     SUM(VIS0.anz_kunde_kvj) AS anz_kunden_fil_vj
    FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup AS VIS0
     INNER JOIN ZEIT AS t1 ON VIS0.kjmo = t1.kjmo
     INNER JOIN WUP AS t4 ON VIS0.wup_id = t4.wup_id AND VIS0.mandant_id = t4.mandant_id
    WHERE t4.neo_gj < t1.gj - 1
     AND CAST(t4.stl_dat AS DATE) > t1.max_dat
     AND t4.aus_fg = 0
    GROUP BY VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     wup_id,
     VIS0.wrg_id,
     t1.gj) AS VIS
   INNER JOIN (SELECT VIS00.mandant_id,
     t14.aktuell_wup_id AS wup_id,
     VIS00.wrg_id,
     t11.gj,
     SUM(VIS00.ums_netto) AS ums_fil_ist,
     SUM(VIS00.ums_netto_kvj) AS ums_fil_vj
    FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup AS VIS00
     INNER JOIN kfl_production_dbp_data.tag AS ZEIT0 ON VIS00.dat = ZEIT0.dat
     INNER JOIN ZEIT AS t11 ON ZEIT0.kjmo = t11.kjmo
     INNER JOIN WUP AS t14 ON VIS00.wup_id = t14.wup_id AND VIS00.mandant_id = t14.mandant_id
    WHERE t14.neo_gj < t11.gj - 1
     AND CAST(t14.stl_dat AS DATE) > t11.max_dat
     AND t14.aus_fg = 0
    GROUP BY VIS00.mandant_id,
     wup_id,
     VIS00.wrg_id,
     t11.gj) AS VISTAG ON VIS.wup_id = VISTAG.wup_id AND VIS.mandant_id = VISTAG.mandant_id AND VIS.gj = VISTAG.gj AND
     VIS.wrg_id = VISTAG.wrg_id
   LEFT JOIN (SELECT VIS01.mandant_id,
     t24.aktuell_wup_id AS wup_id,
     VIS01.wrg_id,
     t21.gj,
     SUM(VIS01.ums_netto) AS ums_netto_ist,
     SUM(VIS01.ums_netto_kvj) AS ums_netto_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg AS VIS01
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG ON VIS01.wg_id = WG.wg_id
     INNER JOIN ZEIT AS t21 ON VIS01.kjmo = t21.kjmo
     INNER JOIN WUP AS t24 ON VIS01.wup_id = t24.wup_id AND VIS01.mandant_id = t24.mandant_id
    WHERE t24.neo_gj < t21.gj - 1
     AND CAST(t24.stl_dat AS DATE) > t21.max_dat
     AND t24.aus_fg = 0
     AND WG.owg_id IN (1001, 1002, 1003, 1004)
    GROUP BY VIS01.mandant_id,
     wup_id,
     VIS01.wrg_id,
     t21.gj) AS VISOWG ON VIS.wup_id = VISOWG.wup_id AND VIS.mandant_id = VISOWG.mandant_id AND VIS.gj = VISOWG.gj AND
     VIS.wrg_id = VISOWG.wrg_id
   LEFT JOIN (SELECT VIS02.mandant_id,
     t34.aktuell_wup_id AS wup_id,
     VIS02.wrg_id,
     t31.gj,
     SUM(CASE
        WHEN VIS02.mandant_id IN (6) AND VIS02.abschriftart_id = 2 OR VIS02.mandant_id IN (3) AND VIS02.abschriftart_id
              = 11 OR VIS02.mandant_id IN (2, 4, 5, 7, 8) AND VIS02.abschriftart_id = 7 OR VIS02.mandant_id IN (2, 5)
           AND VIS02.abschriftart_id = 10 OR VIS02.abschriftart_id = 20 AND VIS02.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS02.abschrift_netto) AS abs_op_ist,
     SUM(CASE
        WHEN VIS02.mandant_id IN (6) AND VIS02.abschriftart_id = 2 OR VIS02.mandant_id IN (3) AND VIS02.abschriftart_id
              = 11 OR VIS02.mandant_id IN (2, 4, 5, 7, 8) AND VIS02.abschriftart_id = 7 OR VIS02.mandant_id IN (2, 5)
           AND VIS02.abschriftart_id = 10 OR VIS02.abschriftart_id = 20 AND VIS02.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS02.abschrift_netto_kvj) AS abs_op_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_abschriften_wg AS VIS02
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu AS ABS_ART ON VIS02.abschriftart_id = ABS_ART.abschriftart_id
        AND VIS02.mandant_id = ABS_ART.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu AS ABS_THEMA ON ABS_ART.abschriftart_int_id
       = ABS_THEMA.abschriftart_int_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG0 ON VIS02.wg_id = WG0.wg_id
     INNER JOIN ZEIT AS t31 ON VIS02.kjmo = t31.kjmo
     INNER JOIN WUP AS t34 ON VIS02.wup_id = t34.wup_id AND VIS02.mandant_id = t34.mandant_id
    WHERE t34.neo_gj < t31.gj - 1
     AND CAST(t34.stl_dat AS DATE) > t31.max_dat
     AND t34.aus_fg = 0
     AND WG0.owg_id IN (1001, 1002, 1003, 1004)
     AND ABS_THEMA.abschriftart_thema_int_id IN (1, 4)
    GROUP BY VIS02.mandant_id,
     wup_id,
     VIS02.wrg_id,
     t31.gj) AS VISABS ON VIS.wup_id = VISABS.wup_id AND VIS.mandant_id = VISABS.mandant_id AND VIS.gj = VISABS.gj AND
     VIS.wrg_id = VISABS.wrg_id
   LEFT JOIN (SELECT VIS0.mandant_id,
     VIS0.wrg_id,
     t47.aktuell_wup_id AS wup_id,
     t44.gj,
     SUM(VIS0.bonanzahl_frischetheke_ohne_fisch_ist) AS anzahl_kunden_ist,
     SUM(VIS0.bonanzahl_frischetheke_ohne_fisch_ist_kvj) AS anzahl_kunden_vj
    FROM (SELECT mandant_id,
        wrg_id,
        wup_id,
        dat,
        bonanzahl_frischetheke_ohne_fisch AS bonanzahl_frischetheke_ohne_fisch_ist,
        0 AS bonanzahl_frischetheke_ohne_fisch_ist_kvj
       FROM kfl_production_dbp_msi_view_vis.mv_wupcal AS WCAL1
       UNION ALL
       SELECT mandant_id,
        wrg_id,
        wup_id,
        IF(dat = LAST_DAY(dat), LAST_DAY(DATE_ADD(dat, INTERVAL 12 MONTH)), DATE_ADD(dat, INTERVAL 12 MONTH)) AS dat,
        0 AS bonanzahl_frischetheke_ohne_fisch_ist,
        bonanzahl_frischetheke_ohne_fisch AS bonanzahl_frischetheke_ohne_fisch_ist_kvj
       FROM kfl_production_dbp_msi_view_vis.mv_wupcal AS WCAL2) AS VIS0
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag AS ZEIT00 ON VIS0.dat = ZEIT00.dat
     INNER JOIN ZEIT AS t44 ON ZEIT00.kjmo = t44.kjmo
     INNER JOIN WUP AS t47 ON VIS0.wup_id = t47.wup_id AND VIS0.mandant_id = t47.mandant_id
    WHERE t47.neo_gj < t44.gj - 1
     AND CAST(t47.stl_dat AS DATE) > t44.max_dat
     AND t47.aus_fg = 0
    GROUP BY VIS0.mandant_id,
     VIS0.wrg_id,
     wup_id,
     t44.gj) AS WCALOWG ON VIS.mandant_id = WCALOWG.mandant_id AND VIS.wup_id = WCALOWG.wup_id AND VIS.gj = WCALOWG.gj
    AND VIS.wrg_id = WCALOWG.wrg_id
   LEFT JOIN (SELECT VIS03.mandant_id,
     t57.aktuell_wup_id AS wup_id,
     VIS03.wrg_id,
     t54.gj,
     SUM(VIS03.inventur_wert_netto) AS inventur_wert_netto,
     SUM(VIS03.inventur_ums_netto) AS inventur_ums_netto
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur AS VIS03
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag AS ZEIT01 ON VIS03.dat_plan_zaehlung = ZEIT01.dat
     INNER JOIN ZEIT AS t54 ON ZEIT01.kjmo = t54.kjmo
     INNER JOIN WUP AS t57 ON VIS03.wup_id = t57.wup_id AND VIS03.mandant_id = t57.mandant_id
    WHERE t57.neo_gj < t54.gj - 1
     AND CAST(t57.stl_dat AS DATE) > t54.max_dat
     AND t57.aus_fg = 0
     AND VIS03.owg_id IN (1001, 1002, 1003, 1004)
    GROUP BY VIS03.mandant_id,
     wup_id,
     VIS03.wrg_id,
     t54.gj) AS INV ON VIS.mandant_id = INV.mandant_id AND VIS.wup_id = INV.wup_id AND VIS.gj = INV.gj AND VIS.wrg_id =
     INV.wrg_id
   LEFT JOIN (SELECT t67.mandant_id,
     t67.aktuell_wup_id AS wup_id,
     t64.gj,
     SUM(CASE
       WHEN t67.mandant_id <> 1 AND KMR_FRG.ergebnis_num = 1
       THEN 1
       ELSE 0
       END) AS kmr_ergebnis_nok,
     SUM(CASE
       WHEN t67.mandant_id <> 1 AND KMR_FRG.ergebnis_num >= 0
       THEN 1
       ELSE 0
       END) AS kmr_ergebnis_anz,
     COUNT(DISTINCT CASE
       WHEN t67.mandant_id <> 1
       THEN KMR_KAP.pruefung_id
       ELSE 0
       END) AS kmr_pruefung_anz
    FROM kfl_production_dbp_view.v_kmr_frage AS KMR_FRG
     INNER JOIN kfl_production_dbp_view.v_kmr_pruefprogramm_kapitel AS KMR_KAP ON KMR_FRG.kapitel_id = KMR_KAP.kapitel_id
        AND KMR_FRG.amx_system_id = KMR_KAP.amx_system_id
     INNER JOIN kfl_production_dbp_view.v_kmr_pruefung AS KMR_PRF ON KMR_KAP.pruefung_id = KMR_PRF.pruefung_id AND
       KMR_KAP.amx_system_id = KMR_PRF.amx_system_id
     INNER JOIN kfl_production_dbp_view.v_kmr_l_organisationseinheit AS KMR_LOE ON KMR_PRF.gepr_oe_id = KMR_LOE.orga_einheit_id
        AND KMR_PRF.amx_system_id = KMR_LOE.amx_system_id
     INNER JOIN kfl_production_dbp_data.tag AS ZEIT02 ON KMR_PRF.dat_pruef_zeitraum_bis = ZEIT02.dat
     INNER JOIN ZEIT AS t64 ON ZEIT02.kjmo = t64.kjmo
     INNER JOIN WUP AS t67 ON KMR_LOE.wup_id = t67.wup_id AND KMR_LOE.mandant_id = t67.mandant_id
    WHERE t67.neo_gj < t64.gj - 1
     AND CAST(t67.stl_dat AS DATE) > t64.max_dat
     AND t67.aus_fg = 0
     AND KMR_FRG.amx_system_id = 1
     AND KMR_PRF.pruefung_klasse_id IN (100003)
     AND KMR_PRF.pruefung_status_id IN (100005, 100041)
     AND ROUND(SAFE_CAST(SUBSTR(KMR_FRG.sort_nr, 14, 2) AS BIGNUMERIC), 0) IN (40)
    GROUP BY t67.mandant_id,
     wup_id,
     t64.gj) AS KMR ON VIS.mandant_id = KMR.mandant_id AND VIS.wup_id = KMR.wup_id AND VIS.gj = KMR.gj);