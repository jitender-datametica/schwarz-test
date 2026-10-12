--==============================================================
-- Table: flw_lagerbew
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagerbew
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LAGERBEW (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   lagerbew_beleg_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung.',
   kj                                  INTEGER     NOT NULL COMMENT 'Kalenderjahr, Format JJJJ',
   vorgangsart_id                      VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Gibt einen Schlüssel zur Identifizierung einer Vorgangsart (z.B. WE für Wareneingang zur Bestellung) an. Quelle ist mkpf.vgart',
   dat_beleg                           DATE             NOT NULL COMMENT 'Das Belegdatum gibt das Ausstellungsdatum des Originalbeleges an. Quelle ist mkpf.bldat',
   dat_buch                            DATE             NOT NULL COMMENT 'Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung erfasst wird. Quelle ist mkpf.budat',
   dat_erfasst                         DATE             NOT NULL COMMENT 'Gibt das Datum an, an dem der Materialbeleg erfasst wurde. Quelle ist mkpf.cpudt',
   ref_lagerbew_beleg_id               VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Die Referenzbelegnummer  aus SAP XBLNR kann die Belegnummer beim Geschäftspartner enthalten. Quelle ist mkpf.xblnr. Compress -1',
   zeit_erfasst                        INTEGER     NOT NULL COMMENT 'Zeitpunkt der Datenerfassung aus cputm',
   belegkopftext                       VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Belegkopftext aus bktxt. Compress blank',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LAGERBEW PRIMARY KEY (mandant_id, lagerbew_beleg_id, kj) NOT ENFORCED
)  COMMENT = 'FLW - Lagerbewegungen Kopfdaten aus Quelle SAP mkpf';

