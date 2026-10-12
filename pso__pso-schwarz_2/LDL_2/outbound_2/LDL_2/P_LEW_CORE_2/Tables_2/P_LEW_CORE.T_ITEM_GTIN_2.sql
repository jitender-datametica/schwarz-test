/* --------------------------------------------------------------------------------
   DDL for table: t_item_gtin_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_gtin_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: mean.matnr;'),
uom_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mengeneinheit fuer Anzeige; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: mean.minh'),
src_lfnum STRING(20) NOT NULL
OPTIONS(description='Laufende Nummer - fuer jede neue GTIN einer item_sid/uom_sid Kombination wird (in SAP Retail) eine_2 neue Nummer vergeben; SAP-Retail: mean.lfnum'),
uom_cd STRING(20) OPTIONS(description='Mengeneinheit fuer Anzeige; SAP-Retail: mean.meinh'),
gtin STRING(20)
OPTIONS(description='Global Trade Item_2 Number (GTIN); SAP-Retail: mean.EAN11; SAP-BW: t_bw_z_ds_mean.ean11'),
gtin_type_cd STRING(20)
OPTIONS(description='Nummerntyp der Global Trade Item_2 Number; SAP-Retail: mean.EANTP; SAP-BW: t_bw_z_ds_mean.eantp'),
main_gtin_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen Haupt-GTIN; SAP-Retail: mean.hpean; SAP-BW: t_bw_z_ds_mean.hpean'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, uom_sid, src_lfnum) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. IGTI; Global Trade Item_2 Number(s) (GTIN) zum Artikel_2;              SAP-Retail: MEAN_2;             SAP-BW: t_bw_z_ds_mean;             ELWIS: t_s_itm_gtin;             WAWI: t_itm_ean');