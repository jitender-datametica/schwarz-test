/* --------------------------------------------------------------------------------
   DDL for table: t_supplier_coneg_country_hist
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_supplier_coneg_country_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferant/Kreditor; FK auf SUPPLIER; SAP-Retail: zmmx_coneg_cntry.lifnr; SAP-BW: z_ds_zmmx_coneg_country.lifnr'),
country_sid_conegot BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mitverhandelndes Land; FK auf COUNTRY; SAP-Retail: zmmx_coneg_cntry.conegot_country; SAP-BW: z_ds_zmmx_coneg_country.CONEGOT_COUNTRY'),
country_cd_conegot STRING(20)
OPTIONS(description='Mitverhandelndes Land; SAP-Retail: zmmx_coneg_cntry.conegot_country; SAP-BW: z_ds_zmmx_coneg_country.conegot_country'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferant/Land ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sup_sid, country_sid_conegot, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. SPCCH; Mitverhandelnde Lander zum Lieferantenstamm;             SAP-Retail: zmmx_coneg_cntry;             SAP-BW: z_ds_zmmx_coneg_country;             ELWIS: t_s_sup_co_negot_cntry;             WAWI: t_sup_supplier');