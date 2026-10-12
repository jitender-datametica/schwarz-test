CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_absagegrund_spr_zu_1 AS SELECT absagegrund_id,
 mandant_id,
 spr_id,
 absagegrund_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_absagegrund_spr_zu_1;