CREATE OR REPLACE VIEW kfl_production_dbp_view.v_regio_art_gp_wup_zu AS SELECT mandant_id,
 regio_stufe_id,
 gp_id,
 art_id,
 wup_id,
 nb_id,
 regio_polygon_id,
 versendet_fg,
 loesch_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.regio_art_gp_wup_zu;