--==============================================================
-- Table: crossdocking_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crossdocking_spr_zu_2
   generated from Powerdesigner on Dienstag, 1. April 2025 17:51:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CROSSDOCKING_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   crossdocking_id                     INTEGER     NOT NULL COMMENT 'ID des Umschlagplatzs bzw. Cross Docking Orts.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache. Referenz zu der Tabelle spr.',
   crossdocking_bez                    VARCHAR(200)     NOT NULL COMMENT 'Sprachabhängig Kurzbezeichnung des Umschlagplatzs bzw. Cross-Docking-Orts. Bsp "Wien Plattform" -  Lieferanten im Frische Bereich liefert an die Wien Plattform. Diese verteilt die Lieferung auf die Länder (VZ/Märkte). Weitere Cross Docking Orte sind noch nicht bekannt.(Stand: 24.03.2025)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CROSSDOCKING_SPR_ZU PRIMARY KEY (mandant_id, crossdocking_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnungen des Cross Docking Orts.';
