/* --------------------------------------------------------------------------------
   DDL for table: t_pinfo_detail_hist_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pinfo_detail_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
pinfo_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Einkaufsinfosatz-Header; FK auf PINFO HEADER; SAP-Retail: eine.infnr'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Betrieb; FK auf LOCATION_2; SAP-Retail: eine.werks; SAP-BW: zlex_v_bw_eine.werks'),
pur_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Einkaufsorganisation; FK auf PURCHASE ORG; SAP-Retail: eine.ekorg; SAP-BW: zlex_v_bw_eine.ekorg'),
brand_sid BIGNUMERIC(38,0)
OPTIONS(description='Marke; FK auf BRAND_2; SAP-Retail: eine.zzbrand; SAP-BW: zlex_v_bw_eine.zzbrand'),
pinfo_type_cd STRING(20) NOT NULL
OPTIONS(description='Typ des Einkaufsinfosatzes; SAP-Retail: eine.esokz; SAP-BW: zlex_v_bw_eine.esokz; eLWIS: t_s_einfo_cond.einfo_type'),
incoterm_1 STRING(20)
OPTIONS(description='Incoterm Teil 1; SAP-Retail: eine.inco1; SAP-BW: zlex_v_bw_eine.inco1; eLWIS: t_s_einfo_cond.inco_terms_1_cd'),
incoterm_2 STRING(100) COLLATE 'und:ci'
OPTIONS(description='Incoterm Teil 2; SAP-Retail: eine.inco2; SAP-BW: zlex_v_bw_eine.inco2; eLWIS: t_s_einfo_cond.inco_terms_2_cd'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Pinfo-Detail ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen; SAP-Retail: eine.loekz'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pinfo_sid, loc_sid, pur_org_sid, pinfo_type_cd, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PINDH;Einkaufsinfosatz - Einkaufsorganisationsdaten;             SAP-Retail: eine_2;             SAP-BW: zlex_v_bw_eine;             ELWIS: t_s_einfo_cond');