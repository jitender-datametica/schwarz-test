CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_konbbyh_pmr_status_report_2 (id, bbynr, aktnr, offer_id, status_2,
datab, zzkschl, zzgv_nr, country_2, ref_country_id, ref_source_system_id, calculation_time) AS SELECT id,
 bbynr,
 aktnr,
 offer_id,
 status_2,
 datab,
 zzkschl,
 zzgv_nr,
 country_code AS country_2,
 CAST(country_code_mapped AS BIGNUMERIC) AS ref_country_id,
 source_system_id AS ref_source_system_id,
 calculation_time
FROM idq_production_idq_results.idq_addinfo_konbbyh_pmr_status_report_2;