/* --------------------------------------------------------------------------------
   DDL for table: t_item_missing_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_missing_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_missing_id NUMERIC(20,0) NOT NULL
OPTIONS(description='ID des Ereignisses; SAP-Retail: zlex023_mis_item.zz_mi_no; SAP-BW: t_odp_itm_missing._slash_bic_slash_zmmi_no; SAP-EWM: t_z_ds_mis_items.zz_mi_no'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: zlex023_mis_item.matnr; SAP-BW: t_odp_itm_missing.material; SAP-EWM: t_z_ds_mis_items.matnr'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Betrieb; FK auf LOCATION_2; SAP-Retail: zlex023_mis_item.werks; SAP-BW: t_odp_itm_missing.plant; SAP-EWM: t_z_ds_mis_items.lgnum'),
storage_loc_cd STRING(20)
OPTIONS(description='Lagerort; SAP-Retail: zlex023_mis_item.lgort; SAP-BW: t_odp_itm_missing.stor_loc; SAP-EWM: t_z_ds_mis_items.avlgrp'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Erfassungsdatum; SAP-Retail: zlex023_mis_item.zzerdat; SAP-BW: t_odp_itm_missing.erdat; SAP-EWM: t_z_ds_mis_items.zzaedat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, item_missing_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 9925 $. IMIH; Quelle: EDM / Text Datei;              SAP-Retail: zlex023_mis_item;             SAP-BW: t_odp_itm_missing;             ELWIS: t_s_itm_missing(_lookup);             SAP-EWM: t_z_ds_mis_items;             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx');