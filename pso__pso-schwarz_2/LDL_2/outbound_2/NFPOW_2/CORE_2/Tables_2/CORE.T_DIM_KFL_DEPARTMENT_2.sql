/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_department_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_department_2 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_2) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.MANDANT_ID            CORE_REL: t_kfl_department.kfl_client_id'),
kfl_department_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the department (Abteilung) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_ID            CORE_REL: t_kfl_department.kfl_department_id'),
kfl_department_name STRING(400)
OPTIONS(description='German name of the department (Abteilung) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_BEZ            CORE_REL: t_kfl_department.kfl_department_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_department_id) NOT ENFORCED
)
OPTIONS(description='Kaufland department (German names only)             KFL: DBP_DATA.ABT_SPR_ZU_2             CORE_REL: T_KFL_DEPARTMENT_2');