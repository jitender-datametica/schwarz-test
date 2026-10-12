CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_CORE_ASSORTMENT_TYPE_1 (
   core_assort_type_cd                      COMMENT 'Code  of the type how items can be regarded to be part of the Lidl core assortment.
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'
  ,core_assort_type_name                    COMMENT 'Name of the type how items can be regarded to be part of the Lidl core assortment.
CBX: CNT_CODELIST.NAME (code list "lidl_Core_Article")'
  ,retail_core_assort_fg                    COMMENT 'Indicator whether the code classifies the item_1 to be part of the Lidl retail core assortment
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'
  ,online_core_assort_fg                    COMMENT 'Indicator whether the code classifies the item_1 to be part of the Lidl online core assortment
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'
  ,online_core_assort_week_cnt              COMMENT 'number of weeks the classified item_1 is regarded to be part of the online core assortment
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table containes the types of how items can be regarded to be part of the Lidl core assortment.
CBX: CNT_CODELIST_1 (code list "lidl_Core_Article")'
AS SELECT
   core_assort_type_cd
  ,core_assort_type_name
  ,retail_core_assort_fg
  ,online_core_assort_fg
  ,online_core_assort_week_cnt
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE_1
;