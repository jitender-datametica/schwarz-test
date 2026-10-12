--==============================================================
-- Table: abt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abt
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABT (
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   mandant_id                          INTEGER     NOT NULL DEFAULT 1 COMMENT 'Mandant im DWH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABT PRIMARY KEY (abt_id, arthiertyp_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Abteilung - oberste Stufe der Artikelhierarchie';

