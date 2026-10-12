/* --------------------------------------------------------------------------------
   DDL for table: t_item_unit_of_measurement
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_unit_of_measurement (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel; FK auf ITEM; SAP-Retail: marm.matnr; SAP-BW: t_bw_z_ds_marm.matnr'),
uom_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh'),
uom_cd STRING(20) OPTIONS(description='Mengeneinheit; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh'),
log_var_cd STRING(20)
OPTIONS(description='Sammelartikel mit logistischen Varianten; SAP-Retail: marm.bflme_marm; SAP-BW: t_bw_z_ds_marm.bflme_marm; ELWIS: log_var_id'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, uom_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. IUOM; Mengeneinheiten zum Artikel;              SAP-Retail: marm;              SAP-BW: t_bw_z_ds_marm;             ELWIS: t_s_itm_quantity_unit;             WAWI: ');