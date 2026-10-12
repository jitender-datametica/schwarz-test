--==============================================================
-- Table: abt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abt
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abt (
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL OPTIONS(description='Mandant im DWH'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abt_id, arthiertyp_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Abteilung - oberste Stufe der Artikelhierarchie');