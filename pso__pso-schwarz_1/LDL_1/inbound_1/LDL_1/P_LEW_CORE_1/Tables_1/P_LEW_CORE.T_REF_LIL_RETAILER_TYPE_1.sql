CREATE TABLE P_LEW_CORE.t_ref_lil_retailer_type_1 COMMENT = 'This minor entity defines the retailer type codes - mainly it is Retailer and Financial Group'
(
      retailer_type_cd CHAR(2) NOT NULL COMMENT 'A code uniquely identifying the retailer type',
      retailer_type_descr VARCHAR(100) NOT NULL COMMENT 'A textual description for the retailer type',
      dwh_load_id INTEGER NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
      dwh_created TIMESTAMP(6) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
      dwh_updated TIMESTAMP(6) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung', 
CONSTRAINT PK_T_REF_LIL_RETAILER_TYPE PRIMARY KEY ( retailer_type_cd ));