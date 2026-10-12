CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_rep_ldl_wawi_uebersicht_fehlerhafte_rlz (id, ref_rule_id,
ref_country_id, calculation_time, artikelnr, c215_int_itemnr, bez_lang, bez_kurz, deutschtext, warenbereich, warengruppe
, relevanzkrtiterien, alr_chained_rlz, ref_source_system_type_id, shelflife_type, artlieferant_shelflife_type) AS SELECT
 ROW_NUMBER() OVER (ORDER BY artikelnr IS NULL, artikelnr) AS id,
 ref_rule_id,
 ref_country_id,
 calculation_time,
 artikelnr,
 c215_int_itemnr,
 bez_lang,
 bez_kurz,
 deutschtext,
 warenbereich,
 warengruppe,
 relevanzkrtiterien,
 alr_chained_rlz,
 2 AS ref_source_system_type_id,
 shelflife_type,
 artlieferant_shelflife_type
FROM idq_production_dq_reports.t_dq_rep_ldl_wawi_uebersicht_fehlerhafte_rlz;