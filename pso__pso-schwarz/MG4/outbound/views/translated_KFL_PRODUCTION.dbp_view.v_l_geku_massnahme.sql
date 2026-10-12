CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_massnahme (geku_massnahme_uid, geku_massnahme_id, td_update,
td_insert) AS SELECT *
FROM kfl_production_dbp_data.l_geku_massnahme;