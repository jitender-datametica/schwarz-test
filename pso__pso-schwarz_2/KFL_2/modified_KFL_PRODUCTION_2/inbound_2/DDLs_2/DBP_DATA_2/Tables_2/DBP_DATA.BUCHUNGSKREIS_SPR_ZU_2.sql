--==============================================================
-- Table: buchungskreis_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: buchungskreis_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BUCHUNGSKREIS_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   buchungskreis_id                    INTEGER     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   buchungskreis_bez                   VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'In diesem Feld sind die Kurztexte für die Buchungskreise in Abhängigkeit von der Sprache hinterlegt.',
   strasse                             VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Strasse der Firma aus der Quelle adrc.street',
   plz                                 VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Postleitzahl aus adrc.postcode1',
   ort                                 VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Ort aus adrc.city1/city2',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BUCHUNGSKREIS_SPR_ZU PRIMARY KEY (mandant_id, buchungskreis_id, spr_id, system_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die spachabhängigen Kurztexte der Buchungskreise aus der SAP Tabelle T001_2 enthalten - MULTISET.';

