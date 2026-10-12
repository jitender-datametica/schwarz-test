/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_business_year_week
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_BUSINESS_YEAR_WEEK DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_bus_year_week                   NUMBER(38,0)     NOT NULL COMMENT 'identifier of the Kaufland business year related Kaufland business year week in the Kaufland DWH, if a business year week starts in a certain Kaufland business year and ends in the next Kaufland business year then the business year week is split into 2 Kaufland business year related Kaufland business year weeks
            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.GJWO_KL',
   kfl_bus_year_week_begin_dt          DATE             COMMENT 'date of the first day of the Kaufland business year related Kaufland business year week
            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.GJWO_KL_DAT_VON',
   kfl_bus_year_week_end_dt            DATE             COMMENT 'date of the last day of the Kaufland business year related Kaufland business year week
            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.GJWO_KL_DAT_BIS',
   kfl_bus_year_week_offset            NUMBER(38,0)     COMMENT 'offset of the Kaufland business year related Kaufland business year week in relation to the current Kaufland business year related Kaufland business year week. If the Kaufland business year related Kaufland business year week is the Kaufland business year related Kaufland business year week, then the offset is 0, if the Kaufland business year related Kaufland business year week is one week after the current Kaufland business year related Kaufland business year week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJWO_KL',
   kfl_completed_bus_year_week_offset  NUMBER(38,0)     COMMENT 'offset of the Kaufland business year related Kaufland business year week in relation to the latest completed Kaufland business year related Kaufland business year week. If the Kaufland business year related Kaufland business year week is the latest completed Kaufland business year related Kaufland business year week, then the offset is 0, if the Kaufland business year related Kaufland business year week is one week after the latest Kaufland business year related Kaufland business year week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJWO_KL_KOMPLETT',
   kfl_bus_year_offset                 NUMBER(38,0)     COMMENT 'offset of the Kaufland business year related Kaufland business year week in relation to the current business year. If the Kaufland business year related Kaufland business year week is in the current business year, then the offset is 0, if the Kaufland business year related Kaufland business year week is in the year after the current business year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJ',
   kfl_completed_bus_year_offset       NUMBER(38,0)     COMMENT 'offset of the Kaufland business year related Kaufland business year week in relation to the latest completed business year. If the Kaufland business year related Kaufland business year week is in the latest completed business year, then the offset is 0, if the Kaufland business year related Kaufland business year week is in the year after the latest completed business year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJ_KOMPLETT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_BUSINESS_YEAR_WEEK PRIMARY KEY (kfl_bus_year_week) NOT ENFORCED 
)  COMMENT = 'Kaufland business year related calendar weeks, normal calendar weeks are splitted into two partial weeks if begin and end are in two consecutive business years.
             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE_GJ_KL';

