--==============================================================
-- Table: verrechfall
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verrechfall
   generated from Powerdesigner on Mittwoch, 2. März 2022 08:20:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.VERRECHFALL (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   verrechfall_id                      INTEGER    NOT NULL COMMENT 'Eindeutiger Schluessel der Verrechnungsfaelle, die auf einem Belos Vorgang basieren',
   belos_adresse_empfaenger_id         VARCHAR(40)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutiger Schlüssel zur Identifikation einer Belos Adresse',
   belos_vorgang_id                    INTEGER    NOT NULL COMMENT 'Im DWH generierte eindeutige ID für die Belos Vorgänge. Ein Belos Vorgang setzt sich aus einem Transportauftrag (Logistikdaten) und einer Sendung (Abrechnungsdaten).',
   verrechfallart_id                   VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutiges Kennzeichen der Arten der Verrechnungsfälle (z. B. Rechnung, Gutschrift)',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   storno_fg                           INTEGER    NOT NULL COMMENT 'Kennzeichnet die Stornierung eines Verrechnungsfalles (Storniert = 1)',
   betrag_pauschalfracht               NUMBER(29,2)    NOT NULL COMMENT 'Pasuchalbetrag fuer die Fracht.',
   betrag_fracht                       NUMBER(29,2)    NOT NULL COMMENT 'Betrag der Frachtkosten.',
   verrechfall_status_id               VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige Kennzeichnung eines Status eines Verrechnungsfalles oder Verrechnungsfallkosten (z..B. Abgerechnet, abgeschlossen)',
   belos_leistungsart_id               INTEGER    NOT NULL COMMENT 'ID der Leistungsart, 1, 2 oder 3',
   kunde_fg                            INTEGER    NOT NULL COMMENT 'Kennzeichen ob der Verrechnungsfall. einem Kunden oder einer Spedition zugeordnet (Kunde = 1)',
   fracht_satz_prz                     NUMBER(29,3)     COMMENT 'Pauschalfracht Prozentsatz',
   fracht_satz_prz_pro_einh            NUMBER(29,3)     COMMENT 'Pauschalfracht Prozentsatz pro Einheit',
   teilstrecke_nr                      INTEGER    COMMENT 'Kennzeichnet zusammen mit dem Belos Vorgang eine Teilstrecke für eine Sendung oder Transportauftrag eindeutig. Kann die Werte 1 oder 2 annehmen',
   belosart_fg                         INTEGER    NOT NULL COMMENT 'Zeigt an, ob es sich bei dem Datensatz um einen Distributions- oder Beschaffungsvorgang handelt',
   belos_adresse_rechnung_uid          INTEGER    COMMENT 'die eindeutige System-Id des Verrechnungspartners aus Sequence',
   belos_adresse_rechnung_id           VARCHAR(20)     COMMENT 'Eindeutiger Schlüssel zur Belos Adresse - Billing Partner',
   belos_adresse_rechnung_name         VARCHAR(30)     COMMENT 'der Name des Verrechnungspartners',
   belos_adresse_steuerung_uid         INTEGER    COMMENT 'die eindeutige System-Id des steuernden Partners aus Sequence',
   belos_adresse_steuerung_id          VARCHAR(20)     COMMENT 'Eindeutiger Schlüssel zur Belos Adresse - Steering Partner',
   belos_adresse_steuerung_name        VARCHAR(30)     COMMENT 'der Name des steuernden Partners',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VERRECHFALL PRIMARY KEY (mandant_id, verrechfall_id, belos_adresse_empfaenger_id) NOT ENFORCED
)  COMMENT = 'LIS - Die Tabelle enthaelt die Verrechnungsfaelle, die fuer eine Sendung angelegt werden (Rechnung bzw. Gutschrift fuer den Lieferenaten/Spediteur)';
