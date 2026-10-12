CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artikelart_spr_zu_1 AS SELECT mandant_id,
 artikelart_id,
 spr_id,
 artikelart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.artikelart_spr_zu_1;