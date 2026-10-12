/* --------------------------------------------------------------------------------
   DDL for table: t_client_migration_per_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_client_migration_per_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH Land_1 Referenz'),
wawi_dwh_client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAWI-DWH Client-ID'),
elwis_dwh_ec_cd BIGNUMERIC(38,0) OPTIONS(description='ELWIS DWH ec_cd'),
migration_dat_valid_from DATE OPTIONS(description='Datum zu dem auf SAP-Retail migriert wurde'),
migration_dat_valid_to DATE
OPTIONS(description='Datum ab dem nicht mehr SAP-Retail als operatives System verwendet wurde'),
active_fg BIGNUMERIC(38,0) OPTIONS(description='client laeuft aktuell auf SAP-Retail'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_create DATETIME NOT NULL OPTIONS(description='Erstellungszeitpunkt des Datensatzes'),
dwh_upd DATETIME NOT NULL OPTIONS(description='Updatezeitpunkt des Datensatzes'),
PRIMARY KEY (wawi_dwh_client_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Gibt an, ob ein Lidl-Land_1 schon auf SAP-Retail laeuft (oder auf WAWI);             vorgesehen auf F_LEW_PROCESS.t_sap_migration_client_1 umzuziehen!             vgl. f_lew_process.t_sap_migration_wh_1');