CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_zsm_article (idq_addinfo_zsm_article_id, idq_test_object_id,
ref_test_object_type_id, source_system_primary_key, ref_source_system_id, ref_country_id, ref_branch_id, is_relevant,
artikelnummer, artikelbezeichnung, `alte artikelnummer`, berechtigungsgruppe, artikelart, warengruppe, status) AS SELECT
 ADDI.id AS idq_addinfo_zsm_article_id,
 ITO.id AS idq_test_object_id,
 ITO.test_object_type_id AS ref_test_object_type_id,
 ADDI.source_system_primary_key,
 ADDI.source_system_id AS ref_source_system_id,
 ADDI.country_id AS ref_country_id,
 ADDI.branch_id AS ref_branch_id,
 ADDI.is_relevant,
 ADDI.artikelnummer,
 ADDI.artikelbezeichnung,
 ADDI.alte_artikelnummer AS `alte artikelnummer`,
 ADDI.berechtigungsgruppe,
 ADDI.artikelart,
 ADDI.warengruppe,
 ADDI.status
FROM idq_production_idq_results.idq_addinfo_zsm_article AS ADDI
 INNER JOIN idq_production_idq_results.idq_test_object AS ITO ON ADDI.source_system_primary_key = ITO.source_system_primary_key
      AND ADDI.source_system_id = ITO.source_system_id AND ADDI.country_id = ITO.country_id AND ADDI.branch_id = ITO.branch_id
   
WHERE ITO.test_object_type_id IN (1, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45
   , 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74
   , 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102,
   103, 104, 105, 106, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407,
   408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430);