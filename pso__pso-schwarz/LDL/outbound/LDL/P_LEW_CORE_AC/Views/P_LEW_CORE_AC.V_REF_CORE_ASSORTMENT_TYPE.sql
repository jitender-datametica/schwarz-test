CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_core_assortment_type (core_assort_type_cd
OPTIONS(description='''Code  of the type how items can be regarded to be part of the Lidl core assortment.
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'''),
core_assort_type_name
OPTIONS(description='''Name of the type how items can be regarded to be part of the Lidl core assortment.
CBX: CNT_CODELIST.NAME (code list "lidl_Core_Article")'''),
retail_core_assort_fg
OPTIONS(description='''Indicator whether the code classifies the item to be part of the Lidl retail core assortment
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'''),
online_core_assort_fg
OPTIONS(description='''Indicator whether the code classifies the item to be part of the Lidl online core assortment
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'''),
online_core_assort_week_cnt
OPTIONS(description='''number of weeks the classified item is regarded to be part of the online core assortment
CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'''),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''This table containes the types of how items can be regarded to be part of the Lidl core assortment.
CBX: CNT_CODELIST (code list "lidl_Core_Article")''')
AS SELECT core_assort_type_cd,
 core_assort_type_name,
 retail_core_assort_fg,
 online_core_assort_fg,
 online_core_assort_week_cnt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_core_assortment_type;