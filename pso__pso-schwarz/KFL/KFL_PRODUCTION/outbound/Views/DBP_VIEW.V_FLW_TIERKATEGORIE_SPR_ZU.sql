CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_tierkategorie_spr_zu AS SELECT mandant_id,
 werk_id,
 tierkategorie_id,
 spr_id,
 tierkategorie_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_tierkategorie_spr_zu;