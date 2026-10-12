/* --------------------------------------------------------------------------------
   DDL for table: t_item_sort_box_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_SORT_BOX_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid_sort_box                   NUMBER(38,0)     NOT NULL COMMENT 'Sortierkarton; FK auf ITEM_2; SAP-Retail: zmmx_os_rel.matnr; SAP-BW: t_bw_z_ds_zmmx_os_rel.matnr',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Bestellartikel; FK auf ITEM_2; SAP-Retail: zmmx_os_rel.matnr_hl; SAP-BW: t_bw_z_ds_zmmx_os_rel.matnr_hl',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2-Sortierbox-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_SORT_BOX_HIST PRIMARY KEY (item_sid_sort_box, item_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ISBXH; Zuordnung Bestellartikel - Sortierkarton;
             SAP-Retail: zmmx_os_rel_2;
             SAP-BW: t_bw_z_ds_zmmx_os_rel;
             ELWIS: t_s_itm_sort_box';

