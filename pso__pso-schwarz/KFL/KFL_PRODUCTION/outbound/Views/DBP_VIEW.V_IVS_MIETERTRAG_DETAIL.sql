CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_mietertrag_detail AS SELECT debitor_id,
 sachkonto_id,
 mandant_id,
 kjmo,
 immo_objekt_id,
 belegart_id,
 konto_betrag,
 wrg_id
FROM kfl_production_dbp_data.ivs_mietertrag_detail;