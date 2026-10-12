/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_client_vat_hist_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_CLIENT_VAT_HIST_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MANDANT_ID',
   kfl_vat_nr                          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the vat rate in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MWST_ID',
   active_from_dt                      DATE             NOT NULL COMMENT 'begin date of the validity_2 period of the vat rate
            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.DAT_VON',
   active_to_dt                        DATE             NOT NULL COMMENT 'end date of the validity_2 period of the vat rate
            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.DAT_BIS',
   kfl_vat_name                        VARCHAR(100)     NOT NULL COMMENT 'name of the vat rate in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MWST_BEZ',
   kfl_vat_pct                         NUMBER(38,5)     NOT NULL COMMENT 'percentage of the vat rate in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MWST',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_CLIENT_VAT_HIST PRIMARY KEY (kfl_vat_nr, kfl_client_id, active_from_dt) NOT ENFORCED 
)  COMMENT = 'Kaufland vat rates, vat percentage is historicized
             KFL: KFL_PRODUCTION.DBP_DATA.MWST_PER_2';

