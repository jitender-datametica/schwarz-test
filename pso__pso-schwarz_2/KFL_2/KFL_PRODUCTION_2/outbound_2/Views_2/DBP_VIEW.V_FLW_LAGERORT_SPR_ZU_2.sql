CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_lagerort_spr_zu_2 AS SELECT mandant_id,
 werk_id,
 lagerort_id,
 spr_id,
 lagerort_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_lagerort_spr_zu_2;