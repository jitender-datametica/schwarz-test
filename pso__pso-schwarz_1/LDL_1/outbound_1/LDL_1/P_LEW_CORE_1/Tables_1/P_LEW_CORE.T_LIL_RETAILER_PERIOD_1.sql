CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_retailer_period_1 (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH-Mandant_1 / DWH slice'),
retailer_sid INTEGER NOT NULL OPTIONS(description='unique identifier of the Retailer (surrogate key)'),
period_sid INTEGER NOT NULL OPTIONS(description='unique identifier of the Period (surrogate key)'),
retailer_sid_parent INTEGER
OPTIONS(description='unique identifier of the parent "retailer", e.g. to which Financial Group a retailer belongs to'),
interface_name STRING(100) NOT NULL
OPTIONS(description='unique identifier of the interface, e.g. to which interface a retailer belongs to'),
deleted_fg INTEGER NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (retailer_sid, period_sid, interface_name) NOT ENFORCED
) OPTIONS(description='Zuordnungen für Retailer für eine_1 Periode (z.B. zu Financial Groups)');