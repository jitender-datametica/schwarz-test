CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_category_management_1 (idq_addinfo_category_management_id,
idq_test_object_id, ref_test_object_type_id, source_system_primary_key, ref_source_system_id, ref_country_id,
ref_branch_id, is_relevant, land_1, datenlieferant, periode, jahr, monat_nr, monat_1, warengruppe, retailer_type, haendler)
AS SELECT ADDI.id AS idq_addinfo_category_management_id,
 ITO.id AS idq_test_object_id,
 ITO.test_object_type_id AS ref_test_object_type_id,
 ADDI.source_system_primary_key,
 ADDI.source_system_id AS ref_source_system_id,
 ADDI.country_id AS ref_country_id,
 ADDI.branch_id AS ref_branch_id,
 ITO.is_relevant,
 ADDI.land_1,
 ADDI.datenlieferant,
 ADDI.periode,
 ADDI.jahr,
 ADDI.monat_nr,
 ADDI.monat_1,
 ADDI.warengruppe,
 ADDI.retailer_type,
 ADDI.haendler
FROM idq_production_idq_results.idq_addinfo_category_management_1 AS ADDI
 INNER JOIN idq_production_idq_results.idq_test_object_1 AS ITO ON ADDI.source_system_primary_key = ITO.source_system_primary_key
      AND ADDI.source_system_id = ITO.source_system_id AND ADDI.country_id = ITO.country_id AND ADDI.branch_id = ITO.branch_id
   
WHERE ITO.test_object_type_id IN (493, 494);