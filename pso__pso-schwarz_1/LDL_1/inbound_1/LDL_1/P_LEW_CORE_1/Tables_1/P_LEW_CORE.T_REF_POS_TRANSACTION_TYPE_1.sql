/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_transaction_type_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_POS_TRANSACTION_TYPE_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   transaction_type_cd                 VARCHAR(20)      NOT NULL COMMENT 'SAP-CAR: /posdw/tranty/TRANSACTIONTYPECODE; siehe t_logf.transtypecode',
   transaction_type_descr              VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Beschreibung des POS Transaktionstyps in Stiftungssprache; SAP-CAR: /posdw/trantyt/DESCRIPTION',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_POS_TRANSACTION_TYPE PRIMARY KEY (client_id, transaction_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Lookup-Tab fuer die transactiontype_id aus SAP-CAR angelieferten Records;
             aktuell manuelle Befuellung
             SAP-CAR: /POSDW/TRANTY & /POSDW/TRANTYT;
             Hinweis: Tab vermutlich noch nicht korrekt: profiltype im Quellsystem Schlusselbestandteil';

