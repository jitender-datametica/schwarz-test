/* --------------------------------------------------------------------------------
   DDL for table: t_item_2
   generated from Powerdesigner on Montag, 28. August 2023 13:26:09
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).',
   src_matnr                           VARCHAR(20)      COMMENT 'Artikelnummer (SAP); SAP-Retail: mara.matnr; SAP-BW: t_bw_0material_attr.matnr',
   src_orig_item_nr                    VARCHAR(20)      COMMENT 'Artikelnummer (WAWI): erst in Kombination mit src_dat_valid_from und src_case_size eindeutig.',
   src_dat_valid_from                  DATE             COMMENT 'Gueltigkeitsbeginn der Artikelnummer (WAWI)',
   src_case_size                       VARCHAR(20)      COMMENT 'Case-Size (WAWI)',
   item_sid_config                     NUMBER(38,0)     COMMENT 'Betriebsuebergreifender, konfigurierbarer Artikel_2; FK auf ITEM_2; SAP-Retail: mara.satnr; SAP-BW: t_bw_0material_attr.satnr; ELWIS: t_s_itm.config_item_id',
   item_name                           VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Artikelbeschreibung in Stiftungssprache; SAP-Retail: makt.maktx; SAP-BW: t_bw_0material_text.txtmd; ELWIS: t_s_itm_descr.itm_descr',
   log_var_cd                          VARCHAR(20)      COMMENT 'Logistische Variante; 1=Sammelartikel, 2=Verkaufsvariante, 3=Beschaffungsvariante; SAP-Retail: mara.bflme; SAP-BW: t_bw_0material_attr.bflme; ELWIS: t_s_itm.log_var_id',
   config_item_cd                      VARCHAR(20)      COMMENT 'Betriebsuebergreifender, konfigurierbarer Artikel_2; SAP-Retail: mara.satnr; SAP-BW: t_bw_0material_attr.satnr; ELWIS: t_s_itm.config_item_id',
   item_eks_cd                         VARCHAR(20)      COMMENT 'Alte Artikelnummer aus EKS; SAP-Retail: mara.bismt; SAP-BW: t_bw_0material_attr.bismt; ELWIS: t_s_itm.wawi_orig_item_id',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_ITEM PRIMARY KEY (item_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ITEM_2; Artikel_2; 
             SAP-Retail: mara_2 & makt_2; 
             SAP-BW: t_bw_0material_attr & t_bw_0material_text;
             ELWIS: t_s_itm, t_s_itm_descr;
             WAWI: t_itm_item_skey, t_itm_item_2, t_itm_item_desc_2';
