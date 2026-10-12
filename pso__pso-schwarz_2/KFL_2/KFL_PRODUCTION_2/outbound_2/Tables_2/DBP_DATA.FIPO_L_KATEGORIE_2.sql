--==============================================================
-- Table: fipo_l_kategorie_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_kategorie_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_kategorie_2 (
fipo_kategorie_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID einer FIPO-Kategorie aus dem Quellfeld kat_id'),
fipo_bereich_id BIGNUMERIC(38,0) OPTIONS(description='Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id'),
fipo_kategorie_nr BIGNUMERIC(38,0) OPTIONS(description='Sortierkriterium für die Kategorien- Quellfeld kat_nr'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_kategorie_id) NOT ENFORCED
)
OPTIONS(description='FIPO - Kategorien (Hierarchie: Prüfmodule-Bereiche-Kategorien-Prüfpunkte) - Quelltabelle kategorien');