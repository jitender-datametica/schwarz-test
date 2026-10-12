--==============================================================
-- Table: flw_pruefmerkmal_vorgabe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruefmerkmal_vorgabe_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PRUEFMERKMAL_VORGABE_2 (
   prueflos_id                         INTEGER     NOT NULL COMMENT 'Eindeutige Prüflosnummer aus prueflos',
   merkmal_lfd_nr                      INTEGER     NOT NULL COMMENT 'Prüfmerkmalsnummer aus merknr',
   knoten_lfd_nr                       INTEGER     NOT NULL COMMENT 'Laufende Knotenummer aus Auftragszähler APLZL aus vorglfnr. Aussage über den Arbeitsplatz: 1= Wareneingang, 2 = Labor',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   stp_merkmal_id                      INTEGER     NOT NULL COMMENT 'Stammprüfmerkmal aus verwmerkm. Entspricht mkmnr aus Tabelle qpmk',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart aus katalgart1',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PRUEFMERKMAL_VORGABE PRIMARY KEY (prueflos_id, merkmal_lfd_nr, knoten_lfd_nr, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Prüfmerkmal-Vorgaben aus qamv';

