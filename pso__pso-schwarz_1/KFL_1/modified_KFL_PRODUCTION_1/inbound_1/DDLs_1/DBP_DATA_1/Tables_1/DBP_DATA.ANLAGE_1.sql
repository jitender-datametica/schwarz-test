--==============================================================
-- Table: anlage_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLAGE_1 (
   anlage_id                           VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Anlagen Hauptnummer aus anln1',
   anlage_sub_id                       INTEGER     NOT NULL COMMENT 'ID der Anlagen Unternummer aus anln2',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   buchungskreis_id                    INTEGER     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Anlagedatum aus dat_erstellung',
   in_lief_id                          INTEGER     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   eigentum_fg                         INTEGER     NOT NULL COMMENT 'Flag Eigentum aus eigkz. Wenn Eigentum, dann 1',
   anlage_id_alt                       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'ID der Herkunftsanlage, von der auf die Anlage_1 umgebucht wurde. Aus aibn1. Häufig leer, daher compression',
   anlage_sub_id_alt                   INTEGER     COMMENT 'Unternummer der Herkunftsanlage, von der auf die Anlage_1 umgebucht wurde. Aus aibn2',
   dat_erstellung_alt                  DATE             COMMENT 'Ursprüngliches Zugangsdatum der Anlage_1 im Bau / umgebucht. Aus aibdt',
   anlage_bez                          VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Anlaage, konkateniert aus den Feldern txt50 und txa50',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLAGE PRIMARY KEY (anlage_id, anlage_sub_id, mandant_id, buchungskreis_id) NOT ENFORCED
)  COMMENT = 'IMS - Anlagen-Stammdaten aus SAP IND anla';

