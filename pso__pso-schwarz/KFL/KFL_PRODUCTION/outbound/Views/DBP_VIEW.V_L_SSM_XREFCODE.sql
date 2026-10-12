CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ssm_xrefcode (mandant_id OPTIONS(description='Mandant im DWH.'),
dayforce_xrefcode
OPTIONS(description='Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce.'),
rate_nettoleistung_anpassung
OPTIONS(description='Prozentualer Anteil je dayforce_xrefcode an der Anpassung der Nettostunden.'),
dayforce_export_typ_cd
OPTIONS(description='Export Typ PH Stunden des xrefcodes an Dayforce. Je nach Typ müssen im Export unterschiedliche Logiken angewendet werden. 1 = 15 Min; 2 = Tageswerte'))
OPTIONS(DESCRIPTION = `VIS - SOLLSTUNDENMODELL - DIE TABELLE IST EINE LOOKUP-TABELLE FÜR SSM_XREFCODES. SIE ENTHÄLT DIE VERTEILUNG DER PLANSTUNDENANPASSUNG AUF DIE ZUGRUNDELIEGENDEN PROZESSE.`)
AS SELECT mandant_id,
 dayforce_xrefcode,
 rate_nettoleistung_anpassung,
 dayforce_export_typ_cd
FROM kfl_production_dbp_data.l_ssm_xrefcode;