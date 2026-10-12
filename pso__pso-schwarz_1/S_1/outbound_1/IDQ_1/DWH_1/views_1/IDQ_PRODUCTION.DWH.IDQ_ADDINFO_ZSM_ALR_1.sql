CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_zsm_alr_1 (idq_addinfo_zsm_alr_id, idq_test_object_id,
ref_test_object_type_id, source_system_primary_key, ref_source_system_id, ref_country_id, ref_branch_id, is_relevant,
lieferantennummer, lieferantenname, artikelnummer, artikelbezeichnung, berechtigungsgruppe, artikelart, warengruppe,
grunddaten_status) AS SELECT ADDI.id AS idq_addinfo_zsm_alr_id,
 ITO.id AS idq_test_object_id,
 ITO.test_object_type_id AS ref_test_object_type_id,
 ADDI.source_system_primary_key,
 ADDI.source_system_id AS ref_source_system_id,
 ADDI.country_id AS ref_country_id,
 ADDI.branch_id AS ref_branch_id,
 ADDI.is_relevant,
 ADDI.lieferantennummer,
 ADDI.lieferantenname,
 ADDI.artikelnummer,
 ADDI.artikelbezeichnung,
 ADDI.berechtigungsgruppe,
 ADDI.artikelart,
 ADDI.warengruppe,
 ADDI.grunddaten_status
FROM idq_production_idq_results.idq_addinfo_zsm_alr_1 AS ADDI
 INNER JOIN idq_production_idq_results.idq_test_object_1 AS ITO ON ADDI.source_system_primary_key = ITO.source_system_primary_key
      AND ADDI.source_system_id = ITO.source_system_id AND ADDI.country_id = ITO.country_id AND ADDI.branch_id = ITO.branch_id
   
WHERE ITO.test_object_type_id IN (3, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251
   , 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274,
   275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297,
   298, 299, 300, 301, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 431, 432, 433, 434, 435,
   436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458,
   459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472);