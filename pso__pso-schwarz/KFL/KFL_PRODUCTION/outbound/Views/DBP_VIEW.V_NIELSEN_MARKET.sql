CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nielsen_market AS SELECT mandant_id,
 nielsen_market_id,
 nielsen_market_tag,
 nielsen_market_bez,
 nielsen_market_cluster_id
FROM kfl_production_dbp_data.nielsen_market;