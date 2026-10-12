--==============================================================
-- Table: wbs_art_wup_referenz_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_wup_referenz_typ_spr_zu_1
   generated from Powerdesigner on Montag, 2. Oktober 2023 10:54:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_art_wup_referenz_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Sprache, in der der Artikel_1-Markt Referenztyp angezeigt wird.'),
wbs_art_wup_ref_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1-Markt Referenztyp ID:            1 - gleicher Artikel_1, gleicher Markt            2 - anderer Artikel_1, gleicher Markt            3 - gleicher Artikel_1, anderer Markt            4 - anderer Artikel_1, anderer Markt'),
wbs_art_wup_ref_typ_bez STRING(100) NOT NULL
OPTIONS(description='Artikel_1-Markt Referenztyp Beschreibung            1 - gleicher Artikel_1, gleicher Markt            2 - anderer Artikel_1, gleicher Markt            3 - gleicher Artikel_1, anderer Markt            4 - anderer Artikel_1, anderer Markt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, wbs_art_wup_ref_typ_id) NOT ENFORCED
) OPTIONS(description='The table contains the description of the article-store reference types in different languages.');