create or replace view KFL_PRODUCTION_CLONE_GOOGLE_20260616_2300.DBP_VIEW.V_L_PLOMBE_STATUS_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	PLOMBE_STATUS_ID COMMENT 'ID des Plomben-Status_2 / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS.'
) COMMENT='Lookup-Tabelle für die Status_2- und Fehlercodes einer Plombe. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).'
 as 
    SELECT 
        mandant_id,
        plombe_status_id

FROM DBP_DATA.L_PLOMBE_STATUS_2 ;
