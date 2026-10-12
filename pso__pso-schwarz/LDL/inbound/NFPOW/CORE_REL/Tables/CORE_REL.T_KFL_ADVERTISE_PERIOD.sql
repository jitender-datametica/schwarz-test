/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_advertise_period
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ADVERTISE_PERIOD DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.MANDANT_ID',
   kfl_adv_period_type_id              NUMBER(38,0)     NOT NULL COMMENT 'identifier of the advertising period type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.WERBE_TYP_ID',
   cal_week                            NUMBER(38,0)     NOT NULL COMMENT 'calendar week
            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.KJWO',
   kfl_adjust_adv_period_fg            BOOLEAN          COMMENT 'indicator whether the length of the advertising period is different to the standard length of this advertising period type
            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.ABW_ZEITR_FG',
   kfl_adv_period_begin_dt             DATE             COMMENT 'first calendar date of the advertising period in the calendar week
            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.DAT_VON',
   kfl_adv_period_end_dt               DATE             COMMENT 'last calendar date of the advertising period started in the calendar week
            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.DAT_BIS',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ADVERTISE_PERIOD PRIMARY KEY (kfl_client_id, kfl_adv_period_type_id, cal_week) NOT ENFORCED 
)  COMMENT = 'Kaufland advertise period
             KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE';

