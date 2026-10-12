CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_ASSORTMENT_AREA_2
(
   mdm_assortment_area_id               COMMENT 'code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')'
   ,mdm_assortment_area_name            COMMENT 'name of the NFPO asortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')'
   ,dwh_load_id                         COMMENT 'identifier of the last run which inserted or updated the record'
   ,dwh_created                         COMMENT 'creation timestamp of the record in the DWH'
   ,dwh_updated                         COMMENT 'timestamp of the last update of the record in the DWH'
) COMMENT = 'codes for NFPO assortment area
             CBX:  CNT_CODELIST_2 (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')'
AS 
    SELECT 
        mdm_assortment_area_id
        ,mdm_assortment_area_name
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA_2 ;
