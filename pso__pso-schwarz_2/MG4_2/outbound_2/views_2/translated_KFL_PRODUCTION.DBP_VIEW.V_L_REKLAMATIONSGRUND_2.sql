CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_reklamationsgrund_2 (mandant_id, reklamationsgrund_id) AS SELECT
 mandant_id,
 reklamationsgrund_id
FROM kfl_production_dbp_data.l_reklamationsgrund_2;