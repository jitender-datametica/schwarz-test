/* --------------------------------------------------------------------------------
   DDL for table: t_ref_inv_type_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_inv_type_2 (
inv_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='id of the general inventory type, includes types for stock correction count requests'),
inv_type_descr STRING(100) NOT NULL
OPTIONS(description='description of the general inventory type, includes types for stock correction count requests'),
inv_type_descr_en STRING(100) NOT NULL
OPTIONS(description='english description of the general inventory type, includes types for stock correction count requests'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (inv_type_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. general inventory type, includes types for stock correction count requests;             Source: static reference, possible values in WAWI field C438_INV_TYPE');