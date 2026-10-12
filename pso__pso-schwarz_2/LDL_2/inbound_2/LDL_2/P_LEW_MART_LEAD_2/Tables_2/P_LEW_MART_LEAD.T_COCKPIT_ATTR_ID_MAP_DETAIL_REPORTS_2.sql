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


CREATE TABLE P_LEW_MART_LEAD.t_cockpit_attr_id_map_detail_reports_2
(
  cockpit VARCHAR(50)              ,
  dim VARCHAR(20)                  ,
  LEVEL VARCHAR(10)                ,
  id  NUMBER(4)                    ,
  key_id NUMBER(4)                 ,
  key_desc VARCHAR(100)            ,
  level_fg NUMBER(4)               ,
  link VARCHAR(1000)               ,
  NAME VARCHAR(20)                 ,
  process_id NUMBER(4)             ,
  process_desc_short VARCHAR(10)   ,
  process_desc VARCHAR(30)         ,
  TIME VARCHAR(10)    
) COMMENT = 'Cockpit 2.0 attribures - detail reports (Detailberichte)'      
;                                                 
