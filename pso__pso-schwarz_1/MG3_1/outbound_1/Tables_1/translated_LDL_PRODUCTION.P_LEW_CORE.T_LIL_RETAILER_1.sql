DROP TABLE IF EXISTS ldl_production_p_lew_core.t_lil_retailer_1;
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_lil_retailer_1 (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
retailer_sid INTEGER NOT NULL OPTIONS(description='unique identifier of the Retailer (surrogate key)'),
src_retailer_cd STRING(100) NOT NULL OPTIONS(description='Bezeichnung des Einzelhaendlers im Quellsystem'),
retailer_type_cd STRING(100) NOT NULL OPTIONS(description='A code uniquely identifying the retailer type'),
retailer_name STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='name of the retailer'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (retailer_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Einzelhaendler');