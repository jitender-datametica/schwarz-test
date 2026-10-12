CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geschaeftsvorfall AS SELECT mandant_id,
 geschaeftsvorfall_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geschaeftsvorfall;