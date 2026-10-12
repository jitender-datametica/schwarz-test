/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_ref_hier_cockpit_2_0_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-11-07         Marcin Malec              Initial version.
#                                                      AP0192327; User Story 545446: [BE] - new tabel for security - Cockpit 2.0 | Navigation (BBT-6746)
#  1.1    2024-10-23         Marcin Malec              Adding column new_fg; AP0229386; User Story 688636: [BE] - Cockpit Redesign | Neue Komponenten - Implementation navigation table
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.t_ref_hier_cockpit_2_0_2 
(
    group_id NUMBER(4),
    group_desc VARCHAR(20),
    cockpit_type_id NUMBER(4),
    cockpit_type_desc VARCHAR(50),
    cockpit_id NUMBER(4),
    cockpit_desc VARCHAR(50),
    new_fg NUMBER(1),
    cockpit_url VARCHAR(200),
    url_web VARCHAR(200)
) COMMENT = 'Cockpit 2.0 security table'      
;                                                 
