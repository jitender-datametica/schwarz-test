CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_discount_1 (discount_id, mandant_id, spr_id, discount_bez,
td_insert, td_update) AS SELECT discount_id,
 mandant_id,
 spr_id,
 discount_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.artkz_discount_1;