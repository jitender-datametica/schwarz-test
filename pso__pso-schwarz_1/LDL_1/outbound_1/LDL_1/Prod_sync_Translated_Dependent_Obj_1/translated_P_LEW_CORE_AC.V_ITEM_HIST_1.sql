CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_hist_1 (client_id OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_sid OPTIONS(description='Surrogate Key ITEM_1'), item_fam_grp_sid
OPTIONS(description='Familygroup: entspricht Level 1 in der Item_1 Hierarchy_1; FK auf ITEM_1 FAMILY GROUP; SAP-Retail: wrf_matgrp_sku.node; SAP-BW: t_bw_z_ds_wrf_matgrp_sku.node'),
item_type_sid
OPTIONS(description='Artikelart; FK auf ITEM_1 TYPE; SAP-Retail: mara.mtart; SAP-BW: t_bw_0material_attr.mtart; ELWIS: t_s_itm.itm_type_id'),
item_grp_sid
OPTIONS(description='Warengruppe; FK auf ITEM_1 GROUP; SAP-Retail: mara.matkl; SAP-BW: t_bw_0material_attr.matkl; ELWIS: t_s_itm.itmgrp_id'),
item_sid_pricing_ref
OPTIONS(description='Referenz-Preisartikel; FK auf ITEM_1; SAP-Retail: mara.pmata; SAP-BW: t_bw_0material_attr.pmata; ELWIS: t_s_itm.prcs_itm_id'),
pack_type_sid
OPTIONS(description='Verpackungstyp; FK auf PACKAGING TYPE; SAP-Retail: mara.zz_pack_type; SAP-BW: t_bw_0material_attr.zz_pack_type'),
uom_sid_base
OPTIONS(description='Masseinheit fur Basis-Mengenangabe; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: mara.meins; SAP-BW: t_bw_0material_attr.meins; ELWIS: t_s_itm.base_qty_uom_sid'),
uom_sid_sales
OPTIONS(description='Masseinheit fur Verkaufs-Mengenangabe; FK  auf UNIT_1 OF MEASUREMENT; SAP-Retail: mara.bstme; SAP-BW: t_bw_0material_attr.bstme; ELWIS: t_s_itm.sales_qty_uom_sid'),
uom_sid_packaging
OPTIONS(description='Mengeneinheit Verpackungsinhalt; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: mara.zz_pack_cont_uom; SAP-BW: t_bw_0material_attr.zz_pack_con1'),
brand_sid
OPTIONS(description='Marke; FK auf BRAND_1; SAP-Retail: mara.brand_id; SAP-BW: t_bw_0material_attr.brand_id; ELWIS: t_s_itm.brand_id; ELWIS: t_s_itm.brand_id'),
pur_grp_nat_sid
OPTIONS(description='Betreuender Einkaeufer (national); FK auf PURCHASE GROUP NAT; SAP-Retail: mara.zz_ekgrp_nam; SAP-BW: t_bw_0material_attr.zz_ekgrp_nam; ELWIS: t_s_itm.pur_grp_id'),
uom_cd_base
OPTIONS(description='Masseinheit fur Basis-Mengenangabe; SAP-Retail: mara.meins; SAP-BW: t_bw_0material_attr.meins; ELWIS: t_s_itm.base_qty_uom_sid'),
uom_cd_sales
OPTIONS(description='Masseinheit fur Verkaufs-Mengenangabe; SAP-Retail: mara.bstme; SAP-BW: t_bw_0material_attr.bstme; ELWIS: t_s_itm.sales_qty_uom_sid'),
gross_content_val
OPTIONS(description='Anzahl Verpackungsinhalt; SAP-Retail: mara.zz_quant_pack_cont; SAP-BW: t_bw_0material_attr.zz_quant_pac; ELWIS: t_s_itm.gross_contant_val'),
uom_cd_packaging
OPTIONS(description='Mengeneinheit Verpackungsinhalt; SAP-Retail: mara.zz_pack_cont_uom; SAP-BW: t_bw_0material_attr.zz_pack_con1'),
pack_cont_qty
OPTIONS(description='Verpackungsinhalt; SAP-Retail: mara.zz_pack_content; SAP-BW: t_bw_0material_attr.zz_pack_cont; ELWIS: t_s_itm.pack_cont_qty'),
piece_net_weight_kg_meas
OPTIONS(description='Net weight of the item_1 piece, the weight of the contents excluding the packaging, souce system: WAWI, source table: ARTIKELBESTELL_1, source column: FILLING_QTY, intermediate table: T_WAWI_ITM_ITEM_1 on P_LEW_CORE'),
state_bges_cd
OPTIONS(description='Betriebsubergreifender Artikelstatus; SAP-Retail: mara.mstae; SAP-BW: t_bw_0material_attr.mstae; ELWIS: t_s_itm.itm_state_bges_id'),
hazardous_material_cd
OPTIONS(description='Gefahrstoffnummer; SAP-Retail: mara.stoff; SAP-BW: t_bw_0material_attr.stoff; ELWIS: t_s_itm.hzrd_itm_id'),
pricing_ref_item_cd
OPTIONS(description='Preisartikel; SAP-Retail: mara.pmata; SAP-BW: t_bw_0material_attr.pmata; ELWIS: t_s_itm.prcs_itm_id'),
tax_class_cd
OPTIONS(description='Steuerklassifikation: 0=keine Steuer, 1=Steuerklasse1, 2=Steuerklasse2, 3=Steuerklasse3, X=Dummy_1; SAP-Retail: mara.taklv; SAP-BW: t_bw_0material_attr.taklv; ELWIS: t_s_itm.tax_class'),
case_depth_meas
OPTIONS(description='CASEDEPTH in the unit_1 given in uom_cd_size\n            spaceman:tblapproducts:CASEDEPTH'),
case_high_meas
OPTIONS(description='CASEHIGH in the unit_1 given in uom_cd_size\n            spaceman:tblapproducts:CASEHIGH'),
case_width_meas
OPTIONS(description='CASEWIDTH in the unit_1 given in uom_cd_size\n            spaceman:tblapproducts:CASEWIDTH'),
item_depth_meas
OPTIONS(description='PRODUCTDEPTH in the unit_1 given in uom_cd_size\n            spaceman:tblapproducts:PRODUCTDEPTH'),
item_hight_meas
OPTIONS(description='PRODUCTHIGH in the unit_1 given in uom_cd_size\n            spaceman:tblapproducts:PRODUCTHIGH'),
item_width_meas
OPTIONS(description='PRODUCTWIDTH in the unit_1 given in uom_cd_size\n            spaceman:tblapproducts:PRODUCTWIDTH'),
uom_cd_size
OPTIONS(description='Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode\n            here inch for USA, cm for all other countries\n            spaceman:tblapproducts:'),
uom_sid_size OPTIONS(description='Surrogate Key UNIT_1 OF MEASUREMENT'), case_orientation_end_front_fg
OPTIONS(description='this flag indicates whether the end-front oriantation is allowed for this item_1 in a shelf\n            spaceman:tblapproducts:EXTMEAS105'),
case_orientation_end_side_fg
OPTIONS(description='this flag indicates whether the end-front oriantation is allowed for this item_1 in a shelf\n            spaceman:tblapproducts:EXTMEAS106'),
spaceman_item_segment_sid
OPTIONS(description='surrogate key_ item_1 segment definition in space management\n            spaceman:tblapproducts:DESCJ'),
spaceman_item_grp_sid
OPTIONS(description='surrogate key: item_1 group of the item_1 in the space management\n            spaceman:tblapproducts:EXTDESC28'),
deleted_fg
OPTIONS(description='Article is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
dwh_valid_from
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.')) AS SELECT client_id,
 item_sid,
 item_fam_grp_sid,
 item_type_sid,
 item_grp_sid,
 item_sid_pricing_ref,
 pack_type_sid,
 uom_sid_base,
 uom_sid_sales,
 uom_sid_packaging,
 brand_sid,
 pur_grp_nat_sid,
 uom_cd_base,
 uom_cd_sales,
 gross_content_val,
 uom_cd_packaging,
 pack_cont_qty,
 piece_net_weight_kg_meas,
 state_bges_cd,
 hazardous_material_cd,
 pricing_ref_item_cd,
 tax_class_cd,
 case_width_meas AS case_depth_meas,
 case_depth_meas AS case_high_meas,
 case_high_meas AS case_width_meas,
 case_orientation_end_front_fg AS item_depth_meas,
 case_orientation_end_side_fg AS item_hight_meas,
 item_depth_meas AS item_width_meas,
 item_hight_meas AS uom_cd_size,
 item_width_meas AS uom_sid_size,
 spaceman_item_grp_sid AS case_orientation_end_front_fg,
 spaceman_item_segment_sid AS case_orientation_end_side_fg,
 uom_cd_size AS spaceman_item_segment_sid,
 uom_sid_size AS spaceman_item_grp_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_hist_1;