--==============================================================
-- Table: vz_dispo_artikelstatus_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vz_dispo_artikelstatus_spr_zu_2
   generated from Powerdesigner on Montag, 6. Februar 2023 14:28:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vz_dispo_artikelstatus_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel.'),
vz_dispo_artikelstatus_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='VZ Dispo Artikelstatus.'),
vz_dispo_artikelstatus_bez STRING(60) OPTIONS(description='VZ Dispo Artikelstatus Bezeichnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, vz_dispo_artikelstatus_id) NOT ENFORCED
)
OPTIONS(description='Beschreibungen Artikelstatus im VZ in Bezug auf Disposition. Quelle = DD07V, DOMNAME =\'ZSCM_DC_ARTSTATUS\'.');