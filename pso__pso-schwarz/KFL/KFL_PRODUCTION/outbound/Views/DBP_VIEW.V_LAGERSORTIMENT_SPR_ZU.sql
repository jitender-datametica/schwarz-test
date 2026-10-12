CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagersortiment_spr_zu AS SELECT mandant_id,
 lagernummer_id,
 lagersortiment_id,
 spr_id,
 wup_id,
 nb_id,
 lagersortiment_bez
FROM kfl_production_dbp_data.lagersortiment_spr_zu;