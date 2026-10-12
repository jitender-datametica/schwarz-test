/* --------------------------------------------------------------------------------
   DDL for table: t_item_loc_storage_stock_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_LOC_STORAGE_STOCK_HIST_1 CLUSTER BY (
     CLIENT_ID,
     DWH_VALID_FROM,
     DWH_VALID_TO 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Lokation; FK auf LOCATION_1; SAP-Retail: mard.werks; SAP-BW: t_bw_z_ds_mard.werks',
   storage_loc_cd                      VARCHAR(20)      NOT NULL COMMENT 'Lagerort im Lager (Unterteilung aktuell nicht genutzt); SAP-Retail: mard.lgort; SAP-BW: t_bw_z_ds_mard.lgort',
   free_qty                            NUMBER(18,5)     COMMENT 'Bewerteter, frei verwendbarer Bestand (default=0); SAP-Retail: mard.labst; SAP-BW: t_bw_z_ds_mard.labst',
   mov_qty                             NUMBER(18,5)     COMMENT 'Umlageragungsbestand (von Lagerort zu Lagerort) (default=0); SAP-Retail: mard.umlme; SAP-BW: t_bw_z_ds_mard.umlme',
   qa_check_qty                        NUMBER(18,5)     COMMENT 'Qualitaetspruefbestand (default=0); SAP-Retail: mard.insme; SAP-BW: t_bw_z_ds_mard.insme',
   blocked_qty                         NUMBER(18,5)     COMMENT 'Gesperrter Bestand (default=0); SAP-Retail: mard.speme; SAP-BW: t_bw_z_ds_mard.speme',
   blocked_batch_qty                   NUMBER(18,5)     COMMENT 'Gesamtbestand aller nicht freien Chargen (default=0); SAP-Retail: mard.einme; SAP-BW: t_bw_z_ds_mard.einme',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Loschmarke fur den Bestand - hier immer 0, da geloschte Bestandszeilen phsisch eliminiert werden => unterbrochene Zeitlinie der Bestandshistorie!',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Datum der Bestandsaufnahme; SAP-BW: the extractor does not contain the stock_date, therefore extraction_date is used; ELWIS: stock_dat',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gultigkeitsende dieses Bestandes',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_LOC_STORAGE_STOCK_HIST PRIMARY KEY (item_sid, loc_sid, storage_loc_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ISTO; Feingranularer Bestand (SAP-Laender) pro Artikel_1, Lokation, Lagerort und Tag_1;
             SAP-Retail: mard_1;
             SAP-BW: t_bw_z_ds_mard;
             ELWIS: t_s_itm_store_stock
             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-20';

