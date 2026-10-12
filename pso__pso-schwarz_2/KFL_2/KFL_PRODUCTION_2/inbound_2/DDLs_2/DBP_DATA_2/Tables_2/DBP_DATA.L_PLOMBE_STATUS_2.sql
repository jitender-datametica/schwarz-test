create or replace TABLE KFL_PRODUCTION_CLONE_GOOGLE_20260616_2300.DBP_DATA.L_PLOMBE_STATUS_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	PLOMBE_STATUS_ID NUMBER(18,0) NOT NULL COMMENT 'ID des Plomben-Status_2 / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_PLOMBE_STATUS primary key (MANDANT_ID, PLOMBE_STATUS_ID)
)COMMENT='Lookup-Tabelle für die Status_2- und Fehlercodes einer Plombe. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).'
;
