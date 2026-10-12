--==============================================================
-- Table: bvv_leistung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bvv_leistung_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BVV_LEISTUNG_SPR_ZU (
   bvv_leist_id                        INTEGER     NOT NULL COMMENT 'Schlüssel der Leistung',
   spr_id                              INTEGER     NOT NULL,
   bvv_leist_bez                       VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Leistung, z.Bsp. Planungsleistung',
   bvv_gewerk_bez                      VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Gewerks, z.Bsp. Entwicklungs-/Beratungskosten',
   bvv_u_gewerk_bez                    VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Unter-Gewerks, z.Bsp. Planungsleistung',
   bvv_immob_mob_bez                   VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung, ob Immobilie/Mobilie ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BVV_LEISTUNG_SPR_ZU PRIMARY KEY (bvv_leist_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - BVV Lookup Tabelle der BVV-Leistungen. Initial befüllt, keine laufende Versorgung';

