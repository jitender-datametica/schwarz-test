--==============================================================
-- Table: werbemittel_art_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbemittel_art_spr_zu_2
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:44:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WERBEMITTEL_ART_SPR_ZU_2 (
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprachschlüssel',
   werbemittel_art_id                  VARCHAR(4)      NOT NULL COMMENT 'Werbemittelart',
   werbemittel_art_bez                 VARCHAR(30)     COMMENT 'Bezeichnung Werbemittelart',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'means where a promotion is shown (name to werbemittel art_2 ID)  - Werbemittelart
          Example: Print (Leaflet), Radio, TV';
