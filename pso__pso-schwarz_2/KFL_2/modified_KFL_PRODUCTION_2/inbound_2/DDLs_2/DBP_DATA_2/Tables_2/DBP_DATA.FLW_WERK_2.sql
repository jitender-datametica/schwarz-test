--==============================================================
-- Table: flw_werk_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_werk_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_WERK_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   werk_nr                             VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'aus SAP übertragene ID im Format character für werks',
   werk_name                           VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Name des Werks aus werk1',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   flw_fg                              INTEGER     NOT NULL DEFAULT 0 COMMENT 'Wird mit 1 gefüllt, wenn das Werk für Fleischwerk relevant ist. Sonst = 0',
   buchungskreis_id                    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_WERK PRIMARY KEY (mandant_id, werk_id) NOT ENFORCED
)  COMMENT = 'FLW - Stammdaten der Werke aus t001w_2';

