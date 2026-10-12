create or replace view KFL_PRODUCTION_CLONE_GOOGLE_20260616_2300.DBP_VIEW.V_PLOMBE_STATUS_SPR_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	PLOMBE_STATUS_ID COMMENT 'ID des Plomben-Status / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS',
	SPR_ID COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
	PLOMBE_STATUS_BEZ COMMENT 'Sprechende Bezeichnung des Plomben-Status (z.B. Unbekannte Plombe, Plombe fehlt) aus DDTEXT.'
) COMMENT='Sprachabhängige Bezeichnungen für die Plomben-Status-Codes. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).'
 as 
    SELECT 
        mandant_id,
        plombe_status_id,
        spr_id,
        plombe_status_bez

FROM DBP_DATA.PLOMBE_STATUS_SPR_ZU ;
