
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_item_1 (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg).'),
src_matnr STRING(20)
OPTIONS(description='Artikelnummer (SAP); SAP-Retail: mara.matnr; SAP-BW: t_bw_0material_attr.matnr'),
src_orig_item_nr STRING(20)
OPTIONS(description='Artikelnummer (WAWI): erst in Kombination mit src_dat_valid_from und src_case_size eindeutig.'),
src_dat_valid_from DATE OPTIONS(description='Gueltigkeitsbeginn der Artikelnummer (WAWI)'),
src_case_size STRING(20) OPTIONS(description='Case-Size (WAWI)'),
item_sid_config INTEGER
OPTIONS(description='Betriebsuebergreifender, konfigurierbarer Artikel_1; FK auf ITEM_1; SAP-Retail: mara.satnr; SAP-BW: t_bw_0material_attr.satnr; ELWIS: t_s_itm.config_item_id'),
item_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Artikelbeschreibung in Stiftungssprache; SAP-Retail: makt.maktx; SAP-BW: t_bw_0material_text.txtmd; ELWIS: t_s_itm_descr.itm_descr'),
log_var_cd STRING(20)
OPTIONS(description='Logistische Variante; 1=Sammelartikel, 2=Verkaufsvariante, 3=Beschaffungsvariante; SAP-Retail: mara.bflme; SAP-BW: t_bw_0material_attr.bflme; ELWIS: t_s_itm.log_var_id'),
config_item_cd STRING(20)
OPTIONS(description='Betriebsuebergreifender, konfigurierbarer Artikel_1; SAP-Retail: mara.satnr; SAP-BW: t_bw_0material_attr.satnr; ELWIS: t_s_itm.config_item_id'),
item_eks_cd STRING(20)
OPTIONS(description='Alte Artikelnummer aus EKS; SAP-Retail: mara.bismt; SAP-BW: t_bw_0material_attr.bismt; ELWIS: t_s_itm.wawi_orig_item_id'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH.'),
PRIMARY KEY (item_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. ITEM_1; Artikel_1;\n             SAP-Retail: mara_1 & makt_1;\n             SAP-BW: t_bw_0material_attr & t_bw_0material_text;\n             ELWIS: t_s_itm, t_s_itm_descr;\n             WAWI: t_itm_item_skey, t_itm_item_1, t_itm_item_desc_1');