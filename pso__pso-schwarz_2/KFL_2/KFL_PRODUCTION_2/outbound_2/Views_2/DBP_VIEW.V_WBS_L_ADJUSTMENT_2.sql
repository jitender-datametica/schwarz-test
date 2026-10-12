CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_l_adjustment_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'),
adjustment_id
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.'),
adjustment_bez OPTIONS(description='Beschreibung der adjustment_id, z. B. Standard adjustment'))
OPTIONS(DESCRIPTION = `MIT DER ADJUSTMENT_ID KANN DER BENUTZER ENTSCHEIDEN, AUF WELCHE WEISE DIE NACHVERSORGUNG IN WBS TP1 BERECHNET WERDEN SOLL.0 = UDF&R: UDF BERECHNET DIE PROGNOSEN UND ÜBERGIBT SIE AN F&R1 = STANDARD ADJUSTMENT (WBS): WBS BERECHNET DIE NACHVERSORGUNGSMENGE UND STELLT SIE DEN BENUTZERN ALS PREX-UPLOAD ZUR VERFÜGUNG.2 = PLATZHALTER (STAND 28.03.2025)3 = EXTERNAL ADJUSTMENT: DIE SAP AUTODISPO ERRECHNET KEINE MENGEN. IN DIESEM FALL IST EINE_2 MANUELLE BESTELLANLAGE DURCH DAS LAND_2 NOTWENDIG. `)
AS SELECT mandant_id,
 adjustment_id,
 adjustment_bez
FROM kfl_production_dbp_data.wbs_l_adjustment_2;