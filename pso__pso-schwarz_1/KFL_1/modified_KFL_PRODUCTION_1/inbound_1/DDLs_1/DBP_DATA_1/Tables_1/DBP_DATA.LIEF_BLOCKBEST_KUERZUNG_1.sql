CREATE TABLE DBP_DATA.LIEF_BLOCKBEST_KUERZUNG_1 (
   MANDANT_ID                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   VERSANDSTELLE_ID                    VARCHAR(4)      NOT NULL COLLATE 'en-ci'  COMMENT 'Versandstelle/Warenannahmestelle',
   DAT_LIEF_WUNSCH                     DATE            NOT NULL COMMENT 'Lieferdatum der Position',
   LIEF_BELEG_ID                       INTEGER    NOT NULL COMMENT 'Vertriebsbelegnummer',
   LIEF_BELEG_POS_ID                   INTEGER    NOT NULL COMMENT 'Positionsnummer des Vertriebsbeleges',
   ART_ID                              INTEGER    COMMENT 'Artikelnummer',
   MENGE_BEST_KOLLI                    NUMBER(29,3)    COMMENT 'Bestellmenge',
   MENGE_LIEF_IST_KOLLI                NUMBER(29,3)    COMMENT 'Tatsächlich gelieferte Menge in Lagermengeneinheiten'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Enthält Kürzungen aus ZBLOCKBEST_SHORT';
