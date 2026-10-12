/* --------------------------------------------------------------------------------
   DDL for table: t_supplier_hist
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_supplier_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
sup_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SUPPLIER'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Betrieb; FK auf LOCATION; SAP-Retail: lfa1.werks; SAP-BW: t_bw_0vendor_attr.werks; ELWIS: t_s_sup.loc_id'),
country_sid_negot BIGNUMERIC(38,0)
OPTIONS(description='Mitverhandelndes Lidl-Land; FK auf COUNTRY; SAP-Retail: lfa1.zz_negot_country; SAP-BW: t_bw_0vendor_attr.zz_negot_country; ELWIS: t_s_sup.main_negot_cntry_id'),
addr_sid BIGNUMERIC(38,0)
OPTIONS(description='Adresse; FK auf ADRESS; SAP-Retail: lfa1.adrnr;  Adressnummer; SAP-BW: t_bw_0vendor_attr.adrnr'),
country_cd_negot STRING(20)
OPTIONS(description='Mitverhandelndes Land; SAP-Retail: lfa1.zz_negot_country; SAP-BW: t_bw_0vendor_attr.zz_negot_country; ELWIS: t_s_sup.main_negot_cntry_id'),
debtor_cd STRING(20)
OPTIONS(description='Debitornummer; SAP-Retail: lfa1.kunnr; SAP-BW: t_bw_0vendor_attr.kunnr; ELWIS: t_s_sup.cust_id; ELWIS: t_s_sup.'),
name_1 STRING(100) COLLATE 'und:ci'
OPTIONS(description='Lieferantenname; SAP-Retail: lfa1.name1; SAP-BW: t_bw_0vendor_attr.name1; ELWIS: t_s_sup_adr.name'),
int_location_no_1 BIGNUMERIC(38,0)
OPTIONS(description='Internationale Locationsnummer Teil 1; SAP-Retail: lfa1.bbbnr; SAP-BW: t_bw_0vendor_attr.bbbnr; ELWIS: t_s_sup.global_loc_nr_1'),
int_location_no_2 BIGNUMERIC(38,0)
OPTIONS(description='Internationale Locationnummber Teil 2; SAP-Retail: lfa1.bbsnr; SAP-BW: t_bw_0vendor_attr.bbsnr; ELWIS: t_s_sup.global_loc_nr_2'),
int_location_checking_no BIGNUMERIC(38,0)
OPTIONS(description='Prueffziffer der internationalen Locationnummber; SAP-Retail: lfa1.bubkz; SAP-BW: t_bw_0vendor_attr.bubkz; ELWIS: t_s_sup.global_loc_nr_chkd'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferant ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sup_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. SUPLH; Lieferanten;              SAP-Retail: lfa1;             SAP-BW: t_bw_0vendor_attr;             ELWIS: t_s_sup;             WAWI: t_sup_supplier;');