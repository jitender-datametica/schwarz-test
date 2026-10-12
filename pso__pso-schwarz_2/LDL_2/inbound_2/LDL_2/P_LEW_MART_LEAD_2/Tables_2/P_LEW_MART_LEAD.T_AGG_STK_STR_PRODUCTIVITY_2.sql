/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_agg_stk_str_productivity_2
#----------------------------------------------------------------------------
# History:
#  1.0    2021-07-10         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.t_agg_stk_str_productivity_2 CLUSTER BY (client_id, cy_month) 
(
      client_id NUMBER                             COMMENT 'MIS Client ID'                                     ,
      loc_sid_store_move_to NUMBER                 COMMENT 'enthält surrogate Key des Stores moved'            ,
      currency_iso_cd VARCHAR(3) COLLATE 'en-ci'   COMMENT 'Währung ISO Code'                                  ,
      cy_week_partial_week_id NUMBER               COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'      ,
      cy_month NUMBER                              COMMENT 'Geschäftsjahr'                                     ,
      busyear NUMBER                               COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'           ,
      stk_str_prod_wday1 NUMBER(38,8)              COMMENT 'Stueckleistung am ersten Tag_2 der Woche_2'            ,
      stk_str_prod_wday2 NUMBER(38,8)              COMMENT 'Stueckleistung am zweiten Tag_2 der Woche_2'           ,
      stk_str_prod_wday3 NUMBER(38,8)              COMMENT 'Stueckleistung am dritten Tag_2 der Woche_2'           ,
      stk_str_prod_wday4 NUMBER(38,8)              COMMENT 'Stueckleistung am vierten Tag_2 der Woche_2'           ,
      stk_str_prod_wday5 NUMBER(38,8)              COMMENT 'Stueckleistung am fünften Tag_2 der Woche_2'           ,
      stk_str_prod_wday6 NUMBER(38,8)              COMMENT 'Stueckleistung am sechsten Tag_2 der Woche_2'          ,
      stk_str_prod_wday7 NUMBER(38,8)              COMMENT 'Stueckleistung am siebten Tag_2 der Woche_2'           ,
      stk_str_prod_wktd NUMBER(38,8)               COMMENT 'Stueckleistung wöchentlich'                        ,
      stk_str_prod_mtd NUMBER(38,8)                COMMENT 'Stueckleistung Monat_2 bis zum Datum'                ,
      stk_str_prod_bytd NUMBER(38,8)               COMMENT 'Stueckleistung Jahr bis Datum'                     ,
      del_stk_plan_wktd NUMBER(38,8)               COMMENT 'Delta plan wöchentlich'                            ,
      del_stk_plan_mtd NUMBER(38,8)                COMMENT 'Delta plan Monat_2 bis zum Datum'                    ,
      del_stk_plan_bytd NUMBER(38,8)               COMMENT 'Delta plan Jahr bis Datum'                         ,
      del_stk_pep_wktd NUMBER(38,8)                COMMENT 'Delta Pep wöchentlich'                             ,
      del_stk_pep_mtd NUMBER(38,8)                 COMMENT 'Delta Pep Monat_2 bis zum Datum'                     ,
      del_stk_pep_bytd NUMBER(38,8)                COMMENT 'Delta Pep Jahr bis Datum'                          ,
      prev1y_stk_str_prod_wktd NUMBER(38,8)        COMMENT 'vorheriges Jahr Stueckleistung wöchentlich'        ,
      prev1y_stk_str_prod_mtd NUMBER(38,8)         COMMENT 'vorheriges Jahr Stueckleistung Monat_2 bis zum Datum',
      prev1y_stk_str_prod_bytd NUMBER(38,8)        COMMENT 'vorheriges Jahr Stueckleistung Jahr bis Datum'     
) COMMENT = 'Stueckleistung (Piece Performance) for Filiale Cockpit'
;
