--==============================================================
-- Table: anlage_kostenstelle_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_kostenstelle_zu_per_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLAGE_KOSTENSTELLE_ZU_PER_1 (
   anlage_id                           VARCHAR(20)      NOT NULL COMMENT 'ID der Anlagen Hauptnummer aus anln1',
   anlage_sub_id                       INTEGER     NOT NULL COMMENT 'ID der Anlagen Unternummer aus anln2',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   buchungskreis_id                    INTEGER     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode ',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem die Zuordnung gültig ist. Bei aktiven Zuordnungen ist der 31.12.9999 eingetragen',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COMMENT 'ID der Kostenstelle, z.Bsp. 9676-400',
   geschaeftsbereich_id                VARCHAR(4)       NOT NULL COMMENT 'Der Geschaeftsbereich ist eine_1 interne Organisationseinheit, fuer den eine_1 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLAGE_KOSTENSTELLE_ZU_PER PRIMARY KEY (anlage_id, anlage_sub_id, mandant_id, buchungskreis_id, dat_von) NOT ENFORCED
)  COMMENT = 'IMS - Historisierte Zuordnung der Kostenstelle zur Anlage_1 aus der SAP-Quelle anlz';

