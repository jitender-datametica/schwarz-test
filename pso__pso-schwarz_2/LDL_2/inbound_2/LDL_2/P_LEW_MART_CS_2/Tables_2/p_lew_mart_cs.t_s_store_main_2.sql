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


CREATE TABLE p_lew_mart_cs.t_s_store_main_2
     (
        client_id SMALLINT NOT NULL
      , store_id NUMBER(38) NOT NULL
      , valid_from DATE  NOT NULL
      , valid_until DATE  NOT NULL
      , orig_store_nr NUMBER(38)
      , object_nr VARCHAR(10) COLLATE 'en-ci'
      , real_opening_date DATE 
      , opening DATE 
      , closing DATE 
      , opening_ovis DATE 
      , closing_ovis DATE 
      , store_descr VARCHAR(100) COLLATE 'en-ci'
      , is_test_store SMALLINT
      , is_closed SMALLINT
      , mde_print_cd SMALLINT
      , mde_lang_cd SMALLINT
      , street VARCHAR(140) COLLATE 'en-ci'
      , zipcode VARCHAR(30) COLLATE 'en-ci'
      , city VARCHAR(100) COLLATE 'en-ci'
      , phone VARCHAR(100) COLLATE 'en-ci'
      , fax VARCHAR(70) COLLATE 'en-ci'
      , zipcode_postbox VARCHAR(30) COLLATE 'en-ci'
      , postbox VARCHAR(100) COLLATE 'en-ci'
      , store_valid_from DATE 
      , open_time_mo VARCHAR(50) COLLATE 'en-ci'
      , open_time_tu VARCHAR(50) COLLATE 'en-ci'
      , open_time_we VARCHAR(50) COLLATE 'en-ci'
      , open_time_th VARCHAR(50) COLLATE 'en-ci'
      , open_time_fr VARCHAR(50) COLLATE 'en-ci'
      , open_time_sa VARCHAR(50) COLLATE 'en-ci'
      , open_time_su VARCHAR(50) COLLATE 'en-ci'
      , default_min_qty CHAR(2) COLLATE 'en-ci'
      , default_order_unit VARCHAR(10) COLLATE 'en-ci'
      , license_nr VARCHAR(20) COLLATE 'en-ci'
      , region_cd SMALLINT
      , language_id SMALLINT
      , last_refresh TIMESTAMP_NTZ(9)
      , src_id NUMBER(38)
      , load_id NUMBER(38)
      , UNIQUE ( client_id ,store_id ,valid_from )
     );