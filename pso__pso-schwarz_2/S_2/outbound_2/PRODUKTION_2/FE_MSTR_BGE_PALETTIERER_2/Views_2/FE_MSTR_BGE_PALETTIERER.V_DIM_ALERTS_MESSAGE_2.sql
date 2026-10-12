CREATE OR REPLACE VIEW produktion_fe_mstr_bge_palettierer.v_dim_alerts_message_2 AS SELECT alerts_message_id,
 alerts_location_id,
 alerts_priority_id,
 alerts_type_id,
 alerts_message_desc,
 alerts_message_desc_de
FROM produktion_core.t_dim_alerts_message_2;