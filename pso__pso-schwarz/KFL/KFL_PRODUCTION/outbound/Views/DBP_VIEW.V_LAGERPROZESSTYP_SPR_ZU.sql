CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagerprozesstyp_spr_zu AS SELECT lagerprozesstyp_id,
 spr_id,
 lagerprozesstyp_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lagerprozesstyp_spr_zu;