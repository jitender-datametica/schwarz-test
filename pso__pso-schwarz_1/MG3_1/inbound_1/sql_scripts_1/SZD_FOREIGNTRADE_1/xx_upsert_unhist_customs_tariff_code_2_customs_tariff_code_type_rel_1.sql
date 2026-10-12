INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
CUSTOMS_CLASSIFICATION_SCHEME_CD,
customs_tariff_code_cd,
customs_tariff_code_type_cd,
customs_tariff_category_cd,
   DWH_SRC_FILE_NAME,
	DWH_SRC_1_TMSP,
	DWH_MAPPING_TMSP,
	TF_ERROR_FG,
	DELETED_FG,
	RECORD_ID,
FILENAME 
)
SELECT 
c.CUSTOMS_CLASSIFICATION_SCHEME_CD,
c.customs_tariff_code_cd,
COALESCE(D.customs_tariff_code_type_cd, '-1'),
COALESCE(D.customs_tariff_category_cd, '-1'),
   c.DWH_SRC_FILE_NAME,
	c.DWH_SRC_1_TMSP,
	c.DWH_SRC_1_TMSP DWH_MAPPING_TMSP,
	0 TF_ERROR_FG,
	0 DELETED_FG,
	0 RECORD_ID,
	c.DWH_SRC_FILE_NAME FILENAME 
FROM 
core_rel.t_customs_tariff_code_1 c
  left
  join core_rel.t_customs_tariff_code_type_definition_1 d
    on c.customs_tariff_code_cd between d.lower_bound and d.upper_bound
