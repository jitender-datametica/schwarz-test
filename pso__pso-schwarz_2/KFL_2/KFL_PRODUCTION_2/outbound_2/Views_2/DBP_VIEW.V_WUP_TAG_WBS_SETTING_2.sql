CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_tag_wbs_setting_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 non_adjustable_day_fg
FROM kfl_production_dbp_data.wup_tag_wbs_setting_2;