/* --------------------------------------------------------------------------------
   DDL for table: t_item_sales_cond_known_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_sales_cond_known_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: zsdx_sales_price.matnr; SAP BW: zsdx_sales_price.matnr'),
uom_sid_sales BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Verkaufsmengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: zsdx_sales_price.vrkme; SAP BW: zsdx_sales_price.vrkme'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Betrieb; FK auf LOCATION_2; SAP-Retail: zsdx_sales_price.werks; SAP-BW: zsdx_sales_price.werks'),
comp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Buchungskreis; FK auf COMPANY; SAP-Retail: zsdx_sales_price.bukrs; SAP-BW: zsdx_sales_price.bukrs'),
cond_type_cd STRING(20) NOT NULL
OPTIONS(description='Konditionsart; SAP-Retail: zsdx_sales_price.kschl; SAP-BW: zsdx_sales_price.kschl'),
uom_sid_cond BIGNUMERIC(38,0)
OPTIONS(description='Konditionsmengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: zsdx_sales_price.kmein; SAP-BW: z_ds_zsdx_sales_price.kmein; ELWIS: t_s_itm_sales_condition.cond_uom_sid'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Wahrung; FK auf CURRENCY; SAP-Retail: zsdx_sales_price.waers; SAP-BW: zsdx_sales_price.waers'),
curr_cd STRING(20)
OPTIONS(description='Wahrungscode; SAP-Retail: zsdx_sales_price.waers; SAP-BW: zsdx_sales_price.waers'),
uom_cd_sales STRING(20)
OPTIONS(description='Verkaufsmengeneinheit; SAP BW: zsdx_sales_price.vrkme; SAP Retail: zsdx_sales_price.vrkme'),
uom_cd_cond STRING(20)
OPTIONS(description='Konditionsmengeneinheit; SAP-Retail: zsdx_sales_price.kmein; SAP-BW: z_ds_zsdx_sales_price.kmein; ELWIS: t_s_itm_sales_condition.cond_uom_sid'),
cond_val NUMERIC(18,5)
OPTIONS(description='Konditionsbetrag; SAP-Retail: zsdx_sales_price.kbetr; SAP-BW: zsdx_sales_price.kbetr; ELWIS Name: t_s_itm_sales_condition.gross_prcs'),
net_val NUMERIC(18,5)
OPTIONS(description='Nettopreis; SAP-Retail: zsdx_sales_price.net_price; SAP-BW: z_ds_zsdx_sales_price.net_price; ELWIS: t_s_itm_sales_condition.net_prcs'),
reason_price_modification STRING(20)
OPTIONS(description='Aenderungsgrund fuer Verkaufspreisaenderung; SAP-Retail: zsdx_sales_price.grund; SAP-BW: zsdx_sales_price.grund; ELWIS: t_s_itm_sales_condition.reason_prc_mod_cd'),
tax_rate NUMERIC(18,5)
OPTIONS(description='Steuersatz; SAP-Retail: zsdx_sales_price.mwst_rate; SAP-BW: zsdx_sales_price.mwst_rate; ELWIS: t_s_itm_sales_condition.vat_rate'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Verkaufskondition ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem loekn im Quellsystem wird dieser Status_2 angenommen; SAP-Retail: loekn; SAP-BW: loekn; ELWIS: del_fg'),
active_from_dt DATE NOT NULL
OPTIONS(description='Datum Gueltig Ab (default: 01.01.1900); SAP-Retail: zsdx_sales_price.datab; SAP-BW: z_ds_zsdx_sales_price.datab; ELWIS: t_s_itm_sales_condition.itm_valid_from_dat'),
active_to_dt DATE NOT NULL
OPTIONS(description='Datum Gueltig Bis; SAP-Retail: zsdx_sales_price.datbi; SAP-BW: zsdx_sales_price.datbi; ELWIS Name: t_s_itm_sales_condition.itm_valid_to_dat'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, loc_sid, comp_sid, uom_sid_sales, cond_type_cd, active_to_dt, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. ITSCH; Verkaufskonditionen/-preise;              SAP-Retail: zsdx_sales_price;              SAP-BW: t_bw_z_ds_zsdx_sales_price;             ELWIS: t_s_itm_sales_condition');