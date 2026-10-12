--==============================================================
-- Table: flw_maschine_messung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_maschine_messung_2
   generated from Powerdesigner on Mittwoch, 3. April 2024 16:03:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_maschine_messung_2 (
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
maschine_name STRING(50) NOT NULL
OPTIONS(description='Name of the machine in the meat processing plant for which the measurement is about.'),
maschinenteil_name STRING(50) NOT NULL
OPTIONS(description='Name of the part of the machine in the meat processing plant for which the measurement is about. (Pasteurizer/Cooler)'),
datzeit_messung DATETIME NOT NULL OPTIONS(description='Timestamp when the measurement is taken'),
rezept_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of the recipe that was performed by the machine when the measurement was taken'),
betriebsart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mode in which the machine was when the measurement was taken'),
pasteur_stoerung_id BIGNUMERIC(38,0)
OPTIONS(description='ID of a possible error from the pasteurizer machine. (These error IDs are not aligned with other error codes existing as of Nov 2023 in FLW - they are not flw_prodfehler_code_id)'),
rezept_name STRING(50)
OPTIONS(description='Name of the recipe that was performed by the machine when the measurement was taken'),
dauer_durchlaufzeit_sek BIGNUMERIC(38,0)
OPTIONS(description='Duration of the process (for how long the recipe was performing) at the time of the measurement'),
unten_soll_temp BIGNUMERIC(38,0)
OPTIONS(description='Target temperature at the top/ceiling of the machine part (in Celsius)'),
oben_soll_temp BIGNUMERIC(38,0)
OPTIONS(description='Target temperature at the bottom/floor of the machine part (in Celsius)'),
unten_ist_temp BIGNUMERIC(38,0)
OPTIONS(description='Measured temperature at the top/ceiling of the machine part  (in Celsius)'),
oben_ist_temp BIGNUMERIC(38,0)
OPTIONS(description='Measured temperature at the bottom/floor of the machine part  (in Celsius)'),
unten_ventilator_proz BIGNUMERIC(38,0)
OPTIONS(description='Fan performance (as percent 0-100) at the top/ceiling of the machine part'),
oben_ventilator_proz BIGNUMERIC(38,0)
OPTIONS(description='Fan performance (as percent 0-100) at the bottom/floor of the machine part'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (werk_id, maschine_name, maschinenteil_name, datzeit_messung, rezept_nr, betriebsart_id) NOT ENFORCED
)
OPTIONS(description='Table contains data for measurements from sensors of machines in the meat processing plants. As initial version of this table (Nov 2023) it contains data only for Pasteurizer machine sensors, Future alterations are possible if more sources are added ');