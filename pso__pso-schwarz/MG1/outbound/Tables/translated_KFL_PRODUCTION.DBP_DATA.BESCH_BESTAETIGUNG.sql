CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BESCH_BESTAETIGUNG (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BESTAETIGUNG_LFD_NR INTEGER NOT NULL OPTIONS(description='Laufende Nummer der Bestätigung.'),
BEST_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. '),
BEST_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbeleg ID  der eindeutigen Identifikation der Bestellbelegpositionen.'),
LIEF_BELEG_ID INTEGER
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation des Lieferscheinlbelegs. '),
LIEF_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinlbeleg ID  der eindeutigen Identifikation der Lieferscheinbelegpositionen.'),
BESTAETIGUNG_TYP_ID STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel für die Art der Bestätigung.'),
DAT_BESTAETIGUNG DATE NOT NULL OPTIONS(description='Erstelldatum der Bestätigung'),
ZEIT_BESTAETIGUNG INTEGER NOT NULL OPTIONS(description='Erstellzeit der Bestätigung'),
DAT_LIEF_PLAN DATE NOT NULL OPTIONS(description='Geplantes Lieferdatum'),
MENGE_BESTAETIGUNG NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge des bestellten Materials, die zu dem Termin bestätigt wird.'),
ZEIT_LIEF_PLAN INTEGER NOT NULL OPTIONS(description='Geplante Lieferzeit'),
MENGE_DISPO NUMERIC(18,3) NOT NULL OPTIONS(description='Menge, die bei der Disposition bereits berücksichtigt ist.'),
EXT_BELEG_ID STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nummer, die der Absender der Bestätigung bei sich für diese Bestätigung vergeben hat.'),
SYSTEM_ID INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
KJ_LIEF_BELEG INTEGER OPTIONS(description='Kalenderjahr aus dem Lieferbelegdatum (besch_lief), Format JJJJ'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, BESTAETIGUNG_LFD_NR, BEST_BELEG_ID, BEST_BELEG_POS_ID) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Bestätigungen pro Bestellposition aus der SAP Quelle EKES hinterlegt. Diese Bestätigungen referenzieren pro Bestellposition die dazugehörige Lieferscheinposition. - MULTISET');