/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_gtp_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_gtp_type_1 (
kfl_gtp_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.WUP_TYP.WUP_TYP_ID            CORE_REL: t_kfl_gtp_type.kfl_gtp_type_id'),
kfl_gtp_type_name STRING(100)
OPTIONS(description='name of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.WUP_TYP.WUP_TYP_BEZ            CORE_REL: t_kfl_gtp_type.kfl_gtp_type_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_gtp_type_id) NOT ENFORCED
)
OPTIONS(description='Kaufland type of goods transshipment point (WUP_1)             KFL: DBP_DATA.WUP_TYP_1             CORE_REL: T_KFL_GTP_TYPE_1');