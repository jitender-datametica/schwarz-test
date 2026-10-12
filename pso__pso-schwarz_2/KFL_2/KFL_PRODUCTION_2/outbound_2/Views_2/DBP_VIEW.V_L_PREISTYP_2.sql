CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_preistyp_2 AS SELECT preistyp_id,
 mandant_id,
 spr_id,
 preistyp_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_preistyp_2;