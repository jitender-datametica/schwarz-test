CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_kosten_prognose AS SELECT mandant_id,
 in_projekt_id,
 psp_id,
 in_wg_id,
 kosten_prognose_version_id,
 betrag_kosten_prognose,
 betrag_mmk_prognose,
 betrag_zea_prognose,
 wrg_id,
 dat_kosten_prognose_version
FROM kfl_production_dbp_data.in_kosten_prognose;