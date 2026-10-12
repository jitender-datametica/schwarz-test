CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_zsm_supplier (idq_addinfo_zsm_supplier_id, idq_test_object_id,
ref_test_object_type_id, source_system_primary_key, ref_source_system_id, ref_country_id, ref_branch_id, is_relevant,
zz_negot_country, conegot_country) AS SELECT addi.id AS idq_addinfo_zsm_supplier_id,
 ito.id AS idq_test_object_id,
 ito.test_object_type_id AS ref_test_object_type_id,
 addi.source_system_primary_key,
 addi.source_system_id AS ref_source_system_id,
 addi.country_id AS ref_country_id,
 addi.branch_id AS ref_branch_id,
 addi.is_relevant,
 addi.zz_net_country AS zz_negot_country,
 addi.conet_country AS conegot_country
FROM idq_production_idq_results.idq_addinfo_zsm_supplier AS addi
 INNER JOIN idq_production_idq_results.idq_test_object AS ito ON addi.source_system_primary_key = ito.source_system_primary_key
      AND addi.source_system_id = ito.source_system_id AND addi.country_id = ito.country_id AND addi.branch_id = ito.branch_id
   
WHERE ito.test_object_type_id = 2;