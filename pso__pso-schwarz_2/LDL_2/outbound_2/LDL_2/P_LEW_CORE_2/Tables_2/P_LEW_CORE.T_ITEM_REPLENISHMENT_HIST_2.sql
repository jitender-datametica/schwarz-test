/* --------------------------------------------------------------------------------
   DDL for table: t_item_replenishment_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_replenishment_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: zmmx_v_wrpl_w001.matnr'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb; FK auf LOCATION_2; SAP-Retail: zmmx_v_wrpl_w001.werks'),
min_nominal_stock NUMERIC(18,5)
OPTIONS(description='Minimaler Sollbestand; SAP-Retail: zmmx_v_wrpl_w001.zz_hb_bme; SAP-BW: t_bw_z_ds_zmmx_v_wrpl_w001.zz_hb_bme'),
min_order_qty NUMERIC(18,5)
OPTIONS(description='Mindestbestellmenge/Basis-ME; SAP-Retail: zmmx_v_wrpl_w001.zz_mbm; SAP-BW: t_bw_z_ds_zmmx_v_wrpl_w001.zz_mbm'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnachschub ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, loc_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. DEPRECATED - use t_item_location_replenishment_info_hist_2 instead');