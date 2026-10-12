CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_request_type_spr_zu_1 (request_type_id, mandant_id, spr_id,
request_type_descr) AS SELECT request_type_id,
 mandant_id,
 spr_id,
 request_type_descr
FROM kfl_production_dbp_data.aad_request_type_spr_zu_1;