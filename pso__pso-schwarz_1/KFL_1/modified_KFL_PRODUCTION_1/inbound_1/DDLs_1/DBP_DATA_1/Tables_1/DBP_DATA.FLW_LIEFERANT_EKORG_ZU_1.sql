--==============================================================
-- Table: flw_lieferant_ekorg_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lieferant_ekorg_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LIEFERANT_EKORG_ZU_1 (
   flw_lief_id                         INTEGER     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT 'ID der Einkaufsorganisation aus ekorg',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LIEFERANT_EKORG_ZU PRIMARY KEY (flw_lief_id, einkaufsorganisation_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Zuordnung Lieferant zu Einkaufsorganisation aus lfm1_1';

