CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ausgeber (mandant_id, ausgeber_typ_id, ausgeber_id) AS SELECT
 mandant_id,
 ausgeber_typ_id,
 ausgeber_id
FROM kfl_production_dbp_data.l_ausgeber;