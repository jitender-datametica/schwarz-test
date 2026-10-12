CREATE OR REPLACE VIEW DBP_VIEW.V_L_SSM_XREFCODE_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,dayforce_xrefcode                        COMMENT 'Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce.'
  ,rate_nettoleistung_anpassung             COMMENT 'Prozentualer Anteil je dayforce_xrefcode an der Anpassung der Nettostunden.'
  ,dayforce_export_typ_cd                   COMMENT 'Export Typ PH Stunden_2 des xrefcodes an Dayforce. Je nach Typ müssen im Export unterschiedliche Logiken angewendet werden. 1 = 15 Min; 2 = Tageswerte'
)
COMMENT = 'VIS - Sollstundenmodell - Die Tabelle ist eine_2 Lookup-Tabelle für ssm_xrefcodes. Sie enthält die Verteilung der Planstundenanpassung auf die zugrundeliegenden Prozesse.'
 AS 
    SELECT 
        mandant_id,
        dayforce_xrefcode,
        rate_nettoleistung_anpassung,
        dayforce_export_typ_cd

FROM DBP_DATA.L_SSM_XREFCODE_2 ;