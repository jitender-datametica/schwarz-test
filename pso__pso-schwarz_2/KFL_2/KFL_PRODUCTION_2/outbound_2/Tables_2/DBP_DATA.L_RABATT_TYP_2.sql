--==============================================================
-- Table: l_rabatt_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rabatt_typ_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:40:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rabatt_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
rabatt_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Rabatt Typs. Gibt die Art_2 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, rabatt_typ_id) NOT ENFORCED
) OPTIONS(description='Lookuptabelle der möglichen Arten des gewährten Rabattes.');