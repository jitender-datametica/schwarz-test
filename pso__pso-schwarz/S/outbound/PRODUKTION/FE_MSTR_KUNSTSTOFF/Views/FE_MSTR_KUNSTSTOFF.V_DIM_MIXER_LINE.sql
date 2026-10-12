CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_mixer_line (resource_item_sid,
production_line_resource_item_sid, mixer_line_cd, mixer_line_name) AS SELECT MIX1.mixer_line_cd AS resource_item_sid,
 PRL1.production_line_id AS production_line_resource_item_sid,
 MIX1.mixer_line_cd,
 MIX1.mixer_line_name
FROM produktion_core.t_dim_mixer_line AS MIX1
 INNER JOIN produktion_core.t_dim_production_line AS PRL1 ON MIX1.production_line_resource_item_sid = PRL1.resource_item_sid;