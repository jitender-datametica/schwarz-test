CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_in_besch_best_det (mandant_id, best_beleg_id,
best_beleg_pos_id, in_art_id, loesch_id, werk_id, menge_best_bme, best_menge_einh_id, retourenpos_fg, dupli_fg,
besch_pos_typ_id, nettopreis) AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.flw_art_id AS in_art_id,
 V01.loesch_id,
 V01.werk_id,
 V01.menge_best_bme,
 V01.best_menge_einh_id,
 V01.retourenpos_fg,
 V01.dupli_fg,
 V01.besch_pos_typ_id,
 V01.nettopreis
FROM kfl_production_dbp_view.v_flw_besch_best_det AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best AS V02 ON V01.best_beleg_id = V02.best_beleg_id AND V01.mandant_id
   = V02.mandant_id
WHERE V02.einkaufsorganisation_id IN (5000, 5013, 5014);