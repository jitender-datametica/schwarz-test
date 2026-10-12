/* --------------------------------------------------------------------------------
   DDL for table: t_item_descr_1
   generated from Powerdesigner on Montag, 28. August 2023 13:27:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_descr_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: makt.matnr; SAP-BW: t_bw_0material_text.matnr'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE; SAP-Retail: makt.spras; SAP-BW: t_bw_0material_text.spras'),
lang_cd STRING(20) OPTIONS(description='Sprache - Code; SAP-Retail: makt.spras; SAP-BW: t_bw_0material_text.spras'),
item_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Artikelbezeichnung; SAP-Retail: makt.maktx; SAP-BW: t_bw_0material_text.txtmd'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. ITMD; Artikelbeschreibungen;             SAP-Retail: makt_1;             SAP-BW: t_bw_0material_text;             ELWIS: t_s_itm_descr;             WAWI: t_itm_item_desc_1');