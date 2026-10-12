/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_client_advertise_week_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_CLIENT_ADVERTISE_WEEK_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.MANDANT_ID
            CORE_REL: t_kfl_client_day_advertise_week.kfl_client_id',
   kfl_adv_week                        NUMBER(38,0)     NOT NULL COMMENT 'identifier of the Kaufland advertising week
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW
            CORE_REL: t_kfl_client_day_advertise_week.kfl_adv_week',
   kfl_adv_week_begin_dt               DATE             COMMENT 'identifier of the calendar_2 date
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.DAT
            CORE_REL: t_kfl_client_day_advertise_week.min(cal_dt) by kfl_client_id, kfl_adv_week',
   kfl_adv_week_end_dt                 DATE             COMMENT 'identifier of the calendar_2 date
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.DAT
            CORE_REL: t_kfl_client_day_advertise_week.max(cal_dt) by kfl_client_id, kfl_adv_week',
   kfl_adv_week_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar_2 date in relation to the current  Kaufland advertising week. If the calendar_2 date is in the current  Kaufland advertising week, then the offset is 0, if the calendar_2 date is in the  Kaufland advertising week after the current  Kaufland advertising week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW
            CORE_REL: t_kfl_client_day_advertise_week.kfl_adv_week_offset',
   kfl_completed_adv_week_offset       NUMBER(38,0)     COMMENT 'offset of the calendar_2 date in relation to the latest completed  Kaufland advertising week. If the calendar_2 date is in the latest completed  Kaufland advertising week, then the offset is 0, if the calendar_2 date is in the  Kaufland advertising week after the latest completed  Kaufland advertising week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW_KOMPLETT
            CORE_REL: t_kfl_client_day_advertise_week.kfl_completed_adv_week_offset',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_CLIENT_ADVERTISE_WEEK PRIMARY KEY (kfl_client_id, kfl_adv_week) NOT ENFORCED 
)  COMMENT = 'Kaufland Werbewochen je Mandant_2';

