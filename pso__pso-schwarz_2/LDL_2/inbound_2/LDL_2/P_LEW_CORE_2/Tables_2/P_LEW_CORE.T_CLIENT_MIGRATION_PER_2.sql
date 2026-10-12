/* --------------------------------------------------------------------------------
   DDL for table: t_client_migration_per_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CLIENT_MIGRATION_PER_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH Land_2 Referenz',
   wawi_dwh_client_id                  NUMBER(38,0)     NOT NULL COMMENT 'WAWI-DWH Client-ID',
   elwis_dwh_ec_cd                     NUMBER(38,0)     COMMENT 'ELWIS DWH ec_cd',
   migration_dat_valid_from            DATE             COMMENT 'Datum zu dem auf SAP-Retail migriert wurde',
   migration_dat_valid_to              DATE             COMMENT 'Datum ab dem nicht mehr SAP-Retail als operatives System verwendet wurde',
   active_fg                           NUMBER(38,0)     COMMENT 'client laeuft aktuell auf SAP-Retail',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_create                          TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Erstellungszeitpunkt des Datensatzes',
   dwh_upd                             TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Updatezeitpunkt des Datensatzes',   
   CONSTRAINT PK_T_CLIENT_MIGRATION_PER PRIMARY KEY (wawi_dwh_client_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Gibt an, ob ein Lidl-Land_2 schon auf SAP-Retail laeuft (oder auf WAWI);
             vorgesehen auf F_LEW_PROCESS.t_sap_migration_client_2 umzuziehen!
             vgl. f_lew_process.t_sap_migration_wh_2';

