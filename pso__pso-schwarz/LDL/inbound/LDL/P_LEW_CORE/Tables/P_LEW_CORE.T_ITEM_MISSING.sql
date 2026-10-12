/* --------------------------------------------------------------------------------
   DDL for table: t_item_missing
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_MISSING (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_missing_id                     NUMBER(20,0)     NOT NULL COMMENT 'ID des Ereignisses; SAP-Retail: zlex023_mis_item.zz_mi_no; SAP-BW: t_odp_itm_missing._slash_bic_slash_zmmi_no; SAP-EWM: t_z_ds_mis_items.zz_mi_no',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel; FK auf ITEM; SAP-Retail: zlex023_mis_item.matnr; SAP-BW: t_odp_itm_missing.material; SAP-EWM: t_z_ds_mis_items.matnr',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb; FK auf LOCATION; SAP-Retail: zlex023_mis_item.werks; SAP-BW: t_odp_itm_missing.plant; SAP-EWM: t_z_ds_mis_items.lgnum',
   storage_loc_cd                      VARCHAR(20)      COMMENT 'Lagerort; SAP-Retail: zlex023_mis_item.lgort; SAP-BW: t_odp_itm_missing.stor_loc; SAP-EWM: t_z_ds_mis_items.avlgrp',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Erfassungsdatum; SAP-Retail: zlex023_mis_item.zzerdat; SAP-BW: t_odp_itm_missing.erdat; SAP-EWM: t_z_ds_mis_items.zzaedat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_MISSING PRIMARY KEY (client_id, item_missing_id) NOT ENFORCED 
)  COMMENT = '$Revision: 9925 $. IMIH; Quelle: EDM / Text Datei; 
             SAP-Retail: zlex023_mis_item;
             SAP-BW: t_odp_itm_missing;
             ELWIS: t_s_itm_missing(_lookup);
             SAP-EWM: t_z_ds_mis_items;
             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx';

