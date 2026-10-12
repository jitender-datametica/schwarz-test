/* --------------------------------------------------------------------------------
   DDL for table: t_sales_org
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SALES_ORG CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   sales_org_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SALES ORGANIZATION',
   src_vkorg                           VARCHAR(20)      COMMENT 'Verkaufsorganisation; SAP-Retail: tvko.vkorg; SAP-BW: t_bw_0salesorg_attr.vkorg',
   sales_org_name                      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung in Stiftungssprache; SAP-Retail: tvkot.vtext; SAP-BW: t_bw_0salesorg_text.txtlg',
   comp_sid                            NUMBER(38,0)     COMMENT 'Buchungskreis der Verkaufsorganisation; FK auf COMPANY; SAP-Retail: tvko.bukrs; SAP-BW: t_bw_0salesorg_attr.bukrs',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SALES_ORG PRIMARY KEY (sales_org_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SORG; Vertriebsorganisationen (VGES - Analogon) ; 
             SAP-Retail: tvko & tvkot;
             SAP-BW: t_bw_0salesorg_attr & t_bw_0salesorg_text;
             ELWIS: t_h_sales, t_s_sales';

