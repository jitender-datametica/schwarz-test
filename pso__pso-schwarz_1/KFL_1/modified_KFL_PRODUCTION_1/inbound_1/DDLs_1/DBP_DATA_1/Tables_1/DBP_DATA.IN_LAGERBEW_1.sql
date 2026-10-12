--==============================================================
-- Table: in_lagerbew_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_lagerbew_1
   generated from Powerdesigner on Freitag, 17. März 2023 11:16:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_LAGERBEW_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   lagerbew_beleg_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung.',
   kj                                  INTEGER     NOT NULL COMMENT 'Kalenderjahr, Format JJJJ',
   dat_buch                            DATE             NOT NULL COMMENT 'Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_1 erfasst wird. Quelle ist mkpf.budat',
   dat_erfasst                         DATE             NOT NULL COMMENT 'Gibt das Datum an, an dem der Materialbeleg erfasst wurde. Quelle ist mkpf.cpudt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_LAGERBEW PRIMARY KEY (mandant_id, lagerbew_beleg_id, kj) NOT ENFORCED
)  COMMENT = 'BIS- Lagerbewegungen Kopfdaten aus Quelle SAP mkpf ';