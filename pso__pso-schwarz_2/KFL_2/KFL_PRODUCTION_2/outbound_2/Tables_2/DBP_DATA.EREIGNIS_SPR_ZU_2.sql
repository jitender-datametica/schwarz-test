--==============================================================
-- Table: ereignis_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignis_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ereignis_spr_zu_2 (
ereignis_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ereignis_2 ID (fortlaufende Nummer)'),
ereignistyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ereignistyp_2 ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ereignis_bez_lang STRING(60) COLLATE 'und:ci'
OPTIONS(description='Langbezeichnung eines Ereignisses, z.Bsp.            Lang = Ostersonntag            Mittel = Ostern            Kurz = O'),
ereignis_bez_mittel STRING(60) COLLATE 'und:ci'
OPTIONS(description='Mittellangbezeichnung eines Ereignisses, z.Bsp.            Lang = Ostersonntag            Mittel = Ostern            Kurz = O'),
ereignis_bez_kurz STRING(60) COLLATE 'und:ci'
OPTIONS(description='Kurzbezeichnung eines Ereignisses, z.Bsp.            Lang = Ostersonntag            Mittel = Ostern            Kurz = O'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ereignis_id, ereignistyp_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Bezeichnung eines Ereignisses in den DWH-Sprachen');