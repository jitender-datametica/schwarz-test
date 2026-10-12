--==============================================================
-- Table: flw_pruefmerkmal_vorgabe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruefmerkmal_vorgabe_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PRUEFMERKMAL_VORGABE_1 (
   prueflos_id                         NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige Prüflosnummer aus prueflos',
   merkmal_lfd_nr                      NUMBER(38,0)     NOT NULL COMMENT 'Prüfmerkmalsnummer aus merknr',
   knoten_lfd_nr                       NUMBER(38,0)     NOT NULL COMMENT 'Laufende Knotenummer aus Auftragszähler APLZL aus vorglfnr. Aussage über den Arbeitsplatz: 1= Wareneingang, 2 = Labor',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   stp_merkmal_id                      NUMBER(38,0)     NOT NULL COMMENT 'Stammprüfmerkmal aus verwmerkm. Entspricht mkmnr aus Tabelle qpmk',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart aus katalgart1',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PRUEFMERKMAL_VORGABE PRIMARY KEY (prueflos_id, merkmal_lfd_nr, knoten_lfd_nr, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Prüfmerkmal-Vorgaben aus qamv';

