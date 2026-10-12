--==============================================================
-- Table: l_tms_sortiment_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_sortiment_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_SORTIMENT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_sortiment_id                    INTEGER     NOT NULL COMMENT 'ID desSortiments. Aus plsortim.srtm_nr',
   tms_sortiment_lfd_nr                INTEGER     NOT NULL COMMENT 'SKey für die Tabelle l_tms_sortiment_2 im Quellsystem. Ausplsortim.srtm_id',
   tms_sortiment_bez                   VARCHAR(100)     NOT NULL COMMENT 'Bezeichnung zum TMS-Sortiment',
   temperaturgruppe_id                 INTEGER     COMMENT 'Temperaturgruppe des Sortiments',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_SORTIMENT PRIMARY KEY (mandant_id, system_id, tms_sortiment_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Waren für verschiedene Sortimente, z. B. Food, O&G, NonFood. Aus der Quelle plsortim (WANKO)';
