--==============================================================
-- Table: wg_zek_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_zek_zu
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:14:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.wg_zek_zu (
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wg_id, arthiertyp_id, mandant_id, zek_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - alle Warengruppen, die zu sehen ein Zentraleinkäufer berechtigt ist - MULTISET');