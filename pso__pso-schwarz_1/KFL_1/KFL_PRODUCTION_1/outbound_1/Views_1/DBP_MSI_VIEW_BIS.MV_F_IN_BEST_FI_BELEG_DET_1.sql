CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_best_fi_beleg_det_1 AS SELECT V01.mandant_id,
 V01.in_fi_beleg_id,
 V01.in_fi_beleg_pos_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.dat_buch,
 V01.bsak_bschl_id,
 V01.bseg_bschl_id,
 V01.ind_vz,
 V01.bestell_menge_fi_beleg,
 V01.in_art_id,
 V01.in_lief_id,
 V01.werk_id,
 V01.rech_werk_id,
 V01.rech_in_art_id,
 V01.bestellart_id,
 V01.rech_plan_id,
 V01.endrech_fg,
 V01.einkaufsorganisation_id,
 V01.buchungskreis_id,
 V01.dat_von_rb,
  CASE
  WHEN V04.wrg_typ_id = 1
  THEN V01.betrag_fi_beleg * V01.ind_vz
  ELSE V01.betrag_fi_beleg * V01.ind_vz * V01.umrechnungskurs
  END AS bestell_betrag_fi_beleg
FROM kfl_production_dbp_msi_view_bis.tbl_mv_f_in_best_fi_beleg_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V04 ON TRUE;