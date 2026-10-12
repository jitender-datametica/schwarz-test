--==============================================================
-- Table: lief_belegfluss_split_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lief_belegfluss_split_1
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:04:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LIEF_BELEGFLUSS_SPLIT_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   lief_beleg_id                       NUMBER(18,0)    NOT NULL COMMENT 'Verursachender Vertriebsbeleg',
   lief_beleg_gruppe_id                NUMBER(18,0)    NOT NULL COMMENT 'Gruppe_1',
   lief_beleg_pos_id                   NUMBER(18,0)    NOT NULL COMMENT 'Verursachende Position',
   lief_beleg_split_id                 NUMBER(18,0)    NOT NULL COMMENT 'Vertriebsbelegnummer',
   lief_beleg_split_pos_id             NUMBER(18,0)    NOT NULL COMMENT 'Vertriebsbelegnummer',
   split_fortschreibung_kz             VARCHAR(1)      COMMENT 'Fortschreibungskennzeichen',
   menge_lief_ist_lme                  NUMBER(18,3)    COMMENT 'Tatsächlich gelieferte Menge in Lagermengeneinheiten',
   split_lfd_nr_id                     NUMBER(38,0)    COMMENT 'Liefersplit: laufende Nummer des gewünschten Ergebnispakets',
   split_vorgang_id                    VARCHAR(4)      COMMENT 'Betriebswirtsch. Vorgang bei dem der Split vorgenommen wird',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Belegfluß nachträglicher Auslieferungssplit';