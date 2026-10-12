--==============================================================
-- Table: l_tms_treibstoff
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_treibstoff
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_treibstoff (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_treibstoff_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Treibstoffs (Nummer des Treibstoffs). Aus pltrst.trst_nr'),
tms_treibstoff_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_treibstoff im Quellsystem. Aus pltrst.trst_id'),
tms_treibstoff_bez STRING(50) NOT NULL OPTIONS(description='Bezeichnung zum Treibstoff'),
menge_einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Einheit des Treibstoffs  ("L" und "KWH" gibt es auch in SAP)'),
menge_co2_pro_einheit NUMERIC(9,2) OPTIONS(description='CO2-Emission pro verbrauchter Einheit in kg'),
menge_co2_aeq_pro_einheit NUMERIC(9,2) OPTIONS(description='CO2-Äquivalenzwert pro verbrauchter Einheit in Kg'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_treibstoff_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Speicherung von Informationen über verschiedene Kraftstoffarten, z. B. Diesel, Strom. Aus der Quelle pltrst (WANKO)');