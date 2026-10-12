/* --------------------------------------------------------------------------------
   DDL for table: t_item_gtin_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_GTIN_HIST (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel; FK auf ITEM; SAP-Retail: mean.matnr;',
   uom_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Mengeneinheit fuer Anzeige; FK auf UNIT OF MEASUREMENT; SAP-Retail: mean.meinh',
   seq_nr                              VARCHAR(20)      NOT NULL COMMENT 'Laufende Nummer; SAP-Retail: mean.lfnum',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit fuer Anzeige; SAP-Retail: mean.MEINH',
   gtin                                VARCHAR(20)      COMMENT 'Global Trade Item Number (GTIN); SAP-Retail: mean.EAN11; SAP-BW: t_bw_z_ds_mean.EAN11',
   gtin_type_mark                      VARCHAR(20)      COMMENT 'Nummerntyp-Code der Global Trade Item Number; SAP-Retail: mean.EANTP; SAP-BW: t_bw_z_ds_mean.EANTP',
   gtin_type_label                     VARCHAR(100)     COMMENT 'Nummerntyp-Code Beschreibung',
   main_gtin_fg                        NUMBER(38,0)     COMMENT 'Kennzeichen Haupt-GTIN; SAP-Retail: mean.HPEAN; SAP-BW: t_bw_z_ds_mean.HPEAN',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Artikel-GTIN-Zuordnung ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_GTIN_HIST PRIMARY KEY (item_sid, uom_sid, seq_nr, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IGTIH; Global Trade Item Number(s) (GTIN) zum Artikel; 
             SAP-Retail: MEAN;
             SAP-BW: t_bw_z_ds_mean;
             ELWIS: t_s_itm_gtin
             WAWI: t_itm_ean';

