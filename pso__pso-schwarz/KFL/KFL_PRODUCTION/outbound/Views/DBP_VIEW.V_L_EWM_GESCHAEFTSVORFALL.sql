CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ewm_geschaeftsvorfall AS SELECT mandant_id,
 lagernummer_id,
 ewm_gv_id,
 ewm_gv_grp_id,
 gv_einheit_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_ewm_geschaeftsvorfall;