--==============================================================
-- Table: abteilung_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abteilung_per_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABTEILUNG_PER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   kstabt_id                           INTEGER     NOT NULL COMMENT 'ID der Abteilungen nach Kostenstellen',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode',
   kstabt_bez                          VARCHAR(40)      NOT NULL COMMENT 'Bezeichnung der Abteilungen nach Kostenstellen',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte ID''s, positive Werte: aus Stammdatensystem übernommen',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt
            ',
   dat_extrakt                         DATE             NOT NULL COMMENT 'Extraktions- bzw. Erstellungsdatum des Datensatzes',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABTEILUNG_PER PRIMARY KEY (mandant_id, kstabt_id, dat_von) NOT ENFORCED
)  COMMENT = 'VIS - Neue Abteilungstabelle, Zusammenführung der Kostenstellen-Abteilungen mit den TP1-Abteilungen. Soll die Tabellen abt_1 und abt_spr_zu_1 ersetzen.';

