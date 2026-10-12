--==============================================================
-- Table: wbs_art_wup_referenz_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_wup_referenz_typ_spr_zu
   generated from Powerdesigner on Montag, 2. Oktober 2023 10:54:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_ART_WUP_REFERENZ_TYP_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache, in der der Artikel-Markt Referenztyp angezeigt wird.',
   wbs_art_wup_ref_typ_id              INTEGER     NOT NULL COMMENT 'Artikel-Markt Referenztyp ID:
            1 - gleicher Artikel, gleicher Markt
            2 - anderer Artikel, gleicher Markt
            3 - gleicher Artikel, anderer Markt
            4 - anderer Artikel, anderer Markt',
   wbs_art_wup_ref_typ_bez             VARCHAR(100)     NOT NULL COMMENT 'Artikel-Markt Referenztyp Beschreibung
            1 - gleicher Artikel, gleicher Markt
            2 - anderer Artikel, gleicher Markt
            3 - gleicher Artikel, anderer Markt
            4 - anderer Artikel, anderer Markt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_ART_WUP_REFERENZ_TYP_SPR_ZU PRIMARY KEY (mandant_id, spr_id, wbs_art_wup_ref_typ_id) NOT ENFORCED
)  COMMENT = 'The table contains the description of the article-store reference types in different languages.';
