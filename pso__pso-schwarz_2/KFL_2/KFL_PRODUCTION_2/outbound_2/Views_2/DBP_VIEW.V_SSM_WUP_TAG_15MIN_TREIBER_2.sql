CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ssm_wup_tag_15min_treiber_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 zeit_stunde,
 zeit_15min,
 treiber_id,
 wrg_id,
 wert_15min
FROM kfl_production_dbp_data.ssm_wup_tag_15min_treiber_2;