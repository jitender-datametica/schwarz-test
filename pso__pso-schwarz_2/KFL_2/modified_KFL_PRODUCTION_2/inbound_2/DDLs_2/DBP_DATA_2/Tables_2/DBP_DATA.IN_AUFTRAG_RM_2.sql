--==============================================================
-- Table: in_auftrag_rm_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftrag_rm_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:12:26
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_AUFTRAG_RM_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   auftrag_rm_id                       INTEGER     NOT NULL COMMENT 'ID der Rückmeldung aus rueck',
   auftrag_rm_pos_id                   INTEGER     NOT NULL COMMENT 'Positionsid der Rückmeldung aus rmzhl',
   auftrag_id                          VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   co_leistungsart_id                  VARCHAR(7)       COLLATE 'en-ci' COMMENT 'ID der CO-Leistungsart der Rückmeldung aus dem Quellfeld learr. Referenztabelle ist in_l_leistungsart_2',
   storno_fg                           INTEGER     NOT NULL COMMENT 'Flag = 1 für stornierten Beleg aus dem Quellfeld stokz',
   storno_zaehler                      INTEGER     NOT NULL COMMENT 'Rückmeldezähler der stornierten Rückmeldung aus dem Quellfeld stzhl',
   dat_buch                            DATE             NOT NULL COMMENT 'Buchungsdatum',
   teil_end_rm                         VARCHAR(1)       COMMENT 'Teil-/Endrückmeldung (X = Endrückmeldung, 1 = Automatische Endrückmeldung, leer = Teilrückmeldung)',
   menge_arbeit_ist                    NUMBER(29,5)     COMMENT 'Istarbeit - actual work done for this order',
   menge_arbeit_ist_einh_id            VARCHAR(3)       COMMENT 'istarbeit Masseinheit - unit_2 in which the actual work for this order is measured',
   datzeit_durchfuehrung_ende          TIMESTAMP_NTZ(9) COMMENT 'Rückgemeldeter Endzeitpunkt der Durchführung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_AUFTRAG_RM PRIMARY KEY (mandant_id, auftrag_rm_id, auftrag_rm_pos_id) NOT ENFORCED
)  COMMENT = 'LIS - Auftrags-Rückmeldungen aus der Quelle SAP Industrie afru';
