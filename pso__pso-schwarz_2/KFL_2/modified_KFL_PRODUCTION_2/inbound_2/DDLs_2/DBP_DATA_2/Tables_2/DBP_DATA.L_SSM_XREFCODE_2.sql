--==============================================================
-- Table: l_ssm_xrefcode_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ssm_xrefcode_2
   generated from Powerdesigner on Freitag, 11. Juli 2025 14:16:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SSM_XREFCODE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   dayforce_xrefcode                   VARCHAR(50)      NOT NULL COMMENT 'Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce.',
   rate_nettoleistung_anpassung        NUMBER(29,6)     COMMENT 'Prozentualer Anteil je dayforce_xrefcode an der Anpassung der Nettostunden.',
   dayforce_export_typ_cd              VARCHAR(10)      COMMENT 'Export Typ PH Stunden_2 des xrefcodes an Dayforce. Je nach Typ müssen im Export unterschiedliche Logiken angewendet werden. 1 = 15 Min; 2 = Tageswerte',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SSM_XREFCODE PRIMARY KEY (mandant_id, dayforce_xrefcode) NOT ENFORCED
)  COMMENT = 'VIS - Sollstundenmodell - Die Tabelle ist eine_2 Lookup-Tabelle für ssm_xrefcodes. Sie enthält die Verteilung der Planstundenanpassung auf die zugrundeliegenden Prozesse.';
