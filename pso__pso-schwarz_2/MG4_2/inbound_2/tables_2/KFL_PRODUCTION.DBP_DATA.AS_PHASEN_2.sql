create or replace TABLE KFL_PRODUCTION.DBP_DATA.AS_PHASEN_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	POSTEN_KZ_SAP VARCHAR(2) NOT NULL COMMENT 'Postenkennzeichen. Für Artikel_2, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert)',
	WTAG_PHASENBEGINN NUMBER(38,0) NOT NULL COMMENT 'Wochentag Phasenbeginn aus dem Quellfeld WEEKDAY (Montag = 1)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='AIS - Länderspezifische Einstellungen für Artikelauslistung - SAP RET - ZRS_RVCUST'
;