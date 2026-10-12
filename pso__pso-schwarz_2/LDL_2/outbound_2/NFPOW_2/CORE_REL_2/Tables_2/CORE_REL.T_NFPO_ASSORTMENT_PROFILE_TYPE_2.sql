/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_assortment_profile_type_2
   generated from Powerdesigner on Donnerstag, 12. September 2024 19:36:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_assortment_profile_type_2 (
nfpo_assort_profile_type_cd STRING(100) NOT NULL
OPTIONS(description='Code to indicate the importance profile of the item_2 in the assortment (Pflicht, Profilierung, Ergänzung).            CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")            LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_CD'),
nfpo_assort_profile_type_name STRING(100)
OPTIONS(description='Name of the profile type in the assortment (Pflicht, Profilierung, Ergänzung).            CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")            LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_assort_profile_type_cd) NOT ENFORCED
)
OPTIONS(description='Classification of the assortment by the importance of the item_2 in the assortment (Pflicht, Profilierung, Ergänzung).             CBX: CNT_CODELIST.CODE (code list\'LIDL_FMS_ASSORTMENT\')             LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE_2');