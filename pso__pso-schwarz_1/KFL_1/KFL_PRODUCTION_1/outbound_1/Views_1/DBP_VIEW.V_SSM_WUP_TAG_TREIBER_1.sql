CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ssm_wup_tag_treiber_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 treiber_id,
 wrg_id,
 wert_tag
FROM kfl_production_dbp_data.ssm_wup_tag_treiber_1;