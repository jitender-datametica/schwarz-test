/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_advertise_period_type_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ADVERTISE_PERIOD_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.werbe_typ_spr_zu.MANDANT_ID',
   kfl_adv_period_type_id              NUMBER(38,0)     NOT NULL COMMENT 'identifier of the advertising period type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.werbe_typ_spr_zu.WERBE_TYP_ID',
   kfl_adv_period_type_name            VARCHAR(100)     COMMENT 'name of the advertising preiod type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.werbe_typ_spr_zu.WERBE_TYP_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ADVERTISE_PERIOD_TYPE PRIMARY KEY (kfl_client_id, kfl_adv_period_type_id) NOT ENFORCED 
)  COMMENT = 'Kaufland type of advertise periods (German names only)
             KFL_PRODUCTION.DBP_DATA.WERBE_TYP_SPR_ZU_2';

