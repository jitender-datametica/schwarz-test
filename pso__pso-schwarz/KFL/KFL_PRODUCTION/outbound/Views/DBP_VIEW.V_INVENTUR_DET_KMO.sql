CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_det_kmo AS SELECT mandant_id,
 wup_id,
 nb_id,
 zeitpunkt_inv,
 art_id,
 wrg_id,
 menge_inv,
 bestand_wert,
 wert_eingabe
FROM kfl_production_dbp_data.inventur_det_kmo;