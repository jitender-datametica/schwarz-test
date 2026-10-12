CREATE OR REPLACE VIEW kfl_production_dbp_view.v_plombe_status_spr_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
plombe_status_id
OPTIONS(description='ID des Plomben-Status_2 / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS'),
spr_id OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'), plombe_status_bez
OPTIONS(description='Sprechende Bezeichnung des Plomben-Status_2 (z.B. Unbekannte Plombe, Plombe fehlt) aus DDTEXT.'))
OPTIONS(DESCRIPTION = `Sprachabhängige Bezeichnungen für die Plomben-Status_2-Codes. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).`)
AS SELECT mandant_id,
 plombe_status_id,
 spr_id,
 plombe_status_bez
FROM dbp_data.plombe_status_spr_zu_2;