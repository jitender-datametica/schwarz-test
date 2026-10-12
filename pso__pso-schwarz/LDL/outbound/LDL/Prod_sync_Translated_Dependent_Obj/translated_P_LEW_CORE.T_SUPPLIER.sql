DROP TABLE IF EXISTS ldl_p_lew_core.t_supplier;
CREATE OR REPLACE TABLE ldl_p_lew_core.t_supplier (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
sup_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key SUPPLIER'),
src_lifnr STRING(20)
OPTIONS(description='Lieferantennumer (SAP Retail); SAP-Retail: lfa1.lifnr; SAP-BW: t_bw_0vendor_attr.lifnr; ELWIS: t_h_sup.sup_id'),
src_supplier_id INTEGER OPTIONS(description='Lieferanten-ID (WAWI-DWH); supplier_id'),
src_orig_supplier_nr STRING(20) OPTIONS(description='Lieferantennumer (WAWI); orig_supplier_nr  '),
sup_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Lieferantenname; SAP-Retail: lfa1.name1; SAP-BW: t_bw_0vendor_attr.name1'),
tax_no_1 STRING(20)
OPTIONS(description='Steuernummer Teil 1; SAP-Retail: lfa1.stcd1; SAP-BW: t_bw_0vendor_attr.stcd1; ELWIS: t_s_sup.supplier_tax_cd'),
vat_ident_no STRING(20)
OPTIONS(description='Umsatzsteuernummer; SAP-Retail: lfa1.stceg; SAP-BW: t_bw_0vendor_attr.stceg; ELWIS: t_s_sup.vat_ident_nr'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (sup_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. SUPL; Lieferanten; \n             SAP-Retail: lfa1;\n             SAP-BW: t_bw_0vendor_attr;\n             ELWIS: t_s_sup;\n             WAWI: t_sup_supplier_skey, t_sup_supplier');