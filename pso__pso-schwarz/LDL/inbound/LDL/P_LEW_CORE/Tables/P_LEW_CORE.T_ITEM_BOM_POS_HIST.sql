/* --------------------------------------------------------------------------------
   DDL for table: t_item_bom_pos_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_BOM_POS_HIST CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_bom_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM BOM',
   src_stlkn                           NUMBER(38,0)     NOT NULL COMMENT 'Knotennummer der Stuecklistenposition; SAP-Retail: stpo.stlkn; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlkn; ELWIS: t_s_itm_bom_pos.itm_node_stlkn',
   bom_pos_nr                          VARCHAR(20)      COMMENT 'SAP-Retail: stpo.posnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.posnr; ELWIS: t_s_itm_bom_pos.bom_pos_nr',
   item_sid                            NUMBER(38,0)     COMMENT 'Stucklistenkomponente; FK auf ITEM; SAP-Retail: stpo.idnrk; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.idnrk; ELWIS: t_s_itm_bom_pos.component',
   uom_sid                             NUMBER(38,0)     COMMENT 'Komponentenmengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: stpo.meins; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.meins; ELWIS: t_s_itm_bom_pos.base_qty_uom_sid',
   version_counter                     NUMBER(38,0)     COMMENT 'Interner Zaehler; SAP-Retail: stpo.stpoz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stpoz; ELWIS: ',
   uom_cd                              VARCHAR(20)      COMMENT 'Komponentenmengeneinheit; SAP-Retail: stpo.meins; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.meins',
   component_qty                       NUMBER(18,5)     COMMENT 'Komponentenmenge; SAP-Retail: stpo.menge; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.menge; ELWIS: t_s_itm_bom_pos.comp_qty',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Item BOM Position ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_BOM_POS_HIST PRIMARY KEY (item_bom_sid, src_stlkn, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IBOP; Stuecklistenposition; Enthaelt die ITEMs (=Stuecklistenkomp.) eines Sammelartikels (=Stueckliste)
             SAP-Retail: stpo; 
             SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo;
             ELWIS: t_s_itm_bom_pos
             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-16';

