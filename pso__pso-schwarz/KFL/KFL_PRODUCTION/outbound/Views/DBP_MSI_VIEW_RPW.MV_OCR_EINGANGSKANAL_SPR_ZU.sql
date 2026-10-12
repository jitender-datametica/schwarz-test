CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_ocr_eingangskanal_spr_zu (mandant_id, ocr_eingangskanal_id,
ocr_eingangskanal_bez) AS SELECT mandant_id,
 ocr_eingangskanal_id,
 ocr_eingangskanal_bez
FROM kfl_production_dbp_view.v_ocr_eingangskanal_spr_zu
WHERE spr_id = 22
 AND mandant_id = 1;