CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_relevance_classification_1 (client_id
OPTIONS(description='CLIENT ID of the item.'), item_sid
OPTIONS(description='Item_1 for which a certain relevance classification schema is valid.'),
item_relevance_class_schema_cd OPTIONS(description='Code of the item_1 relevance classification schema.'), dwh_valid_from
OPTIONS(description='Beginning of the validity_1 interval of the record.'), dwh_valid_to
OPTIONS(description='End of the validity_1 interval of the record.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record.'), dwh_created
OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE RELATION OF ITEMS AND CLASSIFICATION SCHEMAS FOR THE DETECTION OF THE RELEVANCE OF ITEMS IN DIFFERENT SITUATIONS.ONLY VALID RELATION RECORDS ARE STORED.`)
AS SELECT client_id,
 item_sid,
 item_relevance_class_schema_cd,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_relevance_classification_1;