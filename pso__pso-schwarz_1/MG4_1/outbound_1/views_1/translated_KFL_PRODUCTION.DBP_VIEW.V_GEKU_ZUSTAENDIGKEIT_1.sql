CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_zustaendigkeit_1 (kundenfaktor_id, geku_dwh_artikel_id,
zustaendigkeit, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.geku_zustaendigkeit_1;