/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_lago_item_sub_actiongroup_2
#----------------------------------------------------------------------------
# History:
#   1.0            18.06.2021        Ulrich Ross              checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE TABLE p_lew_mart_cs.t_lago_item_sub_actiongroup_2
      (
        client_id NUMBER(38) NOT NULL,
        item_actiongroup_id NUMBER(38) NOT NULL,
        item_sub_actiongroup_id NUMBER(38) NOT NULL,
        valid_from DATE NOT NULL,
        valid_until DATE NOT NULL,
        item_actiongroup_descr VARCHAR(200) COLLATE 'en-ci',
        item_sub_actiongroup_descr VARCHAR(200) COLLATE 'en-ci',
        language_id NUMBER(38) NOT NULL,
        last_refresh TIMESTAMP_NTZ(9) NOT NULL,
        cs_updated TIMESTAMP_NTZ(9) NOT NULL,
        cs_created TIMESTAMP_NTZ(9) NOT NULL,
        cs_load_id NUMBER(38) NOT NULL
      )
      ;