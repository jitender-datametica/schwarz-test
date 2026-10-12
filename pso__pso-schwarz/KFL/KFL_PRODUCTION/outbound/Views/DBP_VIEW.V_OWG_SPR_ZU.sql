CREATE OR REPLACE VIEW kfl_production_dbp_view.v_owg_spr_zu AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 owg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.owg_spr_zu;