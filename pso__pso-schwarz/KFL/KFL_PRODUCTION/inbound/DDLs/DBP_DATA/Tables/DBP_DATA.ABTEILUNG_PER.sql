--==============================================================
-- Table: abteilung_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abteilung_per
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABTEILUNG_PER (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   kstabt_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID der Abteilungen nach Kostenstellen',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode',
   kstabt_bez                          VARCHAR(40)      NOT NULL COMMENT 'Bezeichnung der Abteilungen nach Kostenstellen',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   abt_id                              NUMBER(38,0)     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte ID''s, positive Werte: aus Stammdatensystem übernommen',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt
            ',
   dat_extrakt                         DATE             NOT NULL COMMENT 'Extraktions- bzw. Erstellungsdatum des Datensatzes',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABTEILUNG_PER PRIMARY KEY (mandant_id, kstabt_id, dat_von) NOT ENFORCED
)  COMMENT = 'VIS - Neue Abteilungstabelle, Zusammenführung der Kostenstellen-Abteilungen mit den TP1-Abteilungen. Soll die Tabellen abt und abt_spr_zu ersetzen.';

