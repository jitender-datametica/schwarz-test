create or replace TABLE KFL_PRODUCTION.DBP_DATA.RETAIL_COMPANY_2 (
	EXT_SYSTEM_NAME VARCHAR(50) NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
	EXT_RETAIL_COMPANY_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Einzelhändlers im externen System.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	RETAIL_COMPANY_CODE VARCHAR(50) NOT NULL COMMENT 'Code des Einzelhändlers, wie vom Quellsystem bereitgestellt.',
	RETAIL_COMPANY_NAME VARCHAR(50) NOT NULL COMMENT 'Name des Marktes.',
	COMPETITOR_FG NUMBER(38,0) NOT NULL COMMENT 'Flag, das angibt, ob es sich um ein Kaufland-Unternehmen (Wert 0) oder einen Mitbewerber (Wert 1) handelt.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_RETAIL_COMPANY primary key (EXT_SYSTEM_NAME, EXT_RETAIL_COMPANY_ID)
)COMMENT='Die Tabelle enthält 1 Zeile pro Markt. Einschließlich Kaufland und Wettbewerber.'
;