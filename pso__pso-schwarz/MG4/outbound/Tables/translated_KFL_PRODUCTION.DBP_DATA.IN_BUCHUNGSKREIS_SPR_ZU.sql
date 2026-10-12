CREATE OR REPLACE TABLE kfl_production_dbp_data.in_buchungskreis_spr_zu (
buchungskreis_id INTEGER NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
buchungskreis_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Buchungskreises aus butxt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (buchungskreis_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMS - Sprachabhängige Bezeichnungen der Buchungskreise aus SAP Industrie. Quelle ist t001');