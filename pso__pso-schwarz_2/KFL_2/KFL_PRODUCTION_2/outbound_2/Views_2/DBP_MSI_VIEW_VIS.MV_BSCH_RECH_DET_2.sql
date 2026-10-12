CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_bsch_rech_det_2 (mandant_id, nb_id, wup_id, dat, bsch_id,
bsch_pos_id, art_id, bewart_id, gp_id, ba_id, ba_pos_id, status_2, lager_bewart_id, lagerort_id, menge_rech, bsch_menge,
bsch_menge_ret) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.dat,
 V01.bsch_id,
 V01.bsch_pos_id,
 V01.art_id,
 V01.bewart_id,
 V01.gp_id,
 V01.ba_id,
 V01.ba_pos_id,
 V01.status_2,
 V01.lager_bewart_id,
 V01.lagerort_id,
 V01.menge_rech,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915)
  THEN V01.menge_rech
  ELSE NULL
  END AS bsch_menge,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916)
  THEN V01.menge_rech
  ELSE NULL
  END AS bsch_menge_ret
FROM kfl_production_dbp_view.v_bsch_rech_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
WHERE V01.nb_id = 0
 AND V01.status_2 <> 2;