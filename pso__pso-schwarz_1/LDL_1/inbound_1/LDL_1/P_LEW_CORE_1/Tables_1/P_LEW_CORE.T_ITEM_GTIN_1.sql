/* --------------------------------------------------------------------------------
   DDL for table: t_item_gtin_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_GTIN_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: mean.matnr;',
   uom_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Mengeneinheit fuer Anzeige; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: mean.minh',
   src_lfnum                           VARCHAR(20)      NOT NULL COMMENT 'Laufende Nummer - fuer jede neue GTIN einer item_sid/uom_sid Kombination wird (in SAP Retail) eine_1 neue Nummer vergeben; SAP-Retail: mean.lfnum',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit fuer Anzeige; SAP-Retail: mean.meinh',
   gtin                                VARCHAR(20)      COMMENT 'Global Trade Item_1 Number (GTIN); SAP-Retail: mean.EAN11; SAP-BW: t_bw_z_ds_mean.ean11',
   gtin_type_cd                        VARCHAR(20)      COMMENT 'Nummerntyp der Global Trade Item_1 Number; SAP-Retail: mean.EANTP; SAP-BW: t_bw_z_ds_mean.eantp',
   main_gtin_fg                        NUMBER(38,0)     COMMENT 'Kennzeichen Haupt-GTIN; SAP-Retail: mean.hpean; SAP-BW: t_bw_z_ds_mean.hpean',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_GTIN PRIMARY KEY (item_sid, uom_sid, src_lfnum) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IGTI; Global Trade Item_1 Number(s) (GTIN) zum Artikel_1; 
             SAP-Retail: MEAN_1;
             SAP-BW: t_bw_z_ds_mean;
             ELWIS: t_s_itm_gtin;
             WAWI: t_itm_ean';

