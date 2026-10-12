CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_konzessionaer_umsatz_1 AS SELECT mandant_id,
 konzessionaer_id,
 immo_objekt_id,
 mietvertrag_id,
 kjmo,
 betrag_umsatz,
 wrg_id,
 system_id,
 buchungskreis_id
FROM kfl_production_dbp_data.ivs_konzessionaer_umsatz_1;