--==============================================================
-- Table: zek_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: zek_2
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:15:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ZEK_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   wbl_id                              INTEGER     COMMENT 'Warenbereichsleiter ID',
   zek_name                            VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Name des Zentraleinkäufers, verschiedene Ausprägungen, wie Nachname,Vorname, aber auch die Funktion, wie Pflanzen N.N',
   zek_abt_bez                         VARCHAR(20)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung einer Organisationseinheit, der ein Zentraleinkäufer zugeordnet ist. Quelle ist die Tabelle T024_2',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ZEK PRIMARY KEY (mandant_id, zek_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Zentraleinkäufer';
