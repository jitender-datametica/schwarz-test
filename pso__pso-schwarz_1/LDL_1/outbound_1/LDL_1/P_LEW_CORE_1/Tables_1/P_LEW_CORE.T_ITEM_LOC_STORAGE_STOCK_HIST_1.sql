/* --------------------------------------------------------------------------------
   DDL for table: t_item_loc_storage_stock_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_loc_storage_stock_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lokation; FK auf LOCATION_1; SAP-Retail: mard.werks; SAP-BW: t_bw_z_ds_mard.werks'),
storage_loc_cd STRING(20) NOT NULL
OPTIONS(description='Lagerort im Lager (Unterteilung aktuell nicht genutzt); SAP-Retail: mard.lgort; SAP-BW: t_bw_z_ds_mard.lgort'),
free_qty NUMERIC(18,5)
OPTIONS(description='Bewerteter, frei verwendbarer Bestand (default=0); SAP-Retail: mard.labst; SAP-BW: t_bw_z_ds_mard.labst'),
mov_qty NUMERIC(18,5)
OPTIONS(description='Umlageragungsbestand (von Lagerort zu Lagerort) (default=0); SAP-Retail: mard.umlme; SAP-BW: t_bw_z_ds_mard.umlme'),
qa_check_qty NUMERIC(18,5)
OPTIONS(description='Qualitaetspruefbestand (default=0); SAP-Retail: mard.insme; SAP-BW: t_bw_z_ds_mard.insme'),
blocked_qty NUMERIC(18,5)
OPTIONS(description='Gesperrter Bestand (default=0); SAP-Retail: mard.speme; SAP-BW: t_bw_z_ds_mard.speme'),
blocked_batch_qty NUMERIC(18,5)
OPTIONS(description='Gesamtbestand aller nicht freien Chargen (default=0); SAP-Retail: mard.einme; SAP-BW: t_bw_z_ds_mard.einme'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Loschmarke fur den Bestand - hier immer 0, da geloschte Bestandszeilen phsisch eliminiert werden => unterbrochene Zeitlinie der Bestandshistorie!'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Datum der Bestandsaufnahme; SAP-BW: the extractor does not contain the stock_date, therefore extraction_date is used; ELWIS: stock_dat'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Gultigkeitsende dieses Bestandes'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, loc_sid, storage_loc_cd, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id, dwh_valid_from, dwh_valid_to
OPTIONS(description='$Revision: 0000 $. ISTO; Feingranularer Bestand (SAP-Laender) pro Artikel_1, Lokation, Lagerort und Tag_1;             SAP-Retail: mard_1;             SAP-BW: t_bw_z_ds_mard;             ELWIS: t_s_itm_store_stock             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-20');