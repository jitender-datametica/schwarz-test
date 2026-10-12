CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagernummer_spr_zu AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 spr_id,
 lagernummer_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lagernummer_spr_zu;