/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_record_qualifier_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_POS_RECORD_QUALIFIER_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   record_qualifier_id                 NUMBER(38,0)     NOT NULL COMMENT 'Record-Qualifier - ID',
   record_qualifier_descr              VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Record-Qualifier - Beschreibung',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_POS_RECORD_QUALIFIER PRIMARY KEY (client_id, record_qualifier_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Lookup-Tabelle fuer die record_qualifier_id aus SAP-CAR angelieferten Records;
             aktuell manuelle Befuellung';

