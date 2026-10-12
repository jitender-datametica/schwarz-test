CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_l_adjustment (mandant_id OPTIONS(description='Mandant im DWH.'),
adjustment_id
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.'),
adjustment_bez OPTIONS(description='Beschreibung der adjustment_id, z. B. Standard adjustment'))
OPTIONS(DESCRIPTION = `Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n2 = Platzhalter (Stand 28.03.2025)\n3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine manuelle Bestellanlage durch das Land notwendig. `)
AS SELECT mandant_id,
 adjustment_id,
 adjustment_bez
FROM kfl_production_dbp_data.wbs_l_adjustment;