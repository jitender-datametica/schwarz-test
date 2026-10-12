/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_client_day_advertise_week_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_CLIENT_DAY_ADVERTISE_WEEK_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.MANDANT_ID',
   cal_dt                              DATE             NOT NULL COMMENT 'identifier of the calendar_1 date
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.DAT',
   kfl_adv_week                        NUMBER(38,0)     COMMENT 'identifier of the Kaufland advertising week
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW',
   kfl_adv_week_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar_1 date in relation to the current  Kaufland advertising week. If the calendar_1 date is in the current  Kaufland advertising week, then the offset is 0, if the calendar_1 date is in the  Kaufland advertising week after the current  Kaufland advertising week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW',
   kfl_completed_adv_week_offset       NUMBER(38,0)     COMMENT 'offset of the calendar_1 date in relation to the latest completed  Kaufland advertising week. If the calendar_1 date is in the latest completed  Kaufland advertising week, then the offset is 0, if the calendar_1 date is in the  Kaufland advertising week after the latest completed  Kaufland advertising week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW_KOMPLETT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_CLIENT_DAY_ADVERTISE_WEEK PRIMARY KEY (cal_dt, kfl_client_id) NOT ENFORCED 
)  COMMENT = 'Kaufland assignment of advertising week to calendar_1 date per Kaufland.
             KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL_1';

