--==============================================================
-- Table: arthiertyp_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: arthiertyp_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.arthiertyp_2 (
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
arthiertyp_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Artikelhierarchie'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (arthiertyp_id) NOT ENFORCED
)
OPTIONS(description='Typen der Artikelhierarchie - kennzeichnet zur Zeit_2 die zwei- oder dreistellige Warengruppenhierarchie');