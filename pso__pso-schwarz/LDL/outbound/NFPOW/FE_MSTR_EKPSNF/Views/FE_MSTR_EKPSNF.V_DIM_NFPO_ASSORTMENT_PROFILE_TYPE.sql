CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_assortment_profile_type (nfpo_assort_profile_type_cd
OPTIONS(description='''Code to indicate the importance profile of the item in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")
LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_CD
CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE.NFPO_ASSORT_PROFILE_TYPE_CD'''),
nfpo_assort_profile_type_name
OPTIONS(description='''Name of the profile type of the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")
LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_NAME
CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE.NFPO_ASSORT_PROFILE_TYPE_NAME'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''Classification of the assortment by the importance of the in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")
LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE
CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_assortment_profile_type;