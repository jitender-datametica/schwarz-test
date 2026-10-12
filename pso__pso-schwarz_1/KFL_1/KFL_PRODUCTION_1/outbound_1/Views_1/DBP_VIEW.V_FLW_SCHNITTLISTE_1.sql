CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_schnittliste_1 AS SELECT mandant_id,
 schnittliste_id,
 sek_schl_id,
 sek_schl_typ_id,
 flw_art_id,
 werk_id,
 schnittliste_variante,
 dat_von,
 dat_bis,
 system_id
FROM kfl_production_dbp_data.flw_schnittliste_1;