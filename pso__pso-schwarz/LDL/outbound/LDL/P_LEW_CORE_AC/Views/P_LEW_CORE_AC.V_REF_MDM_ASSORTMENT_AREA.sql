CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_assortment_area (mdm_assortment_area_id
OPTIONS(description='''code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list \'REPORT_AF_PILLAR_PRODUCTCATEGORY\')'''),
mdm_assortment_area_name
OPTIONS(description='''name of the NFPO asortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list \'REPORT_AF_PILLAR_PRODUCTCATEGORY\')'''),
dwh_load_id OPTIONS(description='identifier of the last run which inserted or updated the record'), dwh_created
OPTIONS(description='creation timestamp of the record in the DWH'), dwh_updated
OPTIONS(description='timestamp of the last update of the record in the DWH'))
OPTIONS(DESCRIPTION = '''codes for NFPO assortment area
             CBX:  CNT_CODELIST (code list \'REPORT_AF_PILLAR_PRODUCTCATEGORY\')''')
AS SELECT mdm_assortment_area_id,
 mdm_assortment_area_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_assortment_area;