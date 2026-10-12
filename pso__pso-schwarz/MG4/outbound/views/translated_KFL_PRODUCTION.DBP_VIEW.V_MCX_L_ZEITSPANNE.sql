CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_l_zeitspanne (zeitspanne_id, zeitspanne_sort_key, td_update,
td_insert) AS SELECT *
FROM kfl_production_dbp_data.mcx_l_zeitspanne;