/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_client_vat_hist
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_client_vat_hist (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MANDANT_ID'),
kfl_vat_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the vat rate in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MWST_ID'),
active_from_dt DATE NOT NULL
OPTIONS(description='begin date of the validity period of the vat rate            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.DAT_VON'),
active_to_dt DATE NOT NULL
OPTIONS(description='end date of the validity period of the vat rate            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.DAT_BIS'),
kfl_vat_name STRING(100) NOT NULL
OPTIONS(description='name of the vat rate in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MWST_BEZ'),
kfl_vat_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='percentage of the vat rate in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.mwst_per.MWST'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_vat_nr, kfl_client_id, active_from_dt) NOT ENFORCED
)
OPTIONS(description='Kaufland vat rates, vat percentage is historicized             KFL: KFL_PRODUCTION.DBP_DATA.MWST_PER');