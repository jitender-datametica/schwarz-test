--==============================================================
-- Table: werbemittel_art_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbemittel_art_spr_zu_1
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:44:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbemittel_art_spr_zu_1 (
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
werbemittel_art_id STRING(4) NOT NULL OPTIONS(description='Werbemittelart'),
werbemittel_art_bez STRING(30) OPTIONS(description='Bezeichnung Werbemittelart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='means where a promotion is shown (name to werbemittel art_1 ID)  - Werbemittelart          Example: Print (Leaflet), Radio, TV');