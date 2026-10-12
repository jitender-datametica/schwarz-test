CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_relevance_classification_schema (item_relevance_class_schema_cd
OPTIONS(description='Code of the item relevance classification schema.'), item_relevance_class_schema_name
OPTIONS(description='Name of the item relevance classification schema.'), item_relevance_class_schema_descr
OPTIONS(description='Description of the item relevance classification schema.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record.'), dwh_created
OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS CLASSIFICATION SCHEMAS FOR THE DETECTION OF THE RELEVANCE OF ITEMS IN DIFFERENT SITUATIONS.EXAMPLES OF SCHEMA CODES ARE OBE FOR OFFENE BESTELLUNGEN OR STA FOR GESELLSCHAFTSSTATUS.`)
AS SELECT item_relevance_class_schema_cd,
 item_relevance_class_schema_name,
 item_relevance_class_schema_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_relevance_classification_schema;