CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_ocr_eingangskanal_2 (mandant_id, ocr_eingangskanal_id) AS
SELECT mandant_id,
 ocr_eingangskanal_id
FROM kfl_production_dbp_view.v_l_ocr_eingangskanal_2
WHERE mandant_id = 1;