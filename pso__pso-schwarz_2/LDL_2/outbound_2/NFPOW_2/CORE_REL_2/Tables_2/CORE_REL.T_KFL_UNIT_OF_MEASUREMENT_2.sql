/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_unit_of_measurement_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_unit_of_measurement_2 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_2) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU.MANDANT_ID'),
kfl_uom_cd STRING(100) NOT NULL
OPTIONS(description='identifier uf the unit_2 of measurement in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU.EINH_ID'),
kfl_uom_name STRING(100) NOT NULL
OPTIONS(description='German name of the unit_2 of measurement            KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU.EINH_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_uom_cd) NOT ENFORCED
)
OPTIONS(description='Kaufland unit_2 of measurement (German names only)             KFL: KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU_2');