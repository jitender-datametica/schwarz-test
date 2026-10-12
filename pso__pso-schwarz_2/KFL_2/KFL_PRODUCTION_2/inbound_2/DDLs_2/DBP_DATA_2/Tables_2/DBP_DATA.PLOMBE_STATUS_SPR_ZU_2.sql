create or replace TABLE KFL_PRODUCTION_CLONE_GOOGLE_20260616_2300.DBP_DATA.PLOMBE_STATUS_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	PLOMBE_STATUS_ID NUMBER(18,0) NOT NULL COMMENT 'ID des Plomben-Status_2 / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	PLOMBE_STATUS_BEZ VARCHAR(200) NOT NULL COMMENT 'Sprechende Bezeichnung des Plomben-Status_2 (z.B. Unbekannte Plombe, Plombe fehlt) aus DDTEXT.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_PLOMBE_STATUS_SPR_ZU primary key (MANDANT_ID, PLOMBE_STATUS_ID, SPR_ID)
)COMMENT='Sprachabhängige Bezeichnungen für die Plomben-Status_2-Codes. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).'
;
