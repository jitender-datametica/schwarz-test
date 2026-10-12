/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_ref_hier_cockpit_2_0_1
#----------------------------------------------------------------------------
# History:
#  1.0    2023-11-07         Marcin Malec              Initial version.
#                                                      AP0192327; User Story 545446: [BE] - new tabel for security - Cockpit 2.0 | Navigation (BBT-6746)
#  1.1    2024-10-23         Marcin Malec              Adding column new_fg; AP0229386; User Story 688636: [BE] - Cockpit Redesign | Neue Komponenten - Implementation navigation table
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_hier_cockpit_2_0_1 (
group_id NUMERIC(4),
group_desc STRING(20),
cockpit_type_id NUMERIC(4),
cockpit_type_desc STRING(50),
cockpit_id NUMERIC(4),
cockpit_desc STRING(50),
new_fg NUMERIC(1),
cockpit_url STRING(200),
url_web STRING(200)
) OPTIONS(description='Cockpit 2.0 security table');