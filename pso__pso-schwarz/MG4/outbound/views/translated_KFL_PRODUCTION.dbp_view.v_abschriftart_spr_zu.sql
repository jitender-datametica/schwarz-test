CREATE OR REPLACE VIEW kfl_production_dbp_view.v_abschriftart_spr_zu (mandant_id, abschriftart_id, spr_id,
abschriftart_bez, td_insert, td_update) AS SELECT *
FROM kfl_production_dbp_data.abschriftart_spr_zu;