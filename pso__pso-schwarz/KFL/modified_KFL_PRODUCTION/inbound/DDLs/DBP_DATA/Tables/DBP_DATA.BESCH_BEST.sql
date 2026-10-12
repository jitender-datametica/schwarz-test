--==============================================================
-- Table: besch_best
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_best
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_BEST (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   dat_best_beleg                      DATE             NOT NULL COMMENT 'Dieses Feld enthält das Belegdatum der Bestellung.',
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
   loesch_fg                           INTEGER     NOT NULL COMMENT 'Das loesch_fg enthält das Löschkennzeichen für diese Position, Wert 1 entspricht gelöscht.',
   nachbest_fg                         INTEGER     NOT NULL COMMENT 'Dieses Kennzeichen steuert beim Anlegen einer Bestellung, ob sie als Nachbestel-lung behandelt wird. Ist das Kennzeichen gesetzt, können aus dieser Bestellung ausschließlich Lieferungen generiert werden, die mit geringerer Priorität kommissioniert werden.',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT 'Einkaufsorganisation aus ekorg',
   kunde_id                            VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Kannfeld: Eingabe des Marktes der eine Veraenderung im Preis erhalten soll. Vom Normalpreis auf Sonderpreis oder umgekehrt.',
   dat_aenderung                       DATE             COMMENT 'Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.',
   wup_id                              INTEGER     COMMENT 'Verteilzentrum für die Bestellung (auf Kopfebene)',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   best_beleg_status_id                VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Status der Bestellung, z. B. C entspricht Bestellung aus Wareneingang',
   system_id                           INTEGER     NOT NULL DEFAULT 7 COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   empfaenger_wup_id                   INTEGER     COMMENT 'Bei dezentraler Bestellung ist dieser Wert mit dem Empfänger der Ware befüllt. Denormalisiert aus der Detailtabelle.',
   anz_pos_aktiv                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der nicht gelöschten Positionen aus der Detailtabelle. Denormalisiert',
   anz_pos_offen                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der noch nicht gelieferten Positionen aus der Detailtabelle. Nur nicht gelöschte. Denormalisiert',
   submi_id                            VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Submissionsnummer aus submi. Nummer oder Bezeichnung, die der Verwaltung mehrerer Anfragen oder Bestellungen dient.',
   ref_beleg_id_intern                 VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Interne Referenznummer des Kunden oder Lieferanten aus ihrez',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_BEST PRIMARY KEY (mandant_id, best_beleg_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die Kopfdaten der Bestellungen aus der SAP Tabelle EKKO enthalten.  - MULTISET';

