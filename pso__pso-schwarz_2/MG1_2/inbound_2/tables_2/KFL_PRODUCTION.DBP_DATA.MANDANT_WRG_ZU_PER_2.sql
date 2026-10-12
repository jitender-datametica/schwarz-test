create or replace TABLE KFL_PRODUCTION.DBP_DATA.MANDANT_WRG_ZU_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR.',
	DAT_VON DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Beginn Gültigkeitsperiode.',
	DAT_BIS DATE NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Ende Gültigkeitsperiode.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	VON_WRG_ID VARCHAR(3) COMMENT 'Währung, die vom Quellsystem kommt und für welche die on-the-fly Konvertierung stattfinden soll. Im Grunde die abgelöste Währung.\n            Kurzbezeichnung der Währung, z.B. CZK, EUR.',
	UMRECHNUNGSKURS NUMBER(38,5) COMMENT 'Umrechnungskurs mit dem von Spalte von_wrg_id in wrg_id umgerechnet werden soll. In der Regel, der vom Land_2 offiziell verwendete Wechselkurs.',
	constraint PK_MANDANT_WRG_ZU_PER primary key (MANDANT_ID, WRG_ID, DAT_VON)
)COMMENT='AIS - Tabelle hat mehrere Zwecke:\n             1. Historisierte Zuordnung von Währung zu Mandant. Wird herangezogen, sollte die Quelle zu währungsrelevanten Daten keine Währungsinformation liefern. (Das sollte eigentlich in der Tabelle mandant_2 passieren, aber die Umstellung ist zu aufwendig.)\n             2. Bildet im Backend die Basis für eine_2 automatische Währungskonvertierung bei Währungswechsel eines Landes und speichert dafür den vom Land_2 offiziell angegebenen Wechselkurs.\n             Nicht zu verwechseln mit der regulären Wechselkurstabelle kurs_2, in der auch die Konvertierung anders berechnet wird.'
;