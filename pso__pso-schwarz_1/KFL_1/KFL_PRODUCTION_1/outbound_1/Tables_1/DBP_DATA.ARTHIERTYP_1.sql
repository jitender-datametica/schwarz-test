--==============================================================
-- Table: arthiertyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: arthiertyp_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.arthiertyp_1 (
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
arthiertyp_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Artikelhierarchie'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (arthiertyp_id) NOT ENFORCED
)
OPTIONS(description='Typen der Artikelhierarchie - kennzeichnet zur Zeit_1 die zwei- oder dreistellige Warengruppenhierarchie');