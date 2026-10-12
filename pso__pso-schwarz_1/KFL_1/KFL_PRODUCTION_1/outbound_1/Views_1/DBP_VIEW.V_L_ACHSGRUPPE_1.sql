CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_achsgruppe_1 AS SELECT mandant_id,
 achsgruppe_id,
 produktgruppe_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_achsgruppe_1;