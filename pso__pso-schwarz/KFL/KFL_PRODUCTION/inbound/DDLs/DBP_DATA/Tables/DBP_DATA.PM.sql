--==============================================================
-- Table: pm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pm
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:27:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PM (
   pm_id                               NUMBER(38,0)     NOT NULL COMMENT 'Preismodul, Wert von 1 bis 10',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprachschlüssel',
   pm_bez                              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Preismodul Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PM PRIMARY KEY (pm_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'Preismodul (bildet im DWH die Preiskategorie ab - es gibt 10 Preiskategorien)';
