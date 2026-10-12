CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kl_uwg_market_cluster_kjmo_sum_1 AS SELECT mandant_id,
 kl_uwg_id,
 kjmo,
 nielsen_market_cluster_id,
 umsatz_brutto,
 anz_artikel,
 ek_mep
FROM kfl_production_dbp_data.kl_uwg_market_cluster_kjmo_sum_1;