CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_hac2_hosts_1 (idq_addinfo_hac2_id, idq_test_object_id, ref_branch_id
, source_system_primary_key, ref_source_system_id, ref_country_id, is_relevant, physical_hostname, url) AS SELECT id AS
 idq_addinfo_hac2_id,
 test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 source_system_primary_key,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 is_relevant,
 physical_hostname,
     '<a href=""' || url || '"" target=""_blank""><img src=""' ||
   'https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
    || '</img></a>' AS url
FROM idq_production_idq_results.idq_addinfo_hac2_hosts_1;