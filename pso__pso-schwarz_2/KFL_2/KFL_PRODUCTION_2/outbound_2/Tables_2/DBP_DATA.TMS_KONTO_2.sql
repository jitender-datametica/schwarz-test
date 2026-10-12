--==============================================================
-- Table: tms_konto_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_konto_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_konto_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_konto_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Kontos (Kontonummer). Aus plkto.konto_nr'),
tms_konto_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_konto_2 im Quellsystem. Aus plkto.kto_id'),
tms_konto_bez STRING(50) NOT NULL OPTIONS(description='Bezeichnung zum Konto_2'),
tms_konto_txt STRING(300) OPTIONS(description='Beschreibung des Kontos'),
tms_fibu_konto_cd STRING(20) OPTIONS(description='FIBU Konto_2 (aktuell 3-Letter-Code)'),
tms_kostenstelle_id BIGNUMERIC(38,0) OPTIONS(description='Kostenstelle'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_konto_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die Informationen über die Konten, einschließlich FIBU Konto_2 Code und Kostenstelle. Sie dient zur Differenzierung der Rechnungspositionen nach Kostenart. Aus der Quelle plkto (WANKO)');