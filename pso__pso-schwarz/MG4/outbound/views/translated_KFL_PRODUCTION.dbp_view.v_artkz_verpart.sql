CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_verpart (verpart_id, mandant_id, spr_id, verpart_bez, td_update,
td_insert) AS SELECT *
FROM kfl_production_dbp_data.artkz_verpart;