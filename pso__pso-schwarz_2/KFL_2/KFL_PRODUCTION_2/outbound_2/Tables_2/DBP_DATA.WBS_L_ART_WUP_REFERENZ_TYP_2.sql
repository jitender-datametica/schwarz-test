--==============================================================
-- Table: wbs_l_art_wup_referenz_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_art_wup_referenz_typ_2
   generated from Powerdesigner on Montag, 2. Oktober 2023 10:51:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_l_art_wup_referenz_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
wbs_art_wup_ref_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2-Markt Referenztyp ID:            1 - gleicher Artikel_2, gleicher Markt            2 - anderer Artikel_2, gleicher Markt            3 - gleicher Artikel_2, anderer Markt            4 - anderer Artikel_2, anderer Markt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wbs_art_wup_ref_typ_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='This is a looklp table for article reference types. WBS makes several comparisons with a future promotion regarding article and store (WUP_2 / Markt) and assigns them a reference type. The type of comparison applies to ART_ID with ART_ID_REF and WUP_ID with WUP_ID_REF.             Fuer eine_2 zukuenftige Aktion_2 eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion_2 und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel_2 und Markt der geplanten Aktion_2 sein. Der Referenztyp sagt aus um welche Art_2 von Vergleich es sich handelt:             1 - gleicher Artikel_2, gleicher Markt             2 - anderer Artikel_2, gleicher Markt             3 - gleicher Artikel_2, anderer Markt             4 - anderer Artikel_2, anderer Markt');