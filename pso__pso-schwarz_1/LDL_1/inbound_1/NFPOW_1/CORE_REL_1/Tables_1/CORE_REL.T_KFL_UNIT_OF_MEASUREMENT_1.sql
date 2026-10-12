/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_unit_of_measurement_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_UNIT_OF_MEASUREMENT_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU.MANDANT_ID',
   kfl_uom_cd                          VARCHAR(100)     NOT NULL COMMENT 'identifier uf the unit_1 of measurement in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU.EINH_ID',
   kfl_uom_name                        VARCHAR(100)     NOT NULL COMMENT 'German name of the unit_1 of measurement
            KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU.EINH_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_UNIT_OF_MEASUREMENT PRIMARY KEY (kfl_client_id, kfl_uom_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland unit_1 of measurement (German names only)
             KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU_1';

