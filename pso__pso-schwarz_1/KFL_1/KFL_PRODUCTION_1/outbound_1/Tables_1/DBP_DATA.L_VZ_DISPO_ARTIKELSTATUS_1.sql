--==============================================================
-- Table: l_vz_dispo_artikelstatus_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_vz_dispo_artikelstatus_1
   generated from Powerdesigner on Montag, 6. Februar 2023 14:27:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_vz_dispo_artikelstatus_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
vz_dispo_artikelstatus_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='VZ Dispo Artikelstatus.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vz_dispo_artikelstatus_id) NOT ENFORCED
)
OPTIONS(description='Lookup Artikelstatus im VZ in Bezug auf Disposition. Quelle = DD07V, DOMNAME =\'ZSCM_DC_ARTSTATUS\'.');