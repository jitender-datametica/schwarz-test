INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
movement_ref_number, 
item_position, 
clearance_dt, 
cy_month, 
authority_country_location_sid, 
consignor_party_sid, 
importer_party_sid, 
importer_number, 
declarant_party_sid, 
acceptance_dt, 
declarant_number, 
declarant_name, 
declarant_authorized_fg, 
customs_declaration_type_cd, 
customs_procedure_cd, 
customs_preference_cd, 
origin_country_location_sid, 
origin_iso_country_cd, 
customs_product_sid, 
customs_tariff_number_cd, 
customs_product_number, 
article_variant_nr,
goods_descr, 
trader_reference, 
curr_cd, 
vat_paid_val, 
duty_paid_val, 
net_weight_meas, 
customs_val,
preference_indicator_txt,
allocation_cnt,
package_cnt,
item_cnt,	
batch_nr_txt,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg
)
select 
distinct 
       crl.movement_ref_number,
       crl.item_position,
       ccr.clearance_dt,  
       cd.cy_month,
       ccr.authority_country_location_sid,
       ccr.consignor_party_sid,
       ccr.importer_party_sid,
       imp.importer_nr,
       coalesce(ccr.broker_declarant_party_sid, ccr.importer_declarant_party_sid, -1) as declarant_party_sid,
       ccr.acceptance_dt,
       dcl.declarant_nr,
       dcl.declarant_name,
       dcl.declarant_authorized_fg,
       ccr.customs_declaration_type_cd,
       crl.customs_procedure_cd,
       crl.customs_preference_cd,
       crl.origin_country_location_sid,
       ocp.iso_country_cd as origin_iso_country_cd,
       crl.customs_product_sid,
       /*case when crl.customs_product_sid = -1
            then crl.customs_tariff_code_cd
            else cpr.customs_tariff_number_cd
        end as customs_tariff_number_cd,*/
       coalesce(crl.customs_tariff_code_cd, cpr.customs_tariff_number_cd) as customs_tariff_number_cd,
       /*coalesce(case when length(cpr.customs_additional_cd) > 0
                     then cpr.customs_product_nr || '_' || cpr.customs_additional_cd
                     else to_char(cpr.customs_product_nr)
                 end, 'Unknown') as customs_product_number,*/
       coalesce(case when length(cpr.customs_additional_cd) > 0
                     then cpr.customs_product_nr || '_' || cpr.customs_additional_cd
                     else to_char(cpr.customs_product_nr)
                 end, pnr.customs_product_nr, 'Unknown') as customs_product_number, 
       /*case when crl.customs_product_sid = -1
            then crl.goods_descr
            else cpr.customs_product_name
        end as goods_descr, */
       col.article_variant_nr,
       coalesce(crl.goods_descr, cpr.customs_product_name) as goods_descr,
       ccr.trader_reference,
       'GBP' as curr_cd,
       coalesce(crl.vat_paid_val, 0) as vat_paid_val,
       coalesce(crl.duty_paid_val, 0) as duty_paid_val,
       coalesce(crl.net_mass_qty, 0) as net_weight_meas,
       coalesce(crl.customs_val, 0) as customs_val,
       nullif(col.preference_indicator_txt, '') as preference_indicator_txt,
       col.allocation_cnt,
       col.packages_cnt,
       col.item_cnt,
       col.batch_nr_txt,
  crl.dwh_src_1_tmsp dwh_mapping_tmsp,
crl.dwh_src_file_name,
crl.dwh_src_1_tmsp,
0 tf_error_fg,
0 as dwh_load_id,
0 record_id,
crl.dwh_src_file_name filename,
0 deleted_fg
  from core_rel.t_customs_clearance_report_line crl
  join core_rel.t_customs_clearance_report ccr
    on crl.movement_ref_number = ccr.movement_ref_number
    and crl.clearance_dt = ccr.clearance_dt
  join CORE.T_DIM_CAL_DAY cd
    on ccr.clearance_dt = cd.cal_dt
  join core.t_dim_declarant dcl
    on coalesce(ccr.broker_declarant_party_sid, ccr.importer_declarant_party_sid, -1) = dcl.party_sid
   and ccr.clearance_dt between dcl.dwh_valid_from_tmsp and dcl.dwh_valid_to_tmsp
  join core.t_dim_importer imp
    on ccr.importer_party_sid = imp.party_sid
  and ccr.clearance_dt between imp.dwh_valid_from_tmsp and imp.dwh_valid_to_tmsp
  join core.t_dim_country_political ocp
    on crl.origin_country_location_sid = ocp.location_sid
  left
  join core.t_dim_customs_product cpr
    on crl.customs_product_sid = cpr.product_sid
   and ccr.clearance_dt between cpr.dwh_valid_from_tmsp and cpr.dwh_valid_to_tmsp

left
  join(select distinct
              product_sid,
              case when additional_cd = ''
                   then customs_product_nr
                   else customs_product_nr || '_' || additional_cd
               end customs_product_nr  , 
       pnr.dwh_valid_from_tmsp,  pnr.dwh_valid_to_tmsp  
         from core_rel.t_customs_product pnr
      ) pnr   
    on crl.customs_product_sid = pnr.product_sid 
  and ccr.clearance_dt between  pnr.dwh_valid_from_tmsp and pnr.dwh_valid_to_tmsp 
  left
  join (
    SELECT coll.trader_reference_nr,
                 coll.item_position_seq,
                 cpr.customs_product_type_cd,
                 coll.customs_product_sid,
                 CASE WHEN coll.additional_cd != '' THEN coll.product_nr || '_' || coll.additional_cd ELSE coll.product_nr END AS customs_product_nr,
                 coll.article_variant_nr,
                 LISTAGG(DISTINCT cudo.customs_document_cd, '; ') WITHIN GROUP (ORDER BY cudo.customs_document_cd) AS preference_indicator_txt,
                 SUM(coll.allocation_cnt) AS allocation_cnt,
                 SUM(coll.packages_cnt) AS packages_cnt,
                 SUM(coll.allocation_cnt * coll.packages_cnt) AS item_cnt,
                 LISTAGG(DISTINCT coll.batch_nr, ', ') WITHIN GROUP (ORDER BY coll.batch_nr) AS batch_nr_txt
    FROM core_rel.t_consignor_order_list_line coll
    JOIN core_rel.t_customs_product cpr
    ON coll.customs_product_sid = cpr.product_sid
    AND coll.order_dt BETWEEN cpr.dwh_valid_from_tmsp AND cpr.dwh_valid_to_tmsp 
    LEFT JOIN core_rel.t_consignor_order_list_line_document_rel codr
    ON coll.trader_reference_nr = codr.trader_reference_nr 
    AND coll.order_dt = codr.order_dt 
    AND coll.item_position_seq = codr.item_position_seq 
    AND codr.preference_indicator_fg = true
    LEFT JOIN core_rel.t_customs_document cudo
    ON codr.resource_item_sid = cudo.resource_item_sid  
    WHERE cpr.customs_product_type_cd = 'GTS'   
    GROUP BY ALL
	UNION
    SELECT coll.trader_reference_nr,
                 -1 as item_position_seq,
                 cpr.customs_product_type_cd,
                 coll.customs_product_sid,
                 CASE WHEN coll.additional_cd != '' THEN coll.product_nr || '_' || coll.additional_cd ELSE coll.product_nr END AS customs_product_nr,
                 coll.article_variant_nr,
                 LISTAGG(DISTINCT cudo.customs_document_cd, '; ') WITHIN GROUP (ORDER BY cudo.customs_document_cd) AS preference_indicator_txt,
                 SUM(coll.allocation_cnt) / count(*) AS allocation_cnt,
                 SUM(coll.packages_cnt) / count(*) AS packages_cnt,
                 SUM(coll.allocation_cnt * coll.packages_cnt) / count(*) AS item_cnt,
                 LISTAGG(DISTINCT coll.batch_nr, ', ') WITHIN GROUP (ORDER BY coll.batch_nr) AS batch_nr_txt
    FROM core_rel.t_consignor_order_list_line coll 
    JOIN core_rel.t_customs_product cpr
    ON coll.product_nr = cpr.customs_product_nr
    AND coll.additional_cd = cpr.additional_cd 
    AND coll.origin_country_location_sid = cpr.origin_country_location_sid
    AND coll.order_dt BETWEEN cpr.dwh_valid_from_tmsp AND cpr.dwh_valid_to_tmsp 
    LEFT JOIN core_rel.t_consignor_order_list_line_document_rel codr
    ON coll.trader_reference_nr = codr.trader_reference_nr 
    AND coll.order_dt = codr.order_dt 
    AND coll.item_position_seq = codr.item_position_seq 
    AND codr.preference_indicator_fg = TRUE
    LEFT JOIN core_rel.t_customs_document cudo
    ON codr.resource_item_sid = cudo.resource_item_sid 
    WHERE cpr.customs_product_type_cd = 'WWT'   
    GROUP BY ALL
    ) col
	ON CASE WHEN ccr.trader_reference LIKE '%-SDI' THEN SUBSTR(ccr.trader_reference, 1, LENGTH(ccr.trader_reference) - 4)
               ELSE ccr.trader_reference
      END = col.trader_reference_nr
	AND CASE WHEN LENGTH(cpr.customs_additional_cd) > 0 THEN cpr.customs_product_nr || '_' || cpr.customs_additional_cd
                        ELSE TO_CHAR(cpr.customs_product_nr)
              END = col.customs_product_nr
	AND(crl.item_position = col.item_position_seq OR col.customs_product_type_cd = 'WWT')

where /*dcl.dwh_valid_fg and imp.dwh_valid_fg and ocp.dwh_valid_fg
/*and coalesce(cpr.dwh_valid_fg,1)*/  ccr.trader_reference is not null
;
