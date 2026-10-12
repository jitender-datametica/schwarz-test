CREATE OR REPLACE VIEW kfl_production_dbp_view.v_faktura_status_spr_zu_1 AS SELECT mandant_id,
 faktura_status_id,
 spr_id,
 faktura_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.faktura_status_spr_zu_1;