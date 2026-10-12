--==============================================================
-- Table: immo_mietvertrag_umsatzvereinbarung_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietvertrag_umsatzvereinbarung_per_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MIETVERTRAG_UMSATZVEREINBARUNG_PER_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   mv_intreno                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Interner Schlüssel des Immobilienobjekts',
   melderegel                          VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Klauselnummer der Melderegel',
   VERSION                             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Version einer Umsatzmeldung',
   kjmo                                INTEGER     NOT NULL COMMENT 'Datum an dem die Umsatzmeldung eingegangen ist',
   rhythmus_art                        VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Rhythmusart',
   dat_meldungsintervall_von           DATE             NOT NULL COMMENT 'Beginn Meldungsintervall für Umsatzmietvertrag',
   dat_meldungsintervall_bis           DATE             NOT NULL COMMENT 'Ende Meldungsintervall für Umsatzmietvertrag',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Währungsschlüssel',
   umsatzkennung                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Umsatzkennung',
   nullumsatz                          VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Umsatzmeldung mit Nullumsatz',
   umsatz_netto                        NUMBER(29,2)     NOT NULL COMMENT 'Gemeldeter Nettoumsatz',
   umsatz_brutto                       NUMBER(29,2)     NOT NULL COMMENT 'Gemeldeter Bruttoumsatz',
   erfasser                            VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Erfasser',
   dat_ersterfassung                   DATE             NOT NULL COMMENT 'Datum der Ersterfassung',
   dat_letzte_bearbeitung              DATE             NOT NULL COMMENT 'Datum der letzten Bearbeitung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MIETVERTRAG_UMSATZVEREINBARUNG_PER PRIMARY KEY (mandant_id, mv_intreno, melderegel, VERSION, kjmo, rhythmus_art) NOT ENFORCED
)  COMMENT = 'IMMO - Mietvertrag Umsatzvereinbarungen Mieter - SAP REFX - VISRREPORT';
