CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_lagerbew_det_2 (lagerbew_beleg_id, lagerbew_beleg_pos_id,
mandant_id, kj, wup_id, nb_id, in_kunde_id, dat_buch, art_id, in_art_id, lager_bewart_id, menge_lagerbew_bme,
menge_lagerbew_kg, wrg_id, default_wrg, betrag_vk_netto, mwst) AS SELECT V01.lagerbew_beleg_id,
 V01.lagerbew_beleg_pos_id,
 V01.mandant_id,
 V01.kj,
 V01.wup_id,
 V01.nb_id,
 V07.flw_kunde_id AS in_kunde_id,
 V01.dat_buch,
 V01.art_id,
 V05.flw_art_id AS in_art_id,
 V01.lager_bewart_id,
 V01.menge_lagerbew_bme,
  CASE
  WHEN V05.basismenge_einh_id = 'KG'
  THEN V01.menge_lagerbew_bme
  WHEN V05.basismenge_einh_id = 'ST' AND V05.flw_art_id >= 0
  THEN ROUND(CAST(V01.menge_lagerbew_bme * V08.umrech_faktor AS NUMERIC), 6)
  WHEN V05.basismenge_einh_id = 'ST' AND V05.flw_art_id < 0
  THEN ROUND(CAST(V01.menge_lagerbew_bme * V09.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_lagerbew_kg,
 V01.wrg_id,
 V100.default_wrg,
 V01.betrag_vk_netto,
 V06.mwst
FROM kfl_production_dbp_view.v_lagerbew_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND V01
   .dat_buch BETWEEN V04.dat_von AND V04.dat_bis
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art_2 AS V05 ON V04.art_id = V05.art_id AND V04.mandant_id = V05.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_mwst_per_2 AS V06 ON V04.mwst_id = V06.mwst_id AND V04.mandant_id = V06.mandant_id
  AND V01.dat_buch BETWEEN V06.dat_von AND V06.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_2 AS V07 ON V01.wup_id = V07.wup_id AND V01.mandant_id = V07.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_2 AS V08 ON V05.flw_art_id = V08.flw_art_id AND V05.mandant_id
     = V08.mandant_id AND CASE
    WHEN V05.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V05.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V08.altnv_menge_einh_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS V09 ON V05.mandant_id = V09.mandant_id AND V05.art_id
     = V09.art_id AND CASE
     WHEN V05.basismenge_einh_id = 'ST'
     THEN 'KG'
     WHEN V05.basismenge_einh_id = 'KG'
     THEN 'ST'
     ELSE NULL
     END = V09.altnv_menge_einh_id AND V09.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.mandant_id IN (1, 2);