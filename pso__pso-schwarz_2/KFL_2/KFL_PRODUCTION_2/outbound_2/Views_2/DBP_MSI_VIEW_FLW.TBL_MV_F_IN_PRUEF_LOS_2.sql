CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_in_pruef_los_2 (mandant_id, best_beleg_id,
best_beleg_pos_id, dat_buch, prueflos_id, werk_id, in_art_id, in_lief_id, herkunft, pruefart_id, anz_stp_merkmal,
anz_wert_ergebnis, wrg_id, default_wrg, betrag_lagerbew, vorzeichen, betrag_lagerbew_altnv, menge_lagerbew_bme,
basismenge_einh_id, altnv_menge_einh_id, umrech_faktor, best_menge_einh_id, preis_steuer_kz) AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V05.dat_buch,
 V01.prueflos_id,
 V01.werk_id,
 V01.flw_art_id AS in_art_id,
 V01.flw_lief_id AS in_lief_id,
 V01.herkunft,
 V01.pruefart_id,
 1 AS anz_stp_merkmal,
 1 AS anz_wert_ergebnis,
 V04.wrg_id,
 V100.default_wrg,
 V04.betrag_lagerbew,
  CASE
  WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
  THEN 1
  WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
     V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
  THEN - 1
  WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
  THEN 1
  WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
  THEN - 1
  WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
  THEN 1
  ELSE NULL
  END AS vorzeichen,
 V04.betrag_lagerbew_altnv,
 V04.menge_lagerbew_bme,
 V10.basismenge_einh_id,
 V11.altnv_menge_einh_id,
 V11.umrech_faktor,
 V03.best_menge_einh_id,
 V07.preis_steuer_kz
FROM kfl_production_dbp_view.v_flw_pruef_los_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best_det_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.best_beleg_id
     = V03.best_beleg_id AND V01.best_beleg_pos_id = V03.best_beleg_pos_id
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best_2 AS V03A ON V03.best_beleg_id = V03A.best_beleg_id AND V03.mandant_id
    = V03A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_det_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.best_beleg_id =
    V04.best_beleg_id AND V01.best_beleg_pos_id = V04.best_beleg_pos_id
 INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_2 AS V05 ON V04.mandant_id = V05.mandant_id AND V04.lagerbew_beleg_id =
     V05.lagerbew_beleg_id AND V04.kj = V05.kj AND V05.vorgangsart_id = 'WE'
 INNER JOIN kfl_production_dbp_view.v_flw_werk_2 AS V06 ON V04.werk_id = V06.werk_id AND V04.mandant_id = V06.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_bewertungskreis_per_2 AS V07 ON V04.mandant_id = V07.mandant_id AND V04.flw_art_id
      = V07.flw_art_id AND V06.werk_nr = V07.bewertungskreis_id AND V05.dat_buch BETWEEN V07.dat_von AND V07.dat_bis
 INNER JOIN kfl_production_dbp_view.v_flw_art_2 AS V10 ON V03.mandant_id = V10.mandant_id AND V03.flw_art_id = V10.flw_art_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_2 AS V11 ON V10.flw_art_id = V11.flw_art_id AND V10.mandant_id
     = V11.mandant_id AND V10.basismenge_einh_id = V11.altnv_menge_einh_id
WHERE V01.mandant_id IN (1, 2)
 AND V03A.einkaufsorganisation_id IN (5000, 5013, 5014);