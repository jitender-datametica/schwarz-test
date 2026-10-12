CREATE OR REPLACE VIEW kfl_production_dbp_view.v_abschriftart_spr_zu AS SELECT mandant_id,
 abschriftart_id,
 spr_id,
 abschriftart_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.abschriftart_spr_zu;