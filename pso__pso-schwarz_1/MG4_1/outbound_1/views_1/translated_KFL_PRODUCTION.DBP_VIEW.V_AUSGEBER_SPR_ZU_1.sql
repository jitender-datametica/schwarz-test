CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ausgeber_spr_zu_1 (spr_id, mandant_id, ausgeber_typ_id, ausgeber_id,
ausgeber_bez) AS SELECT spr_id,
 mandant_id,
 ausgeber_typ_id,
 ausgeber_id,
 ausgeber_bez
FROM kfl_production_dbp_data.ausgeber_spr_zu_1;