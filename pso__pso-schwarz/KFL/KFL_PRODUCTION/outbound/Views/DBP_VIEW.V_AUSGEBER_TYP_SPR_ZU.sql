CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ausgeber_typ_spr_zu AS SELECT mandant_id,
 ausgeber_typ_id,
 spr_id,
 ausgeber_typ_bez
FROM kfl_production_dbp_data.ausgeber_typ_spr_zu;