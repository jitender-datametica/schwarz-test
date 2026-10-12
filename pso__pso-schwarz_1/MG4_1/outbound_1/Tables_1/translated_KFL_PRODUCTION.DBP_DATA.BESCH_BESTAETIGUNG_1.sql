CREATE OR REPLACE TABLE kfl_production_dbp_data.besch_bestaetigung_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bestaetigung_lfd_nr INTEGER NOT NULL OPTIONS(description='Laufende Nummer der Bestätigung.'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. '),
best_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbeleg ID  der eindeutigen Identifikation der Bestellbelegpositionen.'),
lief_beleg_id INTEGER
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation des Lieferscheinlbelegs. '),
lief_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinlbeleg ID  der eindeutigen Identifikation der Lieferscheinbelegpositionen.'),
bestaetigung_typ_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel für die Art_1 der Bestätigung.'),
dat_bestaetigung DATE NOT NULL OPTIONS(description='Erstelldatum der Bestätigung'),
zeit_bestaetigung INTEGER NOT NULL OPTIONS(description='Erstellzeit der Bestätigung'),
dat_lief_plan DATE NOT NULL OPTIONS(description='Geplantes Lieferdatum'),
menge_bestaetigung NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge des bestellten Materials, die zu dem Termin bestätigt wird.'),
zeit_lief_plan INTEGER NOT NULL OPTIONS(description='Geplante Lieferzeit'),
menge_dispo NUMERIC(18,3) NOT NULL OPTIONS(description='Menge, die bei der Disposition bereits berücksichtigt ist.'),
ext_beleg_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nummer, die der Absender der Bestätigung bei sich für diese Bestätigung vergeben hat.'),
system_id INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
kj_lief_beleg INTEGER OPTIONS(description='Kalenderjahr aus dem Lieferbelegdatum (besch_lief_1), Format JJJJ'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestaetigung_lfd_nr, best_beleg_id, best_beleg_pos_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Bestätigungen pro Bestellposition aus der SAP Quelle EKES hinterlegt. Diese Bestätigungen referenzieren pro Bestellposition die dazugehörige Lieferscheinposition. - MULTISET');