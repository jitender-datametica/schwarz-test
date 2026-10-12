/* --------------------------------------------------------------------------------
   DDL for table: t_item_bom_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_BOM_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_bom_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2 BOM',
   src_matnr                           VARCHAR(20)      COMMENT 'Artikelnummer; SAP-Retail: mast.matnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.matnr',
   src_werks                           VARCHAR(20)      COMMENT 'Betrieb; SAP-Retail: mast.werks; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.werks - bei LIDL-Stucklisten nicht verwendet',
   src_stlnr                           VARCHAR(20)      COMMENT 'Stueckliste_2; SAP-Retail: mast.stlnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlnr',
   src_stlan                           VARCHAR(20)      COMMENT 'Stuecklistenverwendung; SAP-Retail: mast.stlan; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlan',
   src_stlal                           VARCHAR(20)      COMMENT 'Stuecklistenalternative; SAP-Retail: mast.stlal; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlal; ELWIS: t_s_itm_bom.alt_bom',
   item_sid                            NUMBER(38,0)     COMMENT 'Sammelartikel; FK auf ITEM_2; SAP-Retail: mast.matnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.matnr; ELWIS: t_s_itm_bom.itm_sid',
   bom_alternative_cd_act              VARCHAR(20)      COMMENT 'Stuecklistenalternative (akt. Auspraegung in t_item_bom_hist_2); nur bei Pfandgut (src_stlan / Verwendung = 7) bei Unterschieden (Alt. 1: Beschaffungsvariante; Alt. 2: Verkaufsartikel); SAP-Retail: mast.stlal; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlal',
   version_counter_act                 NUMBER(38,0)     COMMENT 'Interner Zaehler; SAP-Retail: stko.stkoz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stkoz; ELWIS: t_s_itm_bom.stko_cnt',
   active_from_dt_act                  DATE             NOT NULL COMMENT 'Datum gueltig ab; SAP-Retail: stko.datuv; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.datuv; ELWIS: t_s_itm_bom.bom_valid_from_dat',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Item_2 BOM ist im Falle deleted_fg = 1 als nicht mehr im Quellsystem bekannt interpretiert; SAP-Retail: stko.lkenz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.lkenz',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_BOM PRIMARY KEY (item_bom_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IBOM; Stucklistenkopf; 
             SAP-Retail: stko_2 & mast_2; 
             SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo;
             ELWIS: t_s_itm_bom
             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-16';

