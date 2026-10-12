/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_cockpit_attr_id_map_detail_reports_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_cockpit_attr_id_map_detail_reports_2 (
cockpit STRING(50),
dim STRING(20),
level STRING(10),
id NUMERIC(4),
key_id NUMERIC(4),
key_desc STRING(100),
level_fg NUMERIC(4),
link STRING(1000),
name STRING(20),
process_id NUMERIC(4),
process_desc_short STRING(10),
process_desc STRING(30),
time STRING(10)
) OPTIONS(description='Cockpit 2.0 attribures - detail reports (Detailberichte)');