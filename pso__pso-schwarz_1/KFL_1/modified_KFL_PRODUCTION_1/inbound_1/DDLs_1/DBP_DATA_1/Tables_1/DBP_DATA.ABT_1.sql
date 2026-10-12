--==============================================================
-- Table: abt_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abt_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABT_1 (
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   mandant_id                          INTEGER     NOT NULL DEFAULT 1 COMMENT 'Mandant_1 im DWH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABT PRIMARY KEY (abt_id, arthiertyp_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Abteilung - oberste Stufe der Artikelhierarchie';

