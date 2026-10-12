/* --------------------------------------------------------------------------------
   DDL for table: t_company
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_company (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
comp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key COMPANY'),
src_bukrs STRING(20)
OPTIONS(description='Quellsystemschluessel SAP-Retail: t001.bukrs; SAP-BW: t_bw_0comp_code_attr.bukrs'),
addr_sid BIGNUMERIC(38,0)
OPTIONS(description='Adresse; FK auf ADDRESS; SAP-Retail: t001.adrnr; SAP-BW: t_bw_0comp_code_attr.adrnr'),
comp_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Name der Firma; SAP-Retail: t001.butxt; SAP-BW: t_bw_0comp_code_attr.butxt'),
city STRING(100) COLLATE 'und:ci' OPTIONS(description='Ort; SAP-Retail: t001.ort01; SAP-BW: t_bw_0comp_code_attr.ort01'),
account_plan_cd STRING(20) OPTIONS(description='Kontenplan; SAP-Retail: T001.ktopl; SAP-BW: t_bw_0comp_code_attr.ktopl'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (comp_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. CMPY; Buchungskreise;              SAP-Retail: T001;              SAP-BW: t_bw_0comp_code_attr;             ELWIS: t_h_company');