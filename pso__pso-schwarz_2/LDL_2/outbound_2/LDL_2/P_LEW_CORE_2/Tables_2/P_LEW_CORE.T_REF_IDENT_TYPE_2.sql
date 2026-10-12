/* --------------------------------------------------------------------------------
   DDL for table: t_ref_ident_type_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_ident_type_2 (
context_name STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Different context names like customer,supplier_2,store_manager,account_2 manager'),
ident_type_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Code for identity provided by the context'),
ident_type_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Description of identity provided by context ex: digital card, phone number, null if its not known'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
) OPTIONS(description='$Revision: 10062 $. Provides indentity type for diffrent context');