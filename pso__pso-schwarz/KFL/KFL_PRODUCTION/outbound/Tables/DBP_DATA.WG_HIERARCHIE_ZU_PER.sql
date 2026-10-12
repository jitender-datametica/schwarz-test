--==============================================================
-- Table: wg_hierarchie_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_hierarchie_zu_per
   generated from Powerdesigner on Dienstag, 6. Februar 2024 09:01:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_hierarchie_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_hierarchie_ebene_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID der Ebene einer Warengruppenhierarchie'),
wg_hierarchie_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppen Hierarchie'),
wg_hierarchie_mutter_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Elternelements'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
dat_bis DATE NOT NULL OPTIONS(description='Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, arthiertyp_id, wg_hierarchie_ebene_id, wg_hierarchie_id, dat_von) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Stammdaten der Warengruppenhierarchien');