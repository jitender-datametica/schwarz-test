/* --------------------------------------------------------------------------------
   DDL for table: t_item_type
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_TYPE CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_type_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM TYPE',
   src_mtart                           VARCHAR(20)      COMMENT 'Artikelart-Code (SAP-Retail); SAP-Retail: t134.mtart; SAP-BW: t_bw_0itm_type_text.mtart',
   item_type_name                      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Artikelart in Stiftungssprache; SAP-Retail: t134t.mtbez; SAP-BW: t_bw_0itm_type_text.txtlg',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_TYPE PRIMARY KEY (item_type_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ITYP; Artikel Art; Nebengruppierung des Atikels, die nicht zur Artikelhierarchie gehort
             SAP-Retail: T134; 
             SAP-BW: t_bw_0matl_type_text;
             ELWIS: t_r_pos_type_descr(?)';

