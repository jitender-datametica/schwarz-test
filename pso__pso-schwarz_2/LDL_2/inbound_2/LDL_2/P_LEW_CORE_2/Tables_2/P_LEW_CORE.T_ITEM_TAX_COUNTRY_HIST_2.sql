/* --------------------------------------------------------------------------------
   DDL for table: t_item_tax_country_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_TAX_COUNTRY_HIST_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: mlan.matnr; SAP-BW: t_bw_z_ds_mlan.matnr',
   country_pol_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Lieferndes Land_2; FK auf COUNTRY_2 POLITICAL; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland',
   country_pol_cd                      VARCHAR(20)      COMMENT 'Lieferndes Land_2; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland',
   tax_class_cd                        VARCHAR(20)      COMMENT 'Steuerklassifikation Artikel_2; SAP-Retail: mlan.taxm1; SAP-BW: t_bw_z_ds_mlan.taxm1',
   tax_indicator_cd                    VARCHAR(20)      COMMENT 'Steuerindikator Artikel_2 (Einkauf); SAP-Retail: mlan.taxim; SAP-BW: t_bw_z_ds_mlan.taxim',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Steuerinfo fuer Artikel_2 im Land_2 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_TAX_COUNTRY_HIST PRIMARY KEY (item_sid, country_pol_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ITXCH; Steuerklassifikation zum Artikel_2 pro Land_2; 
             SAP-Retail: mlan_2; 
             SAP-BW: t_bw_z_ds_mlan;
             ELWIS: t_s_itm_tax';

