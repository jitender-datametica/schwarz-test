CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_mietvertrag_umsatzvereinbarung_per_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
mv_intreno STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
melderegel STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Klauselnummer der Melderegel'),
version STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Version einer Umsatzmeldung'),
kjmo INTEGER NOT NULL OPTIONS(description='Datum an dem die Umsatzmeldung eingegangen ist'),
rhythmus_art STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Rhythmusart'),
dat_meldungsintervall_von DATE NOT NULL OPTIONS(description='Beginn Meldungsintervall für Umsatzmietvertrag'),
dat_meldungsintervall_bis DATE NOT NULL OPTIONS(description='Ende Meldungsintervall für Umsatzmietvertrag'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Währungsschlüssel'),
umsatzkennung STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Umsatzkennung'),
nullumsatz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Umsatzmeldung mit Nullumsatz'),
umsatz_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Gemeldeter Nettoumsatz'),
umsatz_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Gemeldeter Bruttoumsatz'),
erfasser STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Erfasser'),
dat_ersterfassung DATE NOT NULL OPTIONS(description='Datum der Ersterfassung'),
dat_letzte_bearbeitung DATE NOT NULL OPTIONS(description='Datum der letzten Bearbeitung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjmo) NOT ENFORCED
) OPTIONS(description='IMMO - Mietvertrag Umsatzvereinbarungen Mieter - SAP REFX - VISRREPORT');