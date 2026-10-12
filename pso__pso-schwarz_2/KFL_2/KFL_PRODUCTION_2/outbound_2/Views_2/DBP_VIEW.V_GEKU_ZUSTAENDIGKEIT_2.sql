CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_zustaendigkeit_2 AS SELECT kundenfaktor_id,
 geku_dwh_artikel_id,
 zustaendigkeit,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_zustaendigkeit_2;