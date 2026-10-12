/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_id_map_detail_reports_1
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_id_map_detail_reports_1
(
  cockpit
, dim
, LEVEL
, id 
, key_id
, key_desc
, level_fg
, link
, NAME
, process_id
, process_desc_short
, process_desc
, TIME  
)
AS
SELECT
  cockpit
, dim
, LEVEL
, id 
, key_id
, key_desc
, level_fg
, link
, NAME
, process_id
, process_desc_short
, process_desc
, TIME  
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map_detail_reports_1
;
