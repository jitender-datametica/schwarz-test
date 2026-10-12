CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbeware_1 AS SELECT mandant_id,
 werbeware_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_werbeware_1;