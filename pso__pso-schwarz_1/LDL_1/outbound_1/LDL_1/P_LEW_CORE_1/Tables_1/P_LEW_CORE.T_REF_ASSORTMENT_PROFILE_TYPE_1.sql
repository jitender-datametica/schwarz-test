/* --------------------------------------------------------------------------------
   DDL for table: t_ref_assortment_profile_type_1
   generated from Powerdesigner on Donnerstag, 12. September 2024 19:24:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_assortment_profile_type_1 (
assort_profile_type_cd STRING(100) NOT NULL
OPTIONS(description='Code to indicate the importance profile of the item_1 in the assortment (Pflicht, Profilierung, Ergänzung).            CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")'),
assort_profile_type_name STRING(100)
OPTIONS(description='Name of the profile type in the assortment (Pflicht, Profilierung, Ergänzung).            CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (assort_profile_type_cd) NOT ENFORCED
)
OPTIONS(description='Classification of the assortment by the importance of the item_1 in the assortment (Pflicht, Profilierung, Ergänzung).             CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")');