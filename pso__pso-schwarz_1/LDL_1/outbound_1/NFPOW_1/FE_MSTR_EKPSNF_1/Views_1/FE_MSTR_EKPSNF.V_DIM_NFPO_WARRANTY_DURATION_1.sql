CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_warranty_duration_1 (nfpo_warranty_dur_cd
OPTIONS(description='''NFPO warranty duration code.
CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_CD
CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_CD'''),
nfpo_warranty_dur_name
OPTIONS(description='''NFPO warranty duration name.
CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_DESCR
CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_NAME'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''NFPO guarantee length types of items.
CBX: CNT_CODELIST_1, code list "LIDL_WARRANTY"
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_1
CORE_REL: T_NFPO_WARRANTY_DURATION_1''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_warranty_duration_1;