/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_lago_packagetype
#----------------------------------------------------------------------------
# History:
#   1.0            18.06.2021        Ulrich Ross              checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE TABLE p_lew_mart_cs.t_lago_packagetype
      (
        client_id NUMBER(38) NOT NULL,
        packagetype_skey VARCHAR(20) COLLATE 'en-ci',
        language_id NUMBER(38) NOT NULL,
        valid_from DATE NOT NULL,
        valid_until DATE NOT NULL,
        descr VARCHAR(200) COLLATE 'en-ci',
        last_refresh TIMESTAMP_NTZ(9) NOT NULL,
        cs_updated TIMESTAMP_NTZ(9) NOT NULL,
        cs_created TIMESTAMP_NTZ(9) NOT NULL,
        cs_load_id NUMBER(38) NOT NULL
      )
      ;