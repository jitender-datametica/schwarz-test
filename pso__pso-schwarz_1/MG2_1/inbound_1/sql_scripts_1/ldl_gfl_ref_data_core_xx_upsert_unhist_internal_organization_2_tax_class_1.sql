INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        COUNTRY_ORG_CD,         
        TAX_CLASS_CD,
	GEO_AREA_KEY_TYPE_CD,
	TAX_CLASS_DESCR,
	TAX_TYPE_CD,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID        
) 
SELECT  ORG.COUNTRY_ORG_CD,
        ORG.TAX_CLASS_CD,
        'CTRY',
        ORG.COUNTRY_ORG_CD || '|' || ORG.TAX_CLASS_CD,
        'VAT',
        'core_rel',
        current_timestamp,
        current_timestamp             as  DWH_MAPPING_TMSP,
        0                              as  TF_ERROR_FG,
        0                              as  DELETED_FG,
        0                              as  RECORD_ID,
        't_internal_orginzation query' as  FILENAME,
        'CORE_REL'                     as  DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM (SELECT c.country_org_cd, tc.tax_class_cd
        FROM
        (
            SELECT DISTINCT country_org_cd
            from CORE_REL.T_INTERNAL_ORGANIZATION_1
            where is_country_org_fg
        ) AS c, 
        (
            SELECT t.value AS tax_class_cd
            FROM Table(Split_To_Table('A,B,C,D,E,F,G,H,I', ',')) AS t
        ) AS tc ) 
      AS ORG;

