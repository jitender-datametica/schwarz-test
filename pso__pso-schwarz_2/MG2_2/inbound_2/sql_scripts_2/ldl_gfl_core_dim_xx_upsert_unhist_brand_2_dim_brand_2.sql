INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
brand_name,
dwh_load_id,
dwh_node_cd,
tf_error_fg,
error_descr,
record_id,
filename
)

SELECT 
	upper (BRAND_NAME) as BRAND_NAME
	,${LOAD_ID} dwh_load_id,
dwh_node_cd dwh_node_cd,
0 tf_error_fg,
''error_descr,
0 record_id,
'core_rel' filename
FROM core_rel.T_BRAND_2
QUALIFY row_number() over (partition by UPPER(BRAND_NAME)  order by BRAND_NAME desc) = 1;
