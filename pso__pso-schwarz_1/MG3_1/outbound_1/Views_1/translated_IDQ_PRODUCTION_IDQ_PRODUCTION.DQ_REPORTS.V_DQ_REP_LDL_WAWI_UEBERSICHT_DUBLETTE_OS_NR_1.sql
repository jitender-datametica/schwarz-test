CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_rep_ldl_wawi_uebersicht_dublette_os_nr_1 (id, ref_rule_id,
ref_country_id, ref_source_system_type_id, calculation_time, artikelnr, c215_int_itemnr, deutschtext, warenbereich,
warengruppe, artikel_familie, artikelart, ordersatznr, duplikatsgruppe) AS SELECT ROW_NUMBER() OVER (ORDER BY artikelnr
    IS NULL, artikelnr) AS id,
 ref_rule_id,
 ref_country_id,
 2 AS ref_source_system_type_id,
 calculation_time,
 artikelnr,
 c215_int_itemnr,
 deutschtext,
 warenbereich,
 warengruppe,
 artikel_familie,
 artikelart,
 ordersatznr,
 duplikatsgruppe
FROM idq_production_dq_reports.t_dq_rep_ldl_wawi_uebersicht_dublette_os_nr_1;