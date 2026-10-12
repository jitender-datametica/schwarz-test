CREATE OR REPLACE VIEW kfl_production_dbp_view.v_iwt_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 iwt_id,
 iwt_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.iwt_spr_zu_1;