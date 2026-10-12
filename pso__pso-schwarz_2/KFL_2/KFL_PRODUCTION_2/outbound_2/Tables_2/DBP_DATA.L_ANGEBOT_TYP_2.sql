--==============================================================
-- Table: l_angebot_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_angebot_typ_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:45:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_angebot_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
angebot_typ_cd STRING(10) NOT NULL OPTIONS(description='Alphanumerischer Code des Angebotstyp.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_typ_cd) NOT ENFORCED
) OPTIONS(description='Lookuptabelle der möglichen Typen eines Angebotes.');