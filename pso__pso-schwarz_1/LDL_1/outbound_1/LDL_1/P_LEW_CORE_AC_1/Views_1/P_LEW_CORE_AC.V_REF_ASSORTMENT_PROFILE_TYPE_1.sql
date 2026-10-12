CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_assortment_profile_type_1 (assort_profile_type_cd
OPTIONS(description='''Code to indicate the importance profile of the item_1 in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")'''),
assort_profile_type_name
OPTIONS(description='''Name of the profile type in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")'''),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''Classification of the assortment by the importance of the item_1 in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")''')
AS SELECT assort_profile_type_cd,
 assort_profile_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_assortment_profile_type_1;