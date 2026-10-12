/* --------------------------------------------------------------------------------
   DDL for table: t_movement_type_detail_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MOVEMENT_TYPE_DETAIL_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   move_type_dtl_sid                   NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MOVEMENT TYPE DETAIL',
   src_bwart                           VARCHAR(20)      NOT NULL COMMENT 'Bewegungsart; SAP-Retail: T156T.BWART',
   src_sobkz                           VARCHAR(20)      NOT NULL COMMENT 'Sonderbestandskennzeichen: T156T.SOBKZ',
   src_kzbew                           VARCHAR(20)      NOT NULL COMMENT 'Bewegungskennzeichen: T156T.KZBEW',
   src_kzzug                           VARCHAR(20)      NOT NULL COMMENT 'Zugangskennzeichen: T156T.KZZUG',
   src_kzvbr                           VARCHAR(20)      NOT NULL COMMENT 'Verbrauchsbuchung: T156T.KZVBR',
   move_type_dtl_name                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Verbrauchsbuchung: T156T.BTEXT in Stiftungssprache',
   move_type_cd                        VARCHAR(20)      COMMENT 'Bewegungsart; SAP-Retail: T156T.BWART',
   special_stock_mark                  VARCHAR(20)      COMMENT 'Sonderbestandskennzeichen: T156T.SOBKZ',
   special_stock_label                 VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Sonderbestand - Beschreibung',
   move_indicator_mark                 VARCHAR(20)      COMMENT 'Bewegungskennzeichen: T156T.KZBEW',
   move_indicator_label                VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bewegungskennzeichen Beschreibung',
   receipt_indicator_mark              VARCHAR(20)      COMMENT 'Zugangskennzeichen: T156T.KZZUG',
   receipt_indicator_label             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Zugangskennzeichen - Beschreibung',
   consumption_posting_mark            VARCHAR(20)      COMMENT 'Verbrauchsbuchung: T156T.KZVBR',
   consumption_posting_label           VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Verbrauchsbuchung - Beschreibung',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MOVEMENT_TYPE_DETAIL PRIMARY KEY (move_type_dtl_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IMTD; Bewegungsart-Detail; 
             SAP-Retail: t156t;
             SAP-BW: z_ds_matd0005;
             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx';

