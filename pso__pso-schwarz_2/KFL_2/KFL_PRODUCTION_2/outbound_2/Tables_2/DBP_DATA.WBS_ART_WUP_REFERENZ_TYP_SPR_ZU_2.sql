--==============================================================
-- Table: wbs_art_wup_referenz_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_wup_referenz_typ_spr_zu_2
   generated from Powerdesigner on Montag, 2. Oktober 2023 10:54:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_art_wup_referenz_typ_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Sprache, in der der Artikel_2-Markt Referenztyp angezeigt wird.'),
wbs_art_wup_ref_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2-Markt Referenztyp ID:            1 - gleicher Artikel_2, gleicher Markt            2 - anderer Artikel_2, gleicher Markt            3 - gleicher Artikel_2, anderer Markt            4 - anderer Artikel_2, anderer Markt'),
wbs_art_wup_ref_typ_bez STRING(100) NOT NULL
OPTIONS(description='Artikel_2-Markt Referenztyp Beschreibung            1 - gleicher Artikel_2, gleicher Markt            2 - anderer Artikel_2, gleicher Markt            3 - gleicher Artikel_2, anderer Markt            4 - anderer Artikel_2, anderer Markt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, wbs_art_wup_ref_typ_id) NOT ENFORCED
) OPTIONS(description='The table contains the description of the article-store reference types in different languages.');