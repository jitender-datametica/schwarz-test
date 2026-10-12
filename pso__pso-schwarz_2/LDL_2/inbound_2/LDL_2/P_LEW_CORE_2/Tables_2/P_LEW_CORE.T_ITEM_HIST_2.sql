/* --------------------------------------------------------------------------------
   DDL for table: t_item_hist_2
   generated from Powerdesigner on Friday, September 13, 2024 4:36:32 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2',
   item_fam_grp_sid                    NUMBER(38,0)     COMMENT 'Familygroup: entspricht Level 1 in der Item_2 Hierarchy_2; FK auf ITEM_2 FAMILY GROUP; SAP-Retail: wrf_matgrp_sku.node; SAP-BW: t_bw_z_ds_wrf_matgrp_sku.node',
   item_type_sid                       NUMBER(38,0)     COMMENT 'Artikelart; FK auf ITEM_2 TYPE; SAP-Retail: mara.mtart; SAP-BW: t_bw_0material_attr.mtart; ELWIS: t_s_itm.itm_type_id',
   item_grp_sid                        NUMBER(38,0)     COMMENT 'Warengruppe; FK auf ITEM_2 GROUP; SAP-Retail: mara.matkl; SAP-BW: t_bw_0material_attr.matkl; ELWIS: t_s_itm.itmgrp_id',
   item_sid_pricing_ref                NUMBER(38,0)     COMMENT 'Referenz-Preisartikel; FK auf ITEM_2; SAP-Retail: mara.pmata; SAP-BW: t_bw_0material_attr.pmata; ELWIS: t_s_itm.prcs_itm_id',
   pack_type_sid                       NUMBER(38,0)     COMMENT 'Verpackungstyp; FK auf PACKAGING TYPE; SAP-Retail: mara.zz_pack_type; SAP-BW: t_bw_0material_attr.zz_pack_type',
   uom_sid_base                        NUMBER(38,0)     COMMENT 'Masseinheit fur Basis-Mengenangabe; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: mara.meins; SAP-BW: t_bw_0material_attr.meins; ELWIS: t_s_itm.base_qty_uom_sid',
   uom_sid_sales                       NUMBER(38,0)     COMMENT 'Masseinheit fur Verkaufs-Mengenangabe; FK  auf UNIT_2 OF MEASUREMENT; SAP-Retail: mara.bstme; SAP-BW: t_bw_0material_attr.bstme; ELWIS: t_s_itm.sales_qty_uom_sid',
   uom_sid_packaging                   NUMBER(38,0)     COMMENT 'Mengeneinheit Verpackungsinhalt; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: mara.zz_pack_cont_uom; SAP-BW: t_bw_0material_attr.zz_pack_con1',
   brand_sid                           NUMBER(38,0)     COMMENT 'Marke; FK auf BRAND_2; SAP-Retail: mara.brand_id; SAP-BW: t_bw_0material_attr.brand_id; ELWIS: t_s_itm.brand_id; ELWIS: t_s_itm.brand_id',
   pur_grp_nat_sid                     NUMBER(38,0)     COMMENT 'Betreuender Einkaeufer (national); FK auf PURCHASE GROUP NAT; SAP-Retail: mara.zz_ekgrp_nam; SAP-BW: t_bw_0material_attr.zz_ekgrp_nam; ELWIS: t_s_itm.pur_grp_id',
   uom_cd_base                         VARCHAR(20)      COMMENT 'Masseinheit fur Basis-Mengenangabe; SAP-Retail: mara.meins; SAP-BW: t_bw_0material_attr.meins; ELWIS: t_s_itm.base_qty_uom_sid',
   uom_cd_sales                        VARCHAR(20)      COMMENT 'Masseinheit fur Verkaufs-Mengenangabe; SAP-Retail: mara.bstme; SAP-BW: t_bw_0material_attr.bstme; ELWIS: t_s_itm.sales_qty_uom_sid',
   gross_content_val                   NUMBER(18,5)     COMMENT 'Anzahl Verpackungsinhalt; SAP-Retail: mara.zz_quant_pack_cont; SAP-BW: t_bw_0material_attr.zz_quant_pac; ELWIS: t_s_itm.gross_contant_val',
   uom_cd_packaging                    VARCHAR(20)      COMMENT 'Mengeneinheit Verpackungsinhalt; SAP-Retail: mara.zz_pack_cont_uom; SAP-BW: t_bw_0material_attr.zz_pack_con1',
   pack_cont_qty                       NUMBER(18,5)     COMMENT 'Verpackungsinhalt; SAP-Retail: mara.zz_pack_content; SAP-BW: t_bw_0material_attr.zz_pack_cont; ELWIS: t_s_itm.pack_cont_qty',
   piece_net_weight_kg_meas            NUMBER(38,5)     COMMENT 'Net weight of the item_2 piece, the weight of the contents excluding the packaging, souce system: WAWI, source table: ARTIKELBESTELL_2, source column: FILLING_QTY, intermediate table: T_WAWI_ITM_ITEM_2 on P_LEW_CORE',
   state_bges_cd                       VARCHAR(20)      COMMENT 'Betriebsubergreifender Artikelstatus; SAP-Retail: mara.mstae; SAP-BW: t_bw_0material_attr.mstae; ELWIS: t_s_itm.itm_state_bges_id',
   hazardous_material_cd               VARCHAR(20)      COMMENT 'Gefahrstoffnummer; SAP-Retail: mara.stoff; SAP-BW: t_bw_0material_attr.stoff; ELWIS: t_s_itm.hzrd_itm_id',
   pricing_ref_item_cd                 VARCHAR(20)      COMMENT 'Preisartikel; SAP-Retail: mara.pmata; SAP-BW: t_bw_0material_attr.pmata; ELWIS: t_s_itm.prcs_itm_id',
   tax_class_cd                        VARCHAR(20)      COMMENT 'Steuerklassifikation: 0=keine Steuer, 1=Steuerklasse1, 2=Steuerklasse2, 3=Steuerklasse3, X=Dummy_2; SAP-Retail: mara.taklv; SAP-BW: t_bw_0material_attr.taklv; ELWIS: t_s_itm.tax_class',
   case_depth_meas                     NUMBER(38,5)     COMMENT 'CASEDEPTH in the unit_2 given in uom_cd_size
            spaceman:tblapproducts:CASEDEPTH
            ',
   case_high_meas                      NUMBER(38,5)     COMMENT 'CASEHIGH in the unit_2 given in uom_cd_size
            spaceman:tblapproducts:CASEHIGH',
   case_width_meas                     NUMBER(38,5)     COMMENT 'CASEWIDTH in the unit_2 given in uom_cd_size
            spaceman:tblapproducts:CASEWIDTH',
   item_depth_meas                     NUMBER(38,5)     COMMENT 'PRODUCTDEPTH in the unit_2 given in uom_cd_size
            spaceman:tblapproducts:PRODUCTDEPTH',
   item_hight_meas                     NUMBER(38,5)     COMMENT 'PRODUCTHIGH in the unit_2 given in uom_cd_size
            spaceman:tblapproducts:PRODUCTHIGH',
   item_width_meas                     NUMBER(38,5)     COMMENT 'PRODUCTWIDTH in the unit_2 given in uom_cd_size
            spaceman:tblapproducts:PRODUCTWIDTH',
   uom_cd_size                         VARCHAR(20)      COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode
            here inch for USA, cm for all other countries
            spaceman:tblapproducts:',
   uom_sid_size                        NUMBER(38,0)     COMMENT 'Surrogate Key UNIT_2 OF MEASUREMENT',
   case_orientation_end_front_fg       NUMBER(38,0)     COMMENT 'this flag indicates whether the end-front oriantation is allowed for this item_2 in a shelf
            spaceman:tblapproducts:EXTMEAS105',
   case_orientation_end_side_fg        NUMBER(38,0)     COMMENT 'this flag indicates whether the end-front oriantation is allowed for this item_2 in a shelf
            spaceman:tblapproducts:EXTMEAS106',
   spaceman_item_segment_sid           NUMBER(38,0)     COMMENT 'surrogate key_ item_2 segment definition in space management
            spaceman:tblapproducts:DESCJ',
   spaceman_item_grp_sid               NUMBER(38,0)     COMMENT 'surrogate key: item_2 group of the item_2 in the space management
            spaceman:tblapproducts:EXTDESC28',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Article is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_HIST PRIMARY KEY (item_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ITEMH; Artikel_2; 
             SAP-Retail: mara_2 & wrf_matgrp_sku_2; 
             SAP-BW: t_bw_0material_attr & & z_ds_wrf_matrgp_sku;
             ELWIS: t_s_itm, t_s_itm_descr;
             WAWI: ';
