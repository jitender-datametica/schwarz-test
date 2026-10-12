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


CREATE TABLE p_lew_mart_cs.t_l_item_wh
 (
        client_id SMALLINT NOT NULL
      , item_id NUMBER(38) NOT NULL
      , wh_id NUMBER(38) NOT NULL
      , valid_from DATE NOT NULL
      , valid_until DATE NOT NULL
      , itemstatus_cd NUMBER(38)
      , case_factor_dd SMALLINT
      , case_factor_euro SMALLINT
      , case_factor_layer SMALLINT
      , min_case_dd_wh SMALLINT
      , min_case_euro_wh SMALLINT
      , min_case_layer_wh SMALLINT
      , min_case_wh SMALLINT
      , min_orderunit SMALLINT
      , order_area_cd VARCHAR(10) COLLATE 'en-ci'
      , last_refresh TIMESTAMP_NTZ(9)
      , src_id NUMBER(38)
      , load_id NUMBER(38)
      , UNIQUE ( client_id ,item_id ,wh_id )
 );