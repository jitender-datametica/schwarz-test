/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_2_0_1
#----------------------------------------------------------------------------
# History:
#  1.0    2023-11-07         Marcin Malec              Initial version.
#                                                      AP0192327; User Story 545446: [BE] - new tabel for security - Cockpit 2.0 | Navigation (BBT-6746)
#  1.1    2024-10-23         Marcin Malec              Adding column new_fg; AP0229386; User Story 688636: [BE] - Cockpit Redesign | Neue Komponenten - Implementation navigation table
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_2_0_1 
(
  group_id
, group_desc
, cockpit_type_id
, cockpit_type_desc
, cockpit_id
, cockpit_desc
, new_fg
, cockpit_url
, url_web
)
AS
SELECT
  group_id
, group_desc
, cockpit_type_id
, cockpit_type_desc
, cockpit_id
, cockpit_desc
, new_fg
, cockpit_url
, url_web
FROM P_LEW_MART_LEAD.t_ref_hier_cockpit_2_0_1
;
