CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_hauptgruppe_spr_zu_1 AS SELECT mandant_id,
 hauptgruppe_id,
 spr_id,
 system_id,
 hauptgruppe_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_hauptgruppe_spr_zu_1;