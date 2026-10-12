--==============================================================
-- Table: bvv_leistung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bvv_leistung_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bvv_leistung_spr_zu (
bvv_leist_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Schlüssel der Leistung'),
spr_id BIGNUMERIC(38,0) NOT NULL,
bvv_leist_bez STRING(80) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Leistung, z.Bsp. Planungsleistung'),
bvv_gewerk_bez STRING(80) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Gewerks, z.Bsp. Entwicklungs-/Beratungskosten'),
bvv_u_gewerk_bez STRING(80) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Unter-Gewerks, z.Bsp. Planungsleistung'),
bvv_immob_mob_bez STRING(80) COLLATE 'und:ci' OPTIONS(description='Bezeichnung, ob Immobilie/Mobilie '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bvv_leist_id, spr_id) NOT ENFORCED
) OPTIONS(description='IOS - BVV Lookup Tabelle der BVV-Leistungen. Initial befüllt, keine laufende Versorgung');