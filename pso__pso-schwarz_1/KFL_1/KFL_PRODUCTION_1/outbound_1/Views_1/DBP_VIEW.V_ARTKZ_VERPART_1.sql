CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_verpart_1 AS SELECT verpart_id,
 mandant_id,
 spr_id,
 verpart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.artkz_verpart_1;