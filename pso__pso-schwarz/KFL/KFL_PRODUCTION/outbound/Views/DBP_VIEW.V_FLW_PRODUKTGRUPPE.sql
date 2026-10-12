CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_produktgruppe AS SELECT mandant_id,
 produktgruppe_id,
 hauptgruppe_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_produktgruppe;