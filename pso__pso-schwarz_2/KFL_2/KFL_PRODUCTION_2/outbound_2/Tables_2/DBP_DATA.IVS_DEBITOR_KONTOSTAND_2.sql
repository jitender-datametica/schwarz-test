--==============================================================
-- Table: ivs_debitor_kontostand_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ivs_debitor_kontostand_2
   generated from Powerdesigner on Montag, 26. Juli 2021 10:37:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_debitor_kontostand_2 (
debitor_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Debitors'),
abzug_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID fuer die Art_2 und Zeitpunkt des Datenabzugs.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr/Monat_2'),
mietvertrag_id STRING(20) COLLATE 'und:ci' DEFAULT '-1' NOT NULL OPTIONS(description='Entspricht mv_intreno aus IMMO'),
wup_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Marktnummer'),
buchungskreis_id BIGNUMERIC(38,0) OPTIONS(description='SAP Buchungskreis'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Waehrung'),
sonderhauptbuch_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Sonderhauptbuch Kennzeichen, momentan noch nicht befuellt.'),
summe_soll NUMERIC(18,4) OPTIONS(description='Sollseite des Debitorkontos'),
summe_haben NUMERIC(18,4) OPTIONS(description='Habenseite des Debitorkontos'),
saldo_vortrag NUMERIC(18,4)
OPTIONS(description='Saldo Vortrag (Saldo zu Beginn der Periode), Saldo_Vortrag = Saldo Soll (Vorperiode) - Saldo Haben (Vorperiode)'),
saldo_soll NUMERIC(18,4) OPTIONS(description='Kontosaldo Sollseite'),
saldo_haben NUMERIC(18,4) OPTIONS(description='Kontosaldo Habenseite'),
saldo_konto NUMERIC(18,4) OPTIONS(description='Gesamtsaldo des Kontos (Saldo Soll - Saldo Haben)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='IVS - Kontostand des Debitors');