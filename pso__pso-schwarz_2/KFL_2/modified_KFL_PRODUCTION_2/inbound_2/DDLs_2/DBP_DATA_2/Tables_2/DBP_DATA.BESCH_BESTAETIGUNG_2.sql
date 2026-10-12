--==============================================================
-- Table: besch_bestaetigung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_bestaetigung_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_BESTAETIGUNG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   bestaetigung_lfd_nr                 INTEGER     NOT NULL COMMENT 'Laufende Nummer der Bestätigung.',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. ',
   best_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbeleg ID  der eindeutigen Identifikation der Bestellbelegpositionen.',
   lief_beleg_id                       INTEGER     COMMENT 'Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation des Lieferscheinlbelegs. ',
   lief_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinlbeleg ID  der eindeutigen Identifikation der Lieferscheinbelegpositionen.',
   bestaetigung_typ_id                 VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Art_2 der Bestätigung.',
   dat_bestaetigung                    DATE             NOT NULL COMMENT 'Erstelldatum der Bestätigung',
   zeit_bestaetigung                   INTEGER     NOT NULL COMMENT 'Erstellzeit der Bestätigung',
   dat_lief_plan                       DATE             NOT NULL COMMENT 'Geplantes Lieferdatum',
   menge_bestaetigung                  NUMBER(29,3)     NOT NULL COMMENT 'Menge des bestellten Materials, die zu dem Termin bestätigt wird.',
   zeit_lief_plan                      INTEGER     NOT NULL COMMENT 'Geplante Lieferzeit',
   menge_dispo                         NUMBER(29,3)     NOT NULL COMMENT 'Menge, die bei der Disposition bereits berücksichtigt ist.',
   ext_beleg_id                        VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Nummer, die der Absender der Bestätigung bei sich für diese Bestätigung vergeben hat.',
   system_id                           INTEGER     NOT NULL DEFAULT 7 COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   kj_lief_beleg                       INTEGER     COMMENT 'Kalenderjahr aus dem Lieferbelegdatum (besch_lief_2), Format JJJJ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_BESTAETIGUNG PRIMARY KEY (mandant_id, bestaetigung_lfd_nr, best_beleg_id, best_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die Bestätigungen pro Bestellposition aus der SAP Quelle EKES hinterlegt. Diese Bestätigungen referenzieren pro Bestellposition die dazugehörige Lieferscheinposition. - MULTISET';

