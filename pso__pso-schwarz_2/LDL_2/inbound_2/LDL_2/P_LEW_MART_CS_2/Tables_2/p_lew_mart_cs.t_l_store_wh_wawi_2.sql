/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            23.09.2021        Ulrich Roß               checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE TABLE p_lew_mart_cs.t_l_store_wh_wawi_2
  (
    client_id SMALLINT NOT NULL,
    store_id NUMBER(38) NOT NULL,
    wh_id NUMBER(38) NOT NULL,
    valid_from DATE NOT NULL,
    valid_until DATE NOT NULL,
    dwh_type_constant SMALLINT NOT NULL,
    last_refresh TIMESTAMP_NTZ(9),
    src_id NUMBER(38),
    load_id NUMBER(38),
    UNIQUE ( client_id ,store_id ,valid_from ,dwh_type_constant )
  );