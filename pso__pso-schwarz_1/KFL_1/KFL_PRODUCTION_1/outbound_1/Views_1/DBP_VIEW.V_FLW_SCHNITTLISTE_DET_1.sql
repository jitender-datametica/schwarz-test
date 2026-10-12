CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_schnittliste_det_1 AS SELECT schnittliste_id,
 schnitt_id,
 sek_schl_typ_id,
 sek_schl_id,
 mandant_id,
 schnitt_verwendung_prozent,
 flw_art_id,
 system_id,
 menge,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_schnittliste_det_1;