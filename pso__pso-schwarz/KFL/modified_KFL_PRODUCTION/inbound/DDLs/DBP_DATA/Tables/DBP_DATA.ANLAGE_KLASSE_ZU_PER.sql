--==============================================================
-- Table: anlage_klasse_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_klasse_zu_per
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLAGE_KLASSE_ZU_PER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   anlage_id                           VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Anlagen Hauptnummer aus anln1',
   anlage_sub_id                       INTEGER     NOT NULL COMMENT 'ID der Anlagen Unternummer aus anln2',
   buchungskreis_id                    INTEGER     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem die Zuordnung gültig ist',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem die Zuordnung gültig ist. Bei aktiven Zuordnungen ist der 31.12.9999 eingetragen',
   anlage_klasse_id                    VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Anlageklasse aus der Quelle anlkl. Als Char-Feld mit führenden Nullen gespeichert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLAGE_KLASSE_ZU_PER PRIMARY KEY (anlage_id, anlage_sub_id, buchungskreis_id, dat_von, mandant_id) NOT ENFORCED
)  COMMENT = 'IMS - im DWH historisierte Zuordnung zwischen anlage und anlage_klasse';

