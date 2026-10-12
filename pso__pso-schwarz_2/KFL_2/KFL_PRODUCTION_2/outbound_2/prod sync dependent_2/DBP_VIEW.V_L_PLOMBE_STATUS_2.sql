CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_plombe_status_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
plombe_status_id
OPTIONS(description='ID des Plomben-Status_2 / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS.'))
OPTIONS(DESCRIPTION = `Lookup-Tabelle für die Status_2- und Fehlercodes einer Plombe. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).`)
AS SELECT mandant_id,
 plombe_status_id
FROM kfl_production_dbp_data.l_plombe_status_2;