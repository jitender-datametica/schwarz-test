--==============================================================
-- Table: verrechfall_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verrechfall_2
   generated from Powerdesigner on Mittwoch, 2. März 2022 08:20:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verrechfall_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
verrechfall_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schluessel der Verrechnungsfaelle, die auf einem Belos Vorgang basieren'),
belos_adresse_empfaenger_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schlüssel zur Identifikation einer Belos Adresse'),
belos_vorgang_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierte eindeutige ID für die Belos Vorgänge. Ein Belos Vorgang setzt sich aus einem Transportauftrag_2 (Logistikdaten) und einer Sendung (Abrechnungsdaten).'),
verrechfallart_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiges Kennzeichen der Arten der Verrechnungsfälle (z. B. Rechnung, Gutschrift)'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
storno_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet die Stornierung eines Verrechnungsfalles (Storniert = 1)'),
betrag_pauschalfracht NUMERIC(18,2) NOT NULL OPTIONS(description='Pasuchalbetrag fuer die Fracht.'),
betrag_fracht NUMERIC(18,2) NOT NULL OPTIONS(description='Betrag der Frachtkosten.'),
verrechfall_status_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung eines Status_2 eines Verrechnungsfalles oder Verrechnungsfallkosten (z..B. Abgerechnet, abgeschlossen)'),
belos_leistungsart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Leistungsart, 1, 2 oder 3'),
kunde_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen ob der Verrechnungsfall. einem Kunden oder einer Spedition zugeordnet (Kunde = 1)'),
fracht_satz_prz NUMERIC(9,3) OPTIONS(description='Pauschalfracht Prozentsatz'),
fracht_satz_prz_pro_einh NUMERIC(9,3) OPTIONS(description='Pauschalfracht Prozentsatz pro Einheit'),
teilstrecke_nr BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichnet zusammen mit dem Belos Vorgang eine_2 Teilstrecke für eine_2 Sendung oder Transportauftrag_2 eindeutig. Kann die Werte 1 oder 2 annehmen'),
belosart_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zeigt an, ob es sich bei dem Datensatz um einen Distributions- oder Beschaffungsvorgang handelt'),
belos_adresse_rechnung_uid BIGNUMERIC(38,0)
OPTIONS(description='die eindeutige System-Id des Verrechnungspartners aus Sequence'),
belos_adresse_rechnung_id STRING(20) OPTIONS(description='Eindeutiger Schlüssel zur Belos Adresse - Billing Partner'),
belos_adresse_rechnung_name STRING(30) OPTIONS(description='der Name des Verrechnungspartners'),
belos_adresse_steuerung_uid BIGNUMERIC(38,0)
OPTIONS(description='die eindeutige System-Id des steuernden Partners aus Sequence'),
belos_adresse_steuerung_id STRING(20) OPTIONS(description='Eindeutiger Schlüssel zur Belos Adresse - Steering Partner'),
belos_adresse_steuerung_name STRING(30) OPTIONS(description='der Name des steuernden Partners'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, verrechfall_id) NOT ENFORCED
)
OPTIONS(description='LIS - Die Tabelle enthaelt die Verrechnungsfaelle, die fuer eine_2 Sendung angelegt werden (Rechnung bzw. Gutschrift fuer den Lieferenaten/Spediteur)');