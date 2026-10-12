CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_retailer_type_1 (
retailer_type_cd STRING NOT NULL OPTIONS(description='A code uniquely identifying the retailer type'),
retailer_type_descr STRING(100) NOT NULL OPTIONS(description='A textual description for the retailer type'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (retailer_type_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the retailer type codes - mainly it is Retailer and Financial Group');