--==============================================================
-- Table: abrechnungsqualitaet_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abrechnungsqualitaet_2
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abrechnungsqualitaet_2 (
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bezugsmonat Rechnungdaten'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
einkaufsorganisation_id BIGNUMERIC(38,0)
OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
rechnung_anz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl im Bezugsmonat erfasster Rechnungen zum Lieferanten  gem. Erfassungsdatum, ohne Löschungen'),
rechnung_netto NUMERIC(18,4) OPTIONS(description='Summe der Rechnungen zum nettowert'),
rechnung_maschinell_anz BIGNUMERIC(38,0) OPTIONS(description='Anzahl maschinell gebuchter Rechnungen'),
rechnung_manuell_anz BIGNUMERIC(38,0) OPTIONS(description='Anzahl manuell gebuchter Rechnungen'),
belastungsanzeigen_anz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl im Bezugsmonat erfasster Belastungsanzeigen zum Lieferanten gem. Erfassungsdatum der BA '),
belastungsanzeigen_netto NUMERIC(18,4)
OPTIONS(description='Summe der im Bezugsmonat erfasstern Belastungsanzeigen zum Lieferanten gem. Erfassungsdatum der BA zum Nettowert '),
rueckbelastungsanzeigen_anz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl im Bezugsmonat erfasster Rückbelastungsanzeigen zum Lieferanten gem. Erfassungsdatum'),
rueckbelastungsanzeigen_netto NUMERIC(18,4)
OPTIONS(description='Wert im Bezugsmonat erfasster Rückbelastungsanzeigen zum Lieferanten gem. Erfassungsdatum zum Nettowert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kjmo, gp_id, system_id) NOT ENFORCED
)
OPTIONS(description='Aus der zentralen Rechnungsprüfung werden Informationen über Anzahl und Wert der Eingangrechnungen, maschineller und manueller Rechnungen sowie Belastungsanzeigen und Rückbelastungsanzeigen gespeichert');