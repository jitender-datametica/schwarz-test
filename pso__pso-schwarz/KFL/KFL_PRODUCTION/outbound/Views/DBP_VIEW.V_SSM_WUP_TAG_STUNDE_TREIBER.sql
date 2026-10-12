CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ssm_wup_tag_stunde_treiber AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 zeit_stunde,
 treiber_id,
 wrg_id,
 wert_tag,
 wert_stunde
FROM kfl_production_dbp_data.ssm_wup_tag_stunde_treiber;