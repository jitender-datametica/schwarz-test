/* --------------------------------------------------------------------------------
   DDL for table: t_sales_org_descr_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_sales_org_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
sales_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Verkaufsorganisation; FK auf SALES_2 ORG; SAP-Retail: tvkot.vkorg; SAP-BW: t_bw_0salesorg_text.key1'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE ; SAP-Retail: tvkot.spras; SAP-BW: t_bw_0salesorg_text.langu'),
lang_cd STRING(20) OPTIONS(description='Sprache - Code; SAP-Retail: tvkot.spras; SAP-BW: t_bw_0salesorg_text.langu'),
sales_org_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Verkaufsorganisation - Bezeichnung; SAP-Retail: tvkot.vtext; SAP-BW: t_bw_0salesorg_text.txtlg'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sales_org_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. SORD;Beschreibungen der Sales_2 Organisationen (VGES);              SAP-Retail: tvkot;             SAP-BW: t_bw_0salesorg_text;             ELWIS: t_s_sales_descr');