CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_zsm_numberrange_item (idq_addinfo_zsm_numberrange_item_id,
idq_test_object_id, source_system_primary_key, ref_source_system_id, ref_country_id, ref_branch_id, is_relevant,
artikelnummer, artikelbez_deutsch, warengruppe, unterwarengruppe, artikelart, artikelstatus) AS SELECT id AS
 idq_addinfo_zsm_numberrange_item_id,
 test_object_id AS idq_test_object_id,
 source_system_primary_key,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 branch_id AS ref_branch_id,
 is_relevant,
 artikelnummer,
 artikelbez_deutsch,
 warengruppe,
 unterwarengruppe,
 artikelart,
 artikelstatus
FROM idq_production_idq_results.idq_addinfo_zsm_numberrange_item;