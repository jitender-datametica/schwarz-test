/* --------------------------------------------------------------------------------
   DDL for table: t_item_unit_of_measurement_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_UNIT_OF_MEASUREMENT_HIST (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel; FK auf ITEM; SAP-Retail: marm.matnr; SAP-BW: t_bw_z_ds_marm.matnr',
   uom_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Mengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh',
   uom_sid_sub                         NUMBER(38,0)     COMMENT 'Untergeordnete Mengeneinheit in einer Verpackungshierarchie; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.mesub; SAP-BW: t_bw_z_ds_marm.mesub',
   uom_sid_size                        NUMBER(38,0)     COMMENT 'Einheit fur Lange/Breite/Hohe; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.meabm; SAP-BW: t_bw_z_ds_marm.meabm',
   uom_sid_volume                      NUMBER(38,0)     COMMENT 'Volumeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.voleh; SAP-BW: t_bw_z_ds_marm.voleh',
   uom_sid_weight                      NUMBER(38,0)     COMMENT 'Gewichtseinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.gewei; SAP-BW: t_bw_z_ds_marm.gewei',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh',
   uom_cd_sub                          VARCHAR(20)      COMMENT 'Untergeordnete Mengeneinheit in einer Verpackungshierarchie; SAP-Retail: marm.mesub; SAP-BW: t_bw_z_ds_marm.mesub',
   conv_to_base_numerator              NUMBER(18,5)     COMMENT 'Zahler fur die Umrechnung in Basismengeneinheiten; SAP-Retail: marm.umrez; SAP-BW: t_bw_z_ds_marm.umrez; ELWIS: t_s_itm_quantity_unit.num',
   conv_to_base_denominator            NUMBER(18,5)     COMMENT 'Nenner fur die Umrechnung in Basismengeneinheiten; SAP-Retail: marm.umren; SAP-BW: t_bw_z_ds_marm.umren; ELWIS: t_s_itm_quantity_unit.denom',
   uom_cd_size                         VARCHAR(20)      COMMENT 'Einheit fur Lange/Breite/Hohe; SAP-Retail: marm.meabm; SAP-BW: t_bw_z_ds_marm.meabm',
   LENGTH                              NUMBER(18,5)     COMMENT 'Laenge; SAP-Retail: marm.laeng; SAP-BW: t_bw_z_ds_marm.laeng',
   width                               NUMBER(18,5)     COMMENT 'Breite; SAP-Retail: marm,breit; SAP-BW: t_bw_z_ds_marm.breit',
   height                              NUMBER(18,5)     COMMENT 'Hoehe; SAP-Retail: marm.hoehe; SAP-BW: t_bw_z_ds_marm.hoehe',
   uom_cd_volume                       VARCHAR(20)      COMMENT 'Volumeneinheit; SAP-Retail: marm.voleh; SAP-BW: t_bw_z_ds_marm.voleh',
   volume                              NUMBER(18,5)     COMMENT 'Volumen; SAP-Retail: marm.volum; SAP-BW: t_bw_z_ds_marm.volum',
   uom_cd_weight                       VARCHAR(20)      COMMENT 'Gewichtseinheit; SAP-Retail: marm.gewei; SAP-BW: t_bw_z_ds_marm.gewei',
   weight_gross                        NUMBER(18,5)     COMMENT 'Bruttogewicht; SAP-Retail: marm.brgew; SAP-BW: t_bw_z_ds_marm.brgew',
   gtin                                VARCHAR(20)      COMMENT 'Global Trade Item Number (GTIN); SAP-Retail: marm.ean11; SAP-BW: t_bw_z_ds_marm.ean11; EDWH: t_s_itm_quantity_unit.gtin_id',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Artikel-Messeinheit-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_UNIT_OF_MEASUREMENT_HIST PRIMARY KEY (item_sid, uom_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IUOMH; Mengeneinheiten zum Artikel; 
             SAP-Retail: marm; 
             SAP-BW: t_bw_z_ds_marm;
             ELWIS: t_s_itm_quantity_unit;
             WAWI: ';

