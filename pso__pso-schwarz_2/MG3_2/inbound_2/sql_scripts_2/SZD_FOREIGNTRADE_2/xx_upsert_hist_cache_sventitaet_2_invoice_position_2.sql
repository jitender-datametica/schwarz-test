INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  finance_key_type_cd,
  finance_id, 
  invoice_finance_key_type_cd,
  invoice_finance_id, 
  product_key_type_cd,
  product_id,    
  origin_country_location_key_type_cd,
  origin_country_location_id,
  export_warehouse_resource_item_key_type_cd,
  export_warehouse_resource_item_id, 
  carrier_party_key_type_cd,
  carrier_party_id, 
  reference_invoice_position_finance_key_type_cd,
  reference_invoice_position_finance_id,  
  invoice_position_seq,
  additional_product_cd,
  product_name,
  business_transaction_type_cd,
  unit_gross_weight_meas,
  unit_net_weight_meas,
  item_net_weight_meas,
  non_food_fg,
  amount_val,
  price_val,
  package_content_cnt,
  package_qty,
  loading_dt,
  batch_nr,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
     select   finance_key_type_cd,
  finance_id, 
  invoice_finance_key_type_cd,
  invoice_finance_id, 
  product_key_type_cd,
  product_id,    
  origin_country_location_key_type_cd,
  origin_country_location_id,
  export_warehouse_resource_item_key_type_cd,
  export_warehouse_resource_item_id, 
  carrier_party_key_type_cd,
  carrier_party_id, 
  reference_invoice_position_finance_key_type_cd,
  reference_invoice_position_finance_id,  
  ROW_NUMBER() OVER (PARTITION BY invoice_finance_id ORDER BY finance_id) as  invoice_position_seq,
  additional_product_cd,
  product_name,
  business_transaction_type_cd,
  unit_gross_weight_meas,
  unit_net_weight_meas,
  item_net_weight_meas,
  non_food_fg,
  amount_val,
  price_val,
  package_content_cnt,
  package_qty,
  loading_dt,
  batch_nr,
  max(dwh_src_file_name),
  max(dwh_src_1_tmsp), 
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  max(filename) 
 from (select distinct
  'INVOICE_POSITION' as  finance_key_type_cd,
  COALESCE(ap.RECHPOSID,'-1') as finance_id, 
  'INVOICE' as  invoice_finance_key_type_cd,
  COALESCE(ap.RECHID,'-1') as invoice_finance_id, 
  'PRODUCT' as  product_key_type_cd, 
  case when try_to_number(substr(case when charindex('_', trim(ep.entitaetsnr)) > 0
                          then substr(trim(ep.entitaetsnr), 1, charindex('_', trim(ep.entitaetsnr)) - 1)
                          else trim(ep.entitaetsnr)
                      end , 7)) is null
                   then substr(case when charindex('_', trim(ep.entitaetsnr)) > 0
                          then substr(trim(ep.entitaetsnr), 1, charindex('_', trim(ep.entitaetsnr)) - 1)
                          else trim(ep.entitaetsnr)
                      end , 1, 6)
                   else case when charindex('_', trim(ep.entitaetsnr)) > 0
                          then substr(trim(ep.entitaetsnr), 1, charindex('_', trim(ep.entitaetsnr)) - 1)
                          else trim(ep.entitaetsnr)
                      end 
               end as product_id, 
  'COUNTRY_2' as  origin_country_location_key_type_cd,
  case when TRIM(la.USTIDLANDCODE)='0' then '-1' else TRIM(la.USTIDLANDCODE) end as origin_country_location_id,
  'EXPORT_WAREHOUSE' as  export_warehouse_resource_item_key_type_cd,
  TRIM(el.ENTITAETSNR) as export_warehouse_resource_item_id, 
  'HAULER' as  carrier_party_key_type_cd,
  TRIM(es.ENTITAETSNR) as carrier_party_id, 
  'INVOICE_POSITION' as  reference_invoice_position_finance_key_type_cd,
  case when ap.REFRECHPOSID='0' then '-1' else ap.REFRECHPOSID end  as reference_invoice_position_finance_id,
  --ROW_NUMBER() OVER (PARTITION BY ap.rechid ORDER BY ap.rechposid) as invoice_position_seq,  
  case when a.buchungskzid not in (23763557, 23763570)
            then case when charindex('_', trim(ep.entitaetsnr)) > 0
                          then substr(trim(ep.entitaetsnr), charindex('_', trim(ep.entitaetsnr)) + 1)
                          else ''
                      end
            else ''
        end as additional_product_cd,
   TRIM(spp.BEZ) as product_name,
   UPPER(TRIM(eb.ENTITAETSNR)) as business_transaction_type_cd,
   spp.BRUTTOMENGE as unit_gross_weight_meas,
   spp.NETTOMENGE as unit_net_weight_meas,
   spp.EINWAAGE as item_net_weight_meas,
   case when spp.PRODGRUID=40277723
                          then 1
                          else 0
                      end as non_food_fg,
    ap.BETRAGHAUSWRG as amount_val,
    ap.PREIS as price_val,
    TRY_TO_NUMBER(TRIM(ei.ENTITAETSNR)) as package_content_cnt,
    vk.MENGE1 as package_qty,
    tr.VERLADEDATUM as loading_dt,
    MAX(TRIM(ea.ENTITAETSNR)) as batch_nr,
    ap.dwh_src_file_name,     
    ap.dwh_src_1_tmsp as dwh_src_1_tmsp,  
    ap.AENDDATUM as dwh_mapping_tmsp,
    0 as tf_error_fg,
    0 as deleted_fg,
    0 as record_id,
    ap.dwh_src_file_name as filename
   from etl.t_cache_abrechpos_2 ap
  join (select distinct rechid, buchungskzid from etl.t_cache_abrech_2) a
                                                                                                               
                                                                                                               
    on ap.rechid = a.rechid 
  join etl.t_cache_sventitaet_2 ep                                                                                                               
    on ap.prodid = ep.entitaetsid 
  left join (
   SELECT DISTINCT
          TRIM(entitaetsart) AS entitaetsart,
          TO_NUMBER(TRIM(entitaetsid)) AS entitaetsid
   FROM etl.t_cache_sventitaethis
   WHERE TRIM(funktionskz) = 'D'
   AND TRIM(entitaetsart) IN ('REPO', 'TEIL')
  ) DR
    on dr.entitaetsart = TRIM(ep.entitaetsart)
    and dr.entitaetsid = TO_NUMBER(TRIM(ep.entitaetsid))
  join etl.t_cache_sventitaet_2 el
    on ap.lagerid = el.entitaetsid  
  join etl.t_cache_abrechtr_2 tr
    on ap.rechtrid = tr.rechtrid 
  join etl.t_cache_sventitaet_2 es
    on tr.spediteurid = es.entitaetsid 
  join etl.t_cache_sventitaet_2 eb
    on ap.geschaeftsartid = eb.entitaetsid 
  join etl.t_cache_sventitaet_2 ei
    on ap.pehid = ei.entitaetsid
  join etl.t_cache_abrechposvk_2 vk_2
    on ap.rechposid = vk.rechposid 
    join (SELECT DISTINCT
                 pp1.rechposid,
                 pp1.partieid
    FROM etl.t_cache_papartieteil_2 pp1
    LEFT JOIN (   SELECT DISTINCT
          TRIM(entitaetsart) AS entitaetsart,
          TO_NUMBER(TRIM(entitaetsid)) AS entitaetsid
   FROM etl.t_cache_sventitaethis
   WHERE TRIM(funktionskz) = 'D'
   AND TRIM(entitaetsart) IN ('REPO', 'TEIL')) dr
    ON TO_NUMBER(TRIM(pp1.partieteilid)) = dr.entitaetsid
    AND dr.entitaetsart = 'TEIL'
    WHERE dr.entitaetsid IS NULL) pp
    on ap.rechposid = pp.rechposid 
  join etl.t_cache_papartie_2 pa
    on pp.partieid = pa.partieid 
  join etl.t_cache_koposekprod_2 ko
    on pa.konposid = ko.konposid 
  join etl.t_cache_ssland_2 la
    on ko.landid = la.landid
  join etl.t_cache_sventitaet_2 ea
    on pp.partieid = ea.entitaetsid
  join (select PRODID,BEZ,BRUTTOMENGE,NETTOMENGE,EINWAAGE,PRODGRUID 
        from etl.t_cache_SPPROD_2  QUALIFY ROW_NUMBER() OVER (PARTITION BY PRODID ORDER BY DWH_SRC_1_TMSP desc) = 1) spp
    on ap.PRODID = spp.PRODID
    where ep.entitaetsart = 'PROD' and CAST(ap.AENDDATUM as date)> CAST(DATEADD(month, -6, GetDate()) as date)
    and dr.entitaetsart is null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,34) ct
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26,27,28,31,32,33,34;        
