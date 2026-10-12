/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_info_hist_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_purchase_info_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferant; FK auf SUPPLIER_1; SAP-Retail: a017.lifnr; SAP-BW: z_ds_a017.lifnr'),
pur_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Einkaufsorganisation (transitiv mit loc_sid); FK auf PURCHASE_ORG; SAP-Retail: a017.ekorg; SAP-BW: z_ds_a017.ekorg'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: a017.matnr; SAP-BW: z_ds_a017.matnr'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Betrieb; FK auf LOCATION_1; SAP-Retail: a017.werks; SAP-BW: z_ds_a017.werks'),
pur_cond_sid BIGNUMERIC(38,0) OPTIONS(description='Einkaufskondition; FK auf PURCHASE_COND; SAP-Retail: a017.knumh   '),
cond_type_cd STRING(20) NOT NULL
OPTIONS(description='Konditionstyp; SAP-Retail: a017.kschl; SAP-BW: z_ds_a017.kschl; ELWIS: t_s_pur_cond_a017.cond_type            '),
einfo_type_cd STRING(20)
OPTIONS(description='Typ des Einkaufsinfosatzes; (AK-Teil); SAP-Retail: a017.esokz; SAP-BW: z_ds_a017.esokz; ELWIS: t_s_pur_cond_a017.einfo_type            '),
application_cd STRING(20)
OPTIONS(description='Applikation; (AK-Teil - keine multiplen Attributsauspragungen); SAP-Retail: a017.kappl; SAP-BW: z_ds_a017.kappl; ELWIS: t_s_pur_cond_a017.cond_appl            '),
general_purchase_info_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichnet allgemeingultige Infosatze. Kommt der Satz aus SAP-Retail-Tabelle A018_1 ist das Flag zu setzen'),
active_from_dt DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn des Konditionssatzes; SAP-Retail: a017.datab; SAP-BW: z_ds_a017.datab; ELWIS: t_s_pur_cond_a017.access_valid_from_dat'),
active_to_dt DATE NOT NULL
OPTIONS(description='Gueltigkeitsende des Konditionssatzes; AK-Teil; SAP-Retail: a017.datbi; SAP-BW: z_ds_a017.datbi; ELWIS: t_s_pur_cond_a017.access_valid_to_dat'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Purchase Info ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sup_sid, item_sid, loc_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PUINH; Artikelinfosatz;             Verbindung zw. Einkaufsinfosaetzen (PINFO) und Kond-arten             SAP-Retail: a017_1 & a018_1;             SAP-BW: z_ds_a017 & z_ds_a018;             ELWIS: t_s_pur_cond_a017 & t_s_pur_cond_a018             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx');