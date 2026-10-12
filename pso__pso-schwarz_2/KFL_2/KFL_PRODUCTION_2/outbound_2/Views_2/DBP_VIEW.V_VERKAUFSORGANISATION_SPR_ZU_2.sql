CREATE OR REPLACE VIEW kfl_production_dbp_view.v_verkaufsorganisation_spr_zu_2 AS SELECT mandant_id,
 verkaufsorganisation_id,
 spr_id,
 verkaufsorganisation_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.verkaufsorganisation_spr_zu_2;