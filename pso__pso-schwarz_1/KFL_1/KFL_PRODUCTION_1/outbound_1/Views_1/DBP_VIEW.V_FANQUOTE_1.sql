CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fanquote_1 AS SELECT mandant_id,
 matching_id,
 kjwo_update,
 d423_fanquote,
 a507_umsatz_cardholder,
 a508_anteil_sa_cardholder,
 a509_anz_kaeufer,
 substitute_matching_id
FROM kfl_production_dbp_data.fanquote_1;