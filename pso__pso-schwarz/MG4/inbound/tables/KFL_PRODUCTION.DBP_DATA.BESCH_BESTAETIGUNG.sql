create or replace TABLE KFL_PRODUCTION.DBP_DATA.BESCH_BESTAETIGUNG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BESTAETIGUNG_LFD_NR NUMBER(38,0) NOT NULL COMMENT 'Laufende Nummer der Bestätigung.',
	BEST_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. ',
	BEST_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbeleg ID  der eindeutigen Identifikation der Bestellbelegpositionen.',
	LIEF_BELEG_ID NUMBER(18,0) COMMENT 'Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation des Lieferscheinlbelegs. ',
	LIEF_BELEG_POS_ID NUMBER(18,0) NOT NULL COMMENT 'Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinlbeleg ID  der eindeutigen Identifikation der Lieferscheinbelegpositionen.',
	BESTAETIGUNG_TYP_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Art der Bestätigung.',
	DAT_BESTAETIGUNG DATE NOT NULL COMMENT 'Erstelldatum der Bestätigung',
	ZEIT_BESTAETIGUNG NUMBER(38,0) NOT NULL COMMENT 'Erstellzeit der Bestätigung',
	DAT_LIEF_PLAN DATE NOT NULL COMMENT 'Geplantes Lieferdatum',
	MENGE_BESTAETIGUNG NUMBER(18,3) NOT NULL COMMENT 'Menge des bestellten Materials, die zu dem Termin bestätigt wird.',
	ZEIT_LIEF_PLAN NUMBER(38,0) NOT NULL COMMENT 'Geplante Lieferzeit',
	MENGE_DISPO NUMBER(18,3) NOT NULL COMMENT 'Menge, die bei der Disposition bereits berücksichtigt ist.',
	EXT_BELEG_ID VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Nummer, die der Absender der Bestätigung bei sich für diese Bestätigung vergeben hat.',
	SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT 7 COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	KJ_LIEF_BELEG NUMBER(38,0) COMMENT 'Kalenderjahr aus dem Lieferbelegdatum (besch_lief), Format JJJJ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BESCH_BESTAETIGUNG primary key (MANDANT_ID, BESTAETIGUNG_LFD_NR, BEST_BELEG_ID, BEST_BELEG_POS_ID)
)COMMENT='TP408_LVS - In dieser Tabelle sind die Bestätigungen pro Bestellposition aus der SAP Quelle EKES hinterlegt. Diese Bestätigungen referenzieren pro Bestellposition die dazugehörige Lieferscheinposition. - MULTISET'
;