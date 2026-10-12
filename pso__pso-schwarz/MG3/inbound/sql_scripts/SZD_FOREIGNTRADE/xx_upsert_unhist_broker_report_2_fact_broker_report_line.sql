INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
trader_reference_nr,
movement_ref_number,
item_position_seq,
authority_country_location_sid,
customs_declaration_type_cd,
broker_dt,
broker_declarant_party_sid,
broker_declarant_nr,
broker_declarant_name,
importer_party_sid,
importer_nr,
importer_name,
customs_product_sid,
origin_country_location_sid,
origin_country_cd,
customs_product_nr,
customs_product_descr,
customs_tariff_number_cd,
cds_acceptance_tmsp,
acceptance_tmsp,
cds_clearance_tmsp,
first_deferment,
gross_mass_meas,
net_mass_meas,
alcoholic_beverage_pct,
alcoholic_beverage_adjusted_pct,
alcoholic_beverage_volume_qty,
item_piece_cnt,	
item_tariff_qty,	
item_tariff_uom_cd,
consignor_specified_qty,
excise_payment_amount_val,
excise_tax_rate_val,
broker_tax_cd,
consignor_tax_cd,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg 
)
select bd.trader_reference_nr,
bd.movement_ref_number,
bd.item_position as item_position_seq,
bd.authority_country_location_sid,
bd.customs_declaration_type_cd,
coalesce(bd.cds_acceptance_tmsp, bd.acceptance_tmsp, bd.cds_clearance_tmsp) as broker_dt,
coalesce(brk.party_sid, -1) as broker_declarant_party_sid,
brk.broker_number as broker_declarant_nr,
brk.broker_name	as broker_declarant_name,
imp.party_sid as importer_party_sid,
imp.importer_number as importer_nr,
imp.importer_name as importer_name,
bd.customs_product_sid as customs_product_sid,
p.origin_country_location_sid as origin_country_location_sid,
ocp.iso_country_cd as origin_country_cd,
case when p.additional_cd != ''
    then p.customs_product_nr || '_' || p.additional_cd 
    else p.customs_product_nr 
end as customs_product_nr,
p.customs_product_name as customs_product_descr,
p.customs_tariff_code_cd as customs_tariff_number_cd,
bd.cds_acceptance_tmsp,
bd.acceptance_tmsp,
bd.cds_clearance_tmsp,
bd.first_deferment,
bd.gross_mass_meas,
bd.net_mass_meas,
p.alcoholic_beverage_pct,
p.alcoholic_beverage_adjusted_pct,
p.alcoholic_beverage_volume_qty,
bd.item_piece_cnt,	
bd.item_tariff_qty,	
coalesce(upper(u.unit_cd), '-1') as item_tariff_uom_cd,
cd.spec_meas as consignor_specified_qty,
bd.excise_payment_amount_val,
coalesce(p.special_excise_rate_val, txr.excise_tax_rate_val) as excise_tax_rate_val,
coalesce(bd.alcoholic_beverage_tax_rate_cd, '-1') as broker_tax_cd,
coalesce(cd.alcoholic_beverage_tax_rate_cd, '-1') as consignor_tax_cd,
bd.dwh_src_1_tmsp as dwh_mapping_tmsp,
bd.dwh_src_file_name,
bd.dwh_src_1_tmsp,
0 as tf_error_fg,
0 as dwh_load_id,
0 as record_id,
bd.dwh_src_file_name as filename,
0 as deleted_fg                                                                                                 
from (--Broker Data                                                                                             
select 
case when br.trader_reference like '%-SDI'
                then substr(br.trader_reference, 1, length(br.trader_reference) - 4)
                else br.trader_reference
            end as trader_reference_nr,
brl.customs_product_sid,
count(*) over (partition by br.trader_reference, brl.customs_product_sid) = 1 as unique_product_fg,
brl.item_position,
br.customs_declaration_type_cd,
br.authority_country_location_sid,
br.movement_ref_number,
br.cds_acceptance_tmsp,
br.acceptance_tmsp,
br.cds_clearance_tmsp,
br.importer_party_sid,
br.broker_declarant_party_sid,
br.first_deferment,
brl.gross_mass_meas,
brl.net_mass_meas,
brl.item_piece_cnt,
brl.item_tariff_qty,
brl.item_tariff_qty_uom_id,
brl.excise_payment_amount_val,
brl.alcoholic_beverage_tax_rate_cd,
br.dwh_src_1_tmsp, 
br.dwh_src_file_name
from core_rel.t_broker_report br
join core_rel.t_broker_report_line brl
  on br.movement_ref_number = brl.movement_ref_number 
 and br.trader_reference = brl.trader_reference) bd
  join core_rel.t_importer imp on bd.importer_party_sid = imp.party_sid
  join core_rel.t_broker brk on bd.broker_declarant_party_sid = brk.party_sid
  join core_rel.t_customs_product p on bd.customs_product_sid = p.product_sid 
   and coalesce(bd.cds_acceptance_tmsp, bd.acceptance_tmsp, bd.cds_clearance_tmsp) between p.dwh_valid_from_tmsp and p.dwh_valid_to_tmsp 
  join core_rel.t_country_political ocp  on p.origin_country_location_sid = ocp.location_sid  and ocp.lang_cd = 'DE'
  left   join core_rel.t_unit u  on bd.item_tariff_qty_uom_id = u.unit_id 
  left  join core_rel.t_alcoholic_beverage_tax_rate txr  on bd.alcoholic_beverage_tax_rate_cd = txr.alcoholic_beverage_tax_rate_cd 
  left  join --Consignor Data
(--GTS Data                                                                                                 
select coll.trader_reference_nr,
coll.customs_product_sid,
coll.item_position_seq,
row_number() over (partition by coll.trader_reference_nr order by coll.inbound_item_nr) as item_position_ibd_seq,
coll.alcoholic_beverage_tax_rate_cd,
spc.spec_meas
from core_rel.t_consignor_order_list_line coll
left 
join core_rel.t_consignor_order_list_line_specification spc
  on coll.trader_reference_nr = spc.trader_reference_nr 
 and coll.order_dt = spc.order_dt 
 and coll.item_position_seq = spc.item_position_seq 
 and spc.specification_seq = 1
where coll.customs_product_sid != -1
union
--WWT Data
select coll.trader_reference_nr,
p.product_sid as customs_product_sid,
-1 as item_position_seq,
-1 as item_position_ibd_seq,
max(p.alcoholic_beverage_tax_rate_cd) as alcoholic_beverage_tax_rate_cd,
sum(p.volume_unit_qty * coll.item_cnt) as spec_meas                                              
from core_rel.t_consignor_order_list_line coll
join core_rel.t_customs_product p
  on coll.product_nr = p.customs_product_nr
 and coll.additional_cd = p.additional_cd
 and coll.origin_country_location_sid = p.origin_country_location_sid
 and coll.order_dt between p.dwh_valid_from_tmsp and p.dwh_valid_to_tmsp
where coll.product_sid != -1 
GROUP BY 1, 2) cd
    on bd.trader_reference_nr = cd.trader_reference_nr
   and bd.customs_product_sid = cd.customs_product_sid 
   and(   bd.unique_product_fg = true
       or cd.item_position_seq = -1
       or bd.item_position = cd.item_position_seq
       or bd.item_position = cd.item_position_ibd_seq
      ) 
QUALIFY row_number() over (partition by bd.trader_reference_nr, bd.movement_ref_number, bd.item_position
                              order by case when bd.item_position = cd.item_position_seq then 1
                                            when bd.item_position = cd.item_position_ibd_seq then 2
                                        end) = 1;
