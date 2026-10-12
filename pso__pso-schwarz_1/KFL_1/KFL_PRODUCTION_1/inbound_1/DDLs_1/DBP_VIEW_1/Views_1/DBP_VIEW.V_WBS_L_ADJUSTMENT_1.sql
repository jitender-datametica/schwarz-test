create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WBS_L_ADJUSTMENT_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	ADJUSTMENT_ID COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.',
	ADJUSTMENT_BEZ COMMENT 'Beschreibung der adjustment_id, z. B. Standard adjustment'
) COMMENT='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n2 = Platzhalter (Stand 28.03.2025)\n3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_1 manuelle Bestellanlage durch das Land_1 notwendig. '
 as 
    SELECT 
        mandant_id,
        adjustment_id,
        adjustment_bez

FROM DBP_DATA.WBS_L_ADJUSTMENT_1 ;
