CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_wawi_art_2 (idq_addinfo_wawi_art_id, idq_test_object_id,
ref_branch_id, source_system_primary_key, source_system_id, ref_country_id, artnrvier, artikelnr, c215_int_itemnr,
bez_lang, deutschtext, artgrupnr_beschreibung, artikel_familie, c270_listdescript, c0603_reason_for_relevance,
is_relevant, artgrupnr_derived) AS SELECT id AS idq_addinfo_wawi_art_id,
 test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 source_system_primary_key,
 source_system_id,
 country_id AS ref_country_id,
 artnrvier,
 artikelnr,
 c215_int_itemnr,
 bez_lang,
 deutschtext,
 artgrupnr_beschreibung,
 artikel_familie,
 c270_listdescript,
 c0603_reason_for_relevance,
 is_relevant,
  CASE
  WHEN STRPOS(artikel_familie, '.') > 0
  THEN LEFT(artikel_familie, STRPOS(artikel_familie, '.') - 1)
  ELSE artikel_familie
  END AS artgrupnr_derived
FROM idq_production_idq_results.idq_addinfo_wawi_art_2;