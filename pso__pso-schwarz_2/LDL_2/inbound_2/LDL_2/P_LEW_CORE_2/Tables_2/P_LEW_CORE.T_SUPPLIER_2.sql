create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_SUPPLIER_2 cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
	SUP_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key SUPPLIER_2',
	SRC_LIFNR VARCHAR(20) COMMENT 'Lieferantennumer (SAP Retail); SAP-Retail: lfa1.lifnr; SAP-BW: t_bw_0vendor_attr.lifnr; ELWIS: t_h_sup.sup_id',
	SRC_SUPPLIER_ID NUMBER(38,0) COMMENT 'Lieferanten-ID (WAWI-DWH); supplier_id',
	SRC_ORIG_SUPPLIER_NR VARCHAR(20) COMMENT 'Lieferantennumer (WAWI); orig_supplier_nr  ',
	SUP_NAME VARCHAR(100) COLLATE 'en-ci' COMMENT 'Lieferantenname; SAP-Retail: lfa1.name1; SAP-BW: t_bw_0vendor_attr.name1',
	TAX_NO_1 VARCHAR(20) COMMENT 'Steuernummer Teil 1; SAP-Retail: lfa1.stcd1; SAP-BW: t_bw_0vendor_attr.stcd1; ELWIS: t_s_sup.supplier_tax_cd',
	VAT_IDENT_NO VARCHAR(20) COMMENT 'Umsatzsteuernummer; SAP-Retail: lfa1.stceg; SAP-BW: t_bw_0vendor_attr.stceg; ELWIS: t_s_sup.vat_ident_nr',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_SUPPLIER primary key (SUP_SID)
)COMMENT='$Revision: 0000 $. SUPL; Lieferanten; \n             SAP-Retail: lfa1_2;\n             SAP-BW: t_bw_0vendor_attr;\n             ELWIS: t_s_sup;\n             WAWI: t_sup_supplier_skey, t_sup_supplier'
;
