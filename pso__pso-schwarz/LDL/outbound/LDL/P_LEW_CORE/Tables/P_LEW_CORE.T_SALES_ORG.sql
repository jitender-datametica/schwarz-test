/* --------------------------------------------------------------------------------
   DDL for table: t_sales_org
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_sales_org (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
sales_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SALES ORGANIZATION'),
src_vkorg STRING(20)
OPTIONS(description='Verkaufsorganisation; SAP-Retail: tvko.vkorg; SAP-BW: t_bw_0salesorg_attr.vkorg'),
sales_org_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung in Stiftungssprache; SAP-Retail: tvkot.vtext; SAP-BW: t_bw_0salesorg_text.txtlg'),
comp_sid BIGNUMERIC(38,0)
OPTIONS(description='Buchungskreis der Verkaufsorganisation; FK auf COMPANY; SAP-Retail: tvko.bukrs; SAP-BW: t_bw_0salesorg_attr.bukrs'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sales_org_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. SORG; Vertriebsorganisationen (VGES - Analogon) ;              SAP-Retail: tvko & tvkot;             SAP-BW: t_bw_0salesorg_attr & t_bw_0salesorg_text;             ELWIS: t_h_sales, t_s_sales');