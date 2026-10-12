CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ocr_eingangskanal_1 (mandant_id, ocr_eingangskanal_id) AS SELECT
 mandant_id,
 ocr_eingangskanal_id
FROM kfl_production_dbp_data.l_ocr_eingangskanal_1;