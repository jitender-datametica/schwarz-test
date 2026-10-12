/* --------------------------------------------------------------------------------
   DDL for table: t_lil_retailer_descr_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LIL_RETAILER_DESCR_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the client',
   retailer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key RETAILER',
   lang_cd                             VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Sprache - Code',
   retailer_name                       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Einzelhaendler-Beschreibung',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',   
   CONSTRAINT PK_T_LIL_RETAILER_DESCR PRIMARY KEY (retailer_sid, lang_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Mehrsprachige Bezeichnungen fuer Einzelhaendler / -Gruppen';

