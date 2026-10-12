/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_org
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_purchase_org (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
pur_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PURCHASE ORGANIZATION'),
src_ekorg STRING(20) OPTIONS(description='Quellsystemschluessel SAP-Retail: t024E.EKORG'),
pur_org_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Einkaufsorganisation (in Stiftungssprache); SAP-Retail: t024E.EKOTX'),
comp_sid BIGNUMERIC(38,0) OPTIONS(description='Buchungskreis; FK auf COMPANY; SAP-Retail: t024E.BUKRS'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pur_org_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PORG; Einkaufsorganisationen;              SAP-Retail-Tabelle: t024E;             SAP-BW: t_bw_0purch_org_text;             ELWIS: t_s_pur_org_descr');