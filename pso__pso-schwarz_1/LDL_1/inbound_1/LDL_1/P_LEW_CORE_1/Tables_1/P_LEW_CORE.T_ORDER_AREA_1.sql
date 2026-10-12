/* --------------------------------------------------------------------------------
   DDL for table: t_order_area_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ORDER_AREA_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1;',
   order_area_sid                      NUMBER(38,0)     NOT NULL COMMENT 'surrogate key; uniquely identifies a WH Order Area',
   src_ekgrp                           VARCHAR(20)      COMMENT 'techn. identifier of order area withinSAP Retail',
   src_bestbereichnr                   VARCHAR(20)      COMMENT 'techn. identifier of order area within WAWI',
   order_area_nr                       VARCHAR(20)      NOT NULL COMMENT 'business identifier of the order area (known to the business)',
   order_area_name                     VARCHAR(100)     COMMENT 'name describing the general order area - may or may not be overwritten within a WH',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ORDER_AREA PRIMARY KEY (order_area_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. General set of order areas ("Bestellbereiche") available. Caution: WHs may use just a subset of the order areas and define their own names for them';

