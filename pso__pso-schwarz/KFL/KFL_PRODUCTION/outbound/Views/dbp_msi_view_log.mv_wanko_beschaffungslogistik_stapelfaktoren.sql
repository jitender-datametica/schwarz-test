CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_wanko_beschaffungslogistik_stapelfaktoren (mandant_id,
dat_lief, beladestelle_tms_gp_id, versender_tms_gp_id, system_id, tms_gp_plz, empfaenger_tms_gp_id, art_id,
handling_unit_id_nach, tms_auftrag_id, lage_faktor_einh_id, faktor_lag, hoehe, anzahl_lagen, pal_hoehe_cm_gerechnet,
vorholspedition_tms_gp_typ_cd, hoehe_stapelfaktor, gewicht_netto, gewicht_brutto, gewicht_brutto_gerechnet, menge_kolli
, menge_ist_bme, menge_pal) AS SELECT TMS_A.mandant_id,
 TMS_A.dat_lief,
 TMS_A.beladestelle_tms_gp_id,
 TMS_A.versender_tms_gp_id,
 TMS_A.system_id,
 GP.tms_gp_plz,
 TMS_A.empfaenger_tms_gp_id,
 LAG_WE.art_id,
 LAG_WE.handling_unit_id_nach,
 TMS_A.tms_auftrag_id,
 MAW1.lage_faktor_einh_id,
 COALESCE(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner, 1) AS faktor_lag,
  CASE
  WHEN COALESCE(MARM_LAG.hoehe, 0) > 0
  THEN MARM_LAG.hoehe
  WHEN COALESCE(MARM_KOLLI.hoehe, 0) > 0
  THEN MARM_KOLLI.hoehe
  ELSE COALESCE(MARM_WAUSM.hoehe, 0)
  END AS hoehe_,
  LAG_WE.menge_ist_bme / COALESCE(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner, 1) AS anzahl_lagen,
    LAG_WE.menge_ist_bme / COALESCE(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner, 1) * CASE
    WHEN COALESCE(MARM_LAG.hoehe, 0) > 0
    THEN MARM_LAG.hoehe
    WHEN COALESCE(MARM_KOLLI.hoehe, 0) > 0
    THEN MARM_KOLLI.hoehe
    ELSE COALESCE(MARM_WAUSM.hoehe, 0)
    END + 15 AS pal_hoehe_cm_gerechnet,
  CASE
  WHEN TMS_A.vorholspedition_tms_gp_typ_cd = 'S'
  THEN 'Quellgebiet'
  ELSE 'Direkt'
  END AS vorholspedition_tms_gp_typ_cd,
  CASE
  WHEN (LAG_WE.menge_ist_bme / COALESCE(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner, 1) * CASE
       WHEN COALESCE(MARM_LAG.hoehe, 0) > 0
       THEN MARM_LAG.hoehe
       WHEN COALESCE(MARM_KOLLI.hoehe, 0) > 0
       THEN MARM_KOLLI.hoehe
       ELSE COALESCE(MARM_WAUSM.hoehe, 0)
       END + 15) BETWEEN 0 AND 35.99
  THEN 5
  WHEN (LAG_WE.menge_ist_bme / COALESCE(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner, 1) * CASE
       WHEN COALESCE(MARM_LAG.hoehe, 0) > 0
       THEN MARM_LAG.hoehe
       WHEN COALESCE(MARM_KOLLI.hoehe, 0) > 0
       THEN MARM_KOLLI.hoehe
       ELSE COALESCE(MARM_WAUSM.hoehe, 0)
       END + 15) BETWEEN 36 AND 50.99
  THEN 4
  WHEN (LAG_WE.menge_ist_bme / COALESCE(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner, 1) * CASE
       WHEN COALESCE(MARM_LAG.hoehe, 0) > 0
       THEN MARM_LAG.hoehe
       WHEN COALESCE(MARM_KOLLI.hoehe, 0) > 0
       THEN MARM_KOLLI.hoehe
       ELSE COALESCE(MARM_WAUSM.hoehe, 0)
       END + 15) BETWEEN 51 AND 80.99
  THEN 3
  WHEN (LAG_WE.menge_ist_bme / COALESCE(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner, 1) * CASE
       WHEN COALESCE(MARM_LAG.hoehe, 0) > 0
       THEN MARM_LAG.hoehe
       WHEN COALESCE(MARM_KOLLI.hoehe, 0) > 0
       THEN MARM_KOLLI.hoehe
       ELSE COALESCE(MARM_WAUSM.hoehe, 0)
       END + 15) BETWEEN 81 AND 120.99
  THEN 2
  ELSE 1
  END AS hoehe_stapelfaktor,
 LAG_WE.gewicht_netto,
 LAG_WE.gewicht_brutto,
  670 / LAG_WE.gewicht_brutto AS gewicht_brutto_gerechnet,
 LAG_WE.menge_kolli,
 LAG_WE.menge_ist_bme,
 LAG_WE.menge_pal
FROM kfl_production_dbp_view.v_tms_auftrag AS TMS_A
 INNER JOIN kfl_production_dbp_view.v_tms_gp AS GP ON TMS_A.beladestelle_tms_gp_id = GP.tms_gp_id AND TMS_A.mandant_id =
    GP.mandant_id AND TMS_A.system_id = GP.system_id
 INNER JOIN kfl_production_dbp_msi_data.lageraufgabe_we AS LAG_WE ON TMS_A.tms_auftrag_id = LAG_WE.best_beleg_id AND
    TMS_A.mandant_id = LAG_WE.mandant_id AND LAG_WE.lagerprozessart_id = '0LUL'
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per AS MAW1 ON LAG_WE.art_id = MAW1.art_id AND LAG_WE.mandant_id
     = MAW1.mandant_id AND LAG_WE.dat_we BETWEEN MAW1.dat_von AND MAW1.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS MARM_LAG ON MARM_LAG.dat_bis = DATE '9999-12-31' AND
     MAW1.lage_faktor_einh_id = MARM_LAG.altnv_menge_einh_id AND MAW1.mandant_id = MARM_LAG.mandant_id AND MAW1.art_id =
   MARM_LAG.art_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS MARM_KOLLI ON MARM_KOLLI.dat_bis = DATE '9999-12-31'
    AND MAW1.zl_kolli_menge_einh_id = MARM_KOLLI.altnv_menge_einh_id AND MAW1.mandant_id = MARM_KOLLI.mandant_id AND
   MAW1.art_id = MARM_KOLLI.art_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS MARM_WAUSM ON MARM_WAUSM.dat_bis = DATE '9999-12-31'
    AND MAW1.ausg_menge_einh_id = MARM_WAUSM.altnv_menge_einh_id AND MAW1.mandant_id = MARM_WAUSM.mandant_id AND MAW1.art_id
    = MARM_WAUSM.art_id;