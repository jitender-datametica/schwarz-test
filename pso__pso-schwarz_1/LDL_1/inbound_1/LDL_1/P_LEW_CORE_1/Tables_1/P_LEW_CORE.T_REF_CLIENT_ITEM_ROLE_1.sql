/* --------------------------------------------------------------------------------
   DDL for table: t_ref_client_item_role_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_CLIENT_ITEM_ROLE_1 (
   client_system                       VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'System (SAP, WAWI...)',
   client_item_role_cd                 VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'PK',
   client_item_role                    VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Mutable description',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_CLIENT_ITEM_ROLE PRIMARY KEY (client_item_role_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Item_1 role in client;
             SAP : ZBA_0 : Bestellartikel - Konfigurationsmaterial
             SAP : ZBA_1 : Bestellartikel - Verkaufsvariante
             SAP : ZBA_2 : Bestellartikel - Logistische Variante
             SAP : ZSK : Sortierkarton - Stucklistenkopf
             SAP : ZEA : Einzelartikel
             WAWI : WAWI_SK : Sortierkarton';

