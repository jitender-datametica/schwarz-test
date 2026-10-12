--==============================================================
-- Table: back_aufbereitung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_aufbereitung_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BACK_AUFBEREITUNG_SPR_ZU (
   back_aufbereitung_id                INTEGER     NOT NULL COMMENT 'eindeutige ID der Back-Aufbereitung aus dem Quellfeld ID, z.Bsp. 1',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   back_aufbereitung_bez               VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Aufbereitung aus dem Quellfeld bake_refining, z.Bsp. "Mit Salz bestreuen"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BACK_AUFBEREITUNG_SPR_ZU PRIMARY KEY (back_aufbereitung_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Sprachabhängige Bezeichnungen zur Back-Aufbereitung aus der SAP Z-Tabelle zek_bake_refin';

