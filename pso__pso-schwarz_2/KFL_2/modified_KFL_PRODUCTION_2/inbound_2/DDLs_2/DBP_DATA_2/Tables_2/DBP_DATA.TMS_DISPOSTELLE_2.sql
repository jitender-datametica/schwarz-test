--==============================================================
-- Table: tms_dispostelle_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_dispostelle_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_DISPOSTELLE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_dispostelle_id                  INTEGER     NOT NULL COMMENT 'ID des Dispostelles. Auspldispst.dst_id',
   tms_dispostelle_name                VARCHAR(50)      NOT NULL COMMENT 'Dispostelle Name',
   lagernummer_id                      VARCHAR(4)       COMMENT 'Lagernummer der Dispostelle',
   bestand_tms_gp_id                   VARCHAR(30)      COMMENT 'TMS Geschäftspartner-ID des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.',
   bestand_tms_gp_typ_cd               VARCHAR(3)       COMMENT 'TMS Geschäftspartnertyp-Code des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_DISPOSTELLE PRIMARY KEY (mandant_id, system_id, tms_dispostelle_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält Informationen über die Dispositionsstellen innerhalb des Unternehmens. Diese Stellen sind verantwortlich für die Planung und Steuerung von Transportprozessen. Aus der Quelle pldispst (WANKO)';
