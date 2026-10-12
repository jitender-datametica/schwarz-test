--==============================================================
-- Table: belos_ladung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_ladung
   generated from Powerdesigner on Dienstag, 22. März 2022 09:54:05
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_LADUNG (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   belos_ladung_id                     INTEGER    NOT NULL COMMENT 'Eindeutiger Schlüssel für die Ladung eines Belos Vorgangs.',
   spedition_hub_id                    INTEGER    NOT NULL COMMENT 'Eindeutige ID eines Speditions-Hubs. Wird im DWH generiert',
   gewicht_gesamt                      NUMBER(29,3)    NOT NULL COMMENT 'Gesamtgewicht der Ladung',
   anzahl_auftrag                      INTEGER    NOT NULL COMMENT 'Anzahl der Auftraege fuer diese Ladung.',
   zusatz_spot                         VARCHAR(500)    COMMENT 'Zusatzfeld für Spotaufträge (Umnutzung des Felds FAHRER in der SST)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_LADUNG PRIMARY KEY (mandant_id, belos_ladung_id) NOT ENFORCED
)  COMMENT = 'LIS - Die Tabelle belos_ladung enthaelt die Informationen zu den Ladungen die im Rahmen der Transportauftraege angelegt werden.';
