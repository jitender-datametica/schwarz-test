CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lieferverzogerungen_report_2 AS SELECT DISTINCT V01.empfaenger_wup_id
 ,
 V01.anz_pos_aktiv,
 V01.mandant_id,
  CASE
  WHEN V01.empfaenger_wup_id IS NOT NULL
  THEN CAST(- 111 AS BIGNUMERIC)
  ELSE NULL
  END AS nb_id,
 V01.gp_id,
 V01.dat_best_beleg,
 V01.bestellart_id,
 V01.best_beleg_id,
 V04.tour_id
FROM kfl_production_dbp_view.v_besch_best_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_best_det_2 AS V02 ON V01.best_beleg_id = V02.best_beleg_id AND V01.dat_best_beleg
     = V02.dat_best_beleg AND V01.mandant_id = V02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_besch_bestaetigung_2 AS V03 ON V02.best_beleg_id = V03.best_beleg_id AND V02.best_beleg_pos_id
     = V03.best_beleg_pos_id AND V02.mandant_id = V03.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_tour_det_2 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.lief_beleg_id = V04.lief_beleg_id
     AND V03.kj_lief_beleg = V04.kj_lief_beleg
WHERE V01.einkaufsorganisation_id <> 5000
 AND V02.loesch_fg = 0
 AND V01.loesch_fg = 0;