/* --------------------------------------------------------------------------------
   DDL for table: t_ref_assortment_profile_type
   generated from Powerdesigner on Donnerstag, 12. September 2024 19:24:34
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE (
   assort_profile_type_cd              VARCHAR(100)     NOT NULL COMMENT 'Code to indicate the importance profile of the item in the assortment (Pflicht, Profilierung, Ergänzung).
            CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")',
   assort_profile_type_name            VARCHAR(100)     COMMENT 'Name of the profile type in the assortment (Pflicht, Profilierung, Ergänzung).
            CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_ASSORTMENT_PROFILE_TYPE PRIMARY KEY (assort_profile_type_cd) NOT ENFORCED 
)  COMMENT = 'Classification of the assortment by the importance of the item in the assortment (Pflicht, Profilierung, Ergänzung).
             CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")';
