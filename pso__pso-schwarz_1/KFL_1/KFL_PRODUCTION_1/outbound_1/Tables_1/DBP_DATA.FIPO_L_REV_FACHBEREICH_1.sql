--==============================================================
-- Table: fipo_l_rev_fachbereich_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_rev_fachbereich_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_rev_fachbereich_1 (
rev_fb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Revisions-Fachbereichs aus rfb_id'),
aktiv_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zeigt an, ob es sich um einen gültigen Fachbereich handelt. Aus rfb_gueltig'),
rev_fb_bez STRING(60) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Fachbereichs aus rfb_fachbereich, z.Bsp. Filialrevision'),
rev_fb_kbez STRING(30) COLLATE 'und:ci'
OPTIONS(description='Kurzbezeichnung des Fachbereichs aus rfb_kuerzel, z.Bsp. FR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rev_fb_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookup Tabelle der Revisions-Fachbereiche aus der Quelltabelle rev_fachbereiche');