CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_kaufland_retail_step_article_1 (idq_addinfo_kaufland_retail_step_article_id
, idq_test_object_id, ref_branch_id, source_system_primary_key, ref_source_system_id, ref_country_id, is_relevant,
system_id, mandt, matnr, matkl, owg, owg_decs, wekgr, eknam, ean11, mstae, wgi, artikelbezeichnung_de, zsm_itemnr) AS
SELECT id AS idq_addinfo_kaufland_retail_step_article_id,
 test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 RIGHT(source_system_primary_key, 8) AS source_system_primary_key,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 is_relevant,
 systemid AS system_id,
 mandt,
 matnr,
 matkl,
 owg,
 owg_decs,
 wekgr,
 eknam,
 ean11,
 mstae,
 wgi,
 artikelbezeichnung_de,
 zsm_itemnr
FROM idq_production_idq_results.idq_addinfo_kaufland_retail_step_article_1;