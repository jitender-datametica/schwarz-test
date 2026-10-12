CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_ASSORTMENT_PROFILE_TYPE (
   assort_profile_type_cd                   COMMENT 'Code to indicate the importance profile of the item in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")'
  ,assort_profile_type_name                 COMMENT 'Name of the profile type in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Classification of the assortment by the importance of the item in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")'
AS SELECT
   assort_profile_type_cd
  ,assort_profile_type_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE
;