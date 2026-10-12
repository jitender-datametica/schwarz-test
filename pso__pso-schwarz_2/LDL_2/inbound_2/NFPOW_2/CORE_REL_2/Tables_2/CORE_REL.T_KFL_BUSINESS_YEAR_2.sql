/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_business_year_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_BUSINESS_YEAR_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_bus_year                        NUMBER(38,0)     NOT NULL COMMENT 'identifier of the Kaufland business year in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.GJ',
   kfl_bus_year_offset                 NUMBER(38,0)     COMMENT 'offset of the Kaufland business year in the Kaufland DWH in relation to the current Kaufland business year. If the Kaufland business year is the current Kaufland business year, then the offset is 0, if the Kaufland business year is one year after the current Kaufland business year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.AKT_GJ',
   kfl_completed_bus_year_offset       NUMBER(38,0)     COMMENT 'offset of the Kaufland business year in the Kaufland DWH in relation to the latest completed Kaufland business year. If the Kaufland business year is the latest completed Kaufland business year, then the offset is 0, if the Kaufland business year is one year after the latest completed Kaufland business year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.AKT_GJ_KOMPLETT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_BUSINESS_YEAR PRIMARY KEY (kfl_bus_year) NOT ENFORCED 
)  COMMENT = 'Kaufland business year
             KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ_2';

