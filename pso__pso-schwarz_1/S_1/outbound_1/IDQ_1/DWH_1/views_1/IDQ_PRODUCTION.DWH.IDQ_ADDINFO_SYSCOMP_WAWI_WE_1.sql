CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_syscomp_wawi_we_1 (idq_addinfo_wawi_article_id, idq_test_object_id,
source_system_primary_key, ref_source_system_id, ref_country_id, ref_branch_id, is_relevant, artikelnr, gesellschaftsnr
, posnr, datum, landkzl, mengestueck, pallet_factor, tgstatus, valid_from, valid_until, wedatum, weposart) AS SELECT id
 AS idq_addinfo_wawi_article_id,
 test_object_id AS idq_test_object_id,
 source_system_primary_key,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 branch_id AS ref_branch_id,
 is_relevant,
 artikelnr,
 gesellschaftsnr,
 posnr,
 datum,
 landkzl,
 mengestueck,
 pallet_factor,
 tgstatus,
 valid_from,
 valid_until,
 wedatum,
 weposart
FROM idq_production_idq_results.idq_addinfo_syscomp_wawi_we_1;