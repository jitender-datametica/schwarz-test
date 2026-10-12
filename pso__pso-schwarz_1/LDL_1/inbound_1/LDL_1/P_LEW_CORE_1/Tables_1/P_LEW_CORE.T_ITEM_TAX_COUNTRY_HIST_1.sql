/* --------------------------------------------------------------------------------
   DDL for table: t_item_tax_country_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_TAX_COUNTRY_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: mlan.matnr; SAP-BW: t_bw_z_ds_mlan.matnr',
   country_pol_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Lieferndes Land_1; FK auf COUNTRY_1 POLITICAL; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland',
   country_pol_cd                      VARCHAR(20)      COMMENT 'Lieferndes Land_1; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland',
   tax_class_cd                        VARCHAR(20)      COMMENT 'Steuerklassifikation Artikel_1; SAP-Retail: mlan.taxm1; SAP-BW: t_bw_z_ds_mlan.taxm1',
   tax_indicator_cd                    VARCHAR(20)      COMMENT 'Steuerindikator Artikel_1 (Einkauf); SAP-Retail: mlan.taxim; SAP-BW: t_bw_z_ds_mlan.taxim',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Steuerinfo fuer Artikel_1 im Land_1 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_TAX_COUNTRY_HIST PRIMARY KEY (item_sid, country_pol_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ITXCH; Steuerklassifikation zum Artikel_1 pro Land_1; 
             SAP-Retail: mlan_1; 
             SAP-BW: t_bw_z_ds_mlan;
             ELWIS: t_s_itm_tax';

