/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_id_map_detail_reports
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_id_map_detail_reports (cockpit, dim, level, id, key_id,
key_desc, level_fg, link, name, process_id, process_desc_short, process_desc, time) AS SELECT cockpit,
 dim,
 level,
 id,
 key_id,
 key_desc,
 level_fg,
 link,
 name,
 process_id,
 process_desc_short,
 process_desc,
 time
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_detail_reports;