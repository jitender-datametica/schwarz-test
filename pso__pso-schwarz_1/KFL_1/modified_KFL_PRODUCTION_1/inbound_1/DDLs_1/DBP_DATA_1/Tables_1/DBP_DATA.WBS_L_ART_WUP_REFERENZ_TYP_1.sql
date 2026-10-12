--==============================================================
-- Table: wbs_l_art_wup_referenz_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_art_wup_referenz_typ_1
   generated from Powerdesigner on Montag, 2. Oktober 2023 10:51:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_L_ART_WUP_REFERENZ_TYP_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   wbs_art_wup_ref_typ_id              INTEGER     NOT NULL COMMENT 'Artikel_1-Markt Referenztyp ID:
            1 - gleicher Artikel_1, gleicher Markt
            2 - anderer Artikel_1, gleicher Markt
            3 - gleicher Artikel_1, anderer Markt
            4 - anderer Artikel_1, anderer Markt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_L_ART_WUP_REFERENZ_TYP PRIMARY KEY (wbs_art_wup_ref_typ_id, mandant_id) NOT ENFORCED
)  COMMENT = 'This is a looklp table for article reference types. WBS makes several comparisons with a future promotion regarding article and store (WUP_1 / Markt) and assigns them a reference type. The type of comparison applies to ART_ID with ART_ID_REF and WUP_ID with WUP_ID_REF.
             Fuer eine_1 zukuenftige Aktion_1 eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion_1 und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel_1 und Markt der geplanten Aktion_1 sein. Der Referenztyp sagt aus um welche Art_1 von Vergleich es sich handelt:
             1 - gleicher Artikel_1, gleicher Markt
             2 - anderer Artikel_1, gleicher Markt
             3 - gleicher Artikel_1, anderer Markt
             4 - anderer Artikel_1, anderer Markt';
