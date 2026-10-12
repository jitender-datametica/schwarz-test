--==============================================================
-- Table: flw_maschine_messung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_maschine_messung_2
   generated from Powerdesigner on Mittwoch, 3. April 2024 16:03:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MASCHINE_MESSUNG_2 (
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   maschine_name                       VARCHAR(50)      NOT NULL COMMENT 'Name of the machine in the meat processing plant for which the measurement is about.',
   maschinenteil_name                  VARCHAR(50)      NOT NULL COMMENT 'Name of the part of the machine in the meat processing plant for which the measurement is about. (Pasteurizer/Cooler)',
   datzeit_messung                     TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp when the measurement is taken',
   rezept_nr                           INTEGER     NOT NULL COMMENT 'Number of the recipe that was performed by the machine when the measurement was taken',
   betriebsart_id                      INTEGER     NOT NULL COMMENT 'Mode in which the machine was when the measurement was taken',
   pasteur_stoerung_id                 INTEGER     COMMENT 'ID of a possible error from the pasteurizer machine. (These error IDs are not aligned with other error codes existing as of Nov 2023 in FLW - they are not flw_prodfehler_code_id)',
   rezept_name                         VARCHAR(50)      COMMENT 'Name of the recipe that was performed by the machine when the measurement was taken',
   dauer_durchlaufzeit_sek             INTEGER     COMMENT 'Duration of the process (for how long the recipe was performing) at the time of the measurement',
   unten_soll_temp                     INTEGER     COMMENT 'Target temperature at the top/ceiling of the machine part (in Celsius)',
   oben_soll_temp                      INTEGER     COMMENT 'Target temperature at the bottom/floor of the machine part (in Celsius)',
   unten_ist_temp                      INTEGER     COMMENT 'Measured temperature at the top/ceiling of the machine part  (in Celsius)',
   oben_ist_temp                       INTEGER     COMMENT 'Measured temperature at the bottom/floor of the machine part  (in Celsius)',
   unten_ventilator_proz               INTEGER     COMMENT 'Fan performance (as percent 0-100) at the top/ceiling of the machine part',
   oben_ventilator_proz                INTEGER     COMMENT 'Fan performance (as percent 0-100) at the bottom/floor of the machine part',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MASCHINE_MESSUNG PRIMARY KEY (werk_id, maschine_name, maschinenteil_name, datzeit_messung, rezept_nr, betriebsart_id) NOT ENFORCED
)  COMMENT = 'Table contains data for measurements from sensors of machines in the meat processing plants. As initial version of this table (Nov 2023) it contains data only for Pasteurizer machine sensors, Future alterations are possible if more sources are added ';
