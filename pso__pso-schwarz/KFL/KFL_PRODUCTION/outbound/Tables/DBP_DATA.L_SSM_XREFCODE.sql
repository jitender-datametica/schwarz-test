--==============================================================
-- Table: l_ssm_xrefcode
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ssm_xrefcode
   generated from Powerdesigner on Freitag, 11. Juli 2025 14:16:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ssm_xrefcode (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
dayforce_xrefcode STRING(50) NOT NULL
OPTIONS(description='Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce.'),
rate_nettoleistung_anpassung BIGNUMERIC(38,6)
OPTIONS(description='Prozentualer Anteil je dayforce_xrefcode an der Anpassung der Nettostunden.'),
dayforce_export_typ_cd STRING(10)
OPTIONS(description='Export Typ PH Stunden des xrefcodes an Dayforce. Je nach Typ müssen im Export unterschiedliche Logiken angewendet werden. 1 = 15 Min; 2 = Tageswerte'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dayforce_xrefcode) NOT ENFORCED
)
OPTIONS(description='VIS - Sollstundenmodell - Die Tabelle ist eine Lookup-Tabelle für ssm_xrefcodes. Sie enthält die Verteilung der Planstundenanpassung auf die zugrundeliegenden Prozesse.');