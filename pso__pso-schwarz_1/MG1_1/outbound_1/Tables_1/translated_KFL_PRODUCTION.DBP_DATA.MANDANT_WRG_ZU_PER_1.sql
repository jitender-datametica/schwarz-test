CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.MANDANT_WRG_ZU_PER_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
DAT_VON DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Beginn Gültigkeitsperiode.'),
DAT_BIS DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Ende Gültigkeitsperiode.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
VON_WRG_ID STRING(3)
OPTIONS(description='Währung, die vom Quellsystem kommt und für welche die on-the-fly Konvertierung stattfinden soll. Im Grunde die abgelöste Währung.\n            Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
UMRECHNUNGSKURS NUMERIC(29,5)
OPTIONS(description='Umrechnungskurs mit dem von Spalte von_wrg_id in wrg_id umgerechnet werden soll. In der Regel, der vom Land_1 offiziell verwendete Wechselkurs.'),
PRIMARY KEY (MANDANT_ID, WRG_ID, DAT_VON) NOT ENFORCED
)
OPTIONS(description='AIS - Tabelle hat mehrere Zwecke:\n             1. Historisierte Zuordnung von Währung zu Mandant. Wird herangezogen, sollte die Quelle zu währungsrelevanten Daten keine Währungsinformation liefern. (Das sollte eigentlich in der Tabelle mandant_1 passieren, aber die Umstellung ist zu aufwendig.)\n             2. Bildet im Backend die Basis für eine_1 automatische Währungskonvertierung bei Währungswechsel eines Landes und speichert dafür den vom Land_1 offiziell angegebenen Wechselkurs.\n             Nicht zu verwechseln mit der regulären Wechselkurstabelle kurs_1, in der auch die Konvertierung anders berechnet wird.');