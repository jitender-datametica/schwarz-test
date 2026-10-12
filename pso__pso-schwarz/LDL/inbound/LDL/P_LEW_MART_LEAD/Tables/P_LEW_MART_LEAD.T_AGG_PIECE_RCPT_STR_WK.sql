/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_agg_piece_rcpt_str_wk
#-------------------------------------------------------------------------------
# History:
#  1.0    2021-07-16         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.t_agg_piece_rcpt_str_wk CLUSTER BY (client_id, cy_month) 
(
      client_id NUMBER NOT NULL                      COMMENT 'MIS Client ID'                                                               ,
      loc_sid_store_move_to NUMBER NOT NULL          COMMENT 'S-Key der Location, hier der Filiale'                                        ,
      currency_iso_cd VARCHAR(3) COLLATE 'en-ci'     COMMENT 'Währung ISO Code'                                                            ,
      busyear NUMBER NOT NULL                        COMMENT 'Käufer'                                                                      ,
      cy_month NUMBER NOT NULL                       COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM"'                                ,
      cy_week_partial_week_id NUMBER NOT NULL        COMMENT 'Geschäftsjahr - Teilwoche Id - 1 = erster Teil / 2 = zweiter Teil der Woche' ,
      piece_rcpt_wd1_val NUMBER(38,8)                COMMENT 'KPI Stuckbon für Tag 1 der Teilwoche'                                        ,
      piece_rcpt_wd2_val NUMBER(38,8)                COMMENT 'KPI Stuckbon für Tag 2 der Teilwoche'                                        ,
      piece_rcpt_wd3_val NUMBER(38,8)                COMMENT 'KPI Stuckbon für Tag 3 der Teilwoche'                                        ,
      piece_rcpt_wd4_val NUMBER(38,8)                COMMENT 'KPI Stuckbon für Tag 4 der Teilwoche'                                        ,
      piece_rcpt_wd5_val NUMBER(38,8)                COMMENT 'KPI Stuckbon für Tag 5 der Teilwoche'                                        ,
      piece_rcpt_wd6_val NUMBER(38,8)                COMMENT 'KPI Stuckbon für Tag 6 der Teilwoche'                                        ,
      piece_rcpt_wd7_val NUMBER(38,8)                COMMENT 'KPI Stuckbon für Tag 7 der Teilwoche'                                        ,
      piece_rcpt_wktd_val NUMBER(38,8)               COMMENT 'KPI Stuckbon WTD'                                                            ,
      piece_rcpt_mtd_val NUMBER(38,8)                COMMENT 'Kumulative Summe KPI Stuckbon MTD'                                           ,
      piece_rcpt_bytd_val NUMBER(38,8)               COMMENT 'Kumulative Summe KPI Stuckbon YTD'                                           ,
      prev1y_piece_rcpt_wktd_val NUMBER(38,8)        COMMENT 'KPI Stuckbon PYWTD'                                                          ,
      prev1y_piece_rcpt_mtd_val NUMBER(38,8)         COMMENT 'Kumulative Summe KPI Stuckbon Vorjahr MTD'                                   ,
      prev1y_piece_rcpt_bytd_val NUMBER(38,8)        COMMENT 'Kumulative Summe KPI Stuckbon Vorjahr YTD'
) COMMENT = 'Stueckbon (Avg Piece Receipt) for Filiale Cockpit'
;
