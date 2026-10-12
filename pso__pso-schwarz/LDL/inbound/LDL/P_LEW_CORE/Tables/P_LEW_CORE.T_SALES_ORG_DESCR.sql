/* --------------------------------------------------------------------------------
   DDL for table: t_sales_org_descr
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SALES_ORG_DESCR CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   sales_org_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Verkaufsorganisation; FK auf SALES ORG; SAP-Retail: tvkot.vkorg; SAP-BW: t_bw_0salesorg_text.key1',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE ; SAP-Retail: tvkot.spras; SAP-BW: t_bw_0salesorg_text.langu',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprache - Code; SAP-Retail: tvkot.spras; SAP-BW: t_bw_0salesorg_text.langu',
   sales_org_descr                     VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Verkaufsorganisation - Bezeichnung; SAP-Retail: tvkot.vtext; SAP-BW: t_bw_0salesorg_text.txtlg',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SALES_ORG_DESCR PRIMARY KEY (sales_org_sid, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SORD;Beschreibungen der Sales Organisationen (VGES); 
             SAP-Retail: tvkot;
             SAP-BW: t_bw_0salesorg_text;
             ELWIS: t_s_sales_descr';

