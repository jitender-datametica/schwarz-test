CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_client_migration_per_2 (
client_id INTEGER NOT NULL OPTIONS(description='DWH Land_2 Referenz'),
wawi_dwh_client_id INTEGER NOT NULL OPTIONS(description='WAWI-DWH Client-ID'),
elwis_dwh_ec_cd INTEGER OPTIONS(description='ELWIS DWH ec_cd'),
migration_dat_valid_from DATE OPTIONS(description='Datum zu dem auf SAP-Retail migriert wurde'),
migration_dat_valid_to DATE
OPTIONS(description='Datum ab dem nicht mehr SAP-Retail als operatives System verwendet wurde'),
active_fg INTEGER OPTIONS(description='client laeuft aktuell auf SAP-Retail'),
dwh_create DATETIME NOT NULL OPTIONS(description='Erstellungszeitpunkt des Datensatzes'),
dwh_upd DATETIME NOT NULL OPTIONS(description='Updatezeitpunkt des Datensatzes'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
PRIMARY KEY (wawi_dwh_client_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Gibt an, ob ein Lidl-Land_2 schon auf SAP-Retail laeuft (oder auf WAWI);\n             vorgesehen auf F_LEW_PROCESS.t_sap_migration_client_2 umzuziehen!\n             vgl. f_lew_process.t_sap_migration_wh_2');