INSERT INTO SZD_PRODUCTON.${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (finance_key_type_cd, finance_id, invoice_finance_key_type_cd, invoice_finance_id, product_key_type_cd, product_id, origin_country_location_key_type_cd, origin_country_location_id, export_warehouse_resource_item_key_type_cd, export_warehouse_resource_item_id, carrier_party_key_type_cd, carrier_party_id, reference_invoice_position_finance_key_type_cd, reference_invoice_position_finance_id, invoice_position_seq, additional_product_cd, product_name, business_transaction_type_cd, unit_gross_weight_meas, unit_net_weight_meas, item_net_weight_meas, non_food_fg, amount_val, price_val, package_content_cnt, package_qty, loading_dt, batch_nr, dwh_src_file_name, dwh_src_1_tmsp, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, filename)
  SELECT
      ct.finance_key_type_cd,
      ct.finance_id,
      ct.invoice_finance_key_type_cd,
      ct.invoice_finance_id,
      ct.product_key_type_cd,
      ct.product_id,
      ct.origin_country_location_key_type_cd,
      ct.origin_country_location_id,
      ct.export_warehouse_resource_item_key_type_cd,
      ct.export_warehouse_resource_item_id,
      ct.carrier_party_key_type_cd,
      ct.carrier_party_id,
      ct.reference_invoice_position_finance_key_type_cd,
      ct.reference_invoice_position_finance_id,
      row_number() over (partition by ct.invoice_finance_id order by if(ct.finance_id is null, 0, 1) desc, ct.finance_id) as invoice_position_seq,
      ct.additional_product_cd,
      ct.product_name,
      ct.business_transaction_type_cd,
      ct.unit_gross_weight_meas,
      ct.unit_net_weight_meas,
      ct.item_net_weight_meas,
      ct.non_food_fg,
      ct.amount_val,
      ct.price_val,
      ct.package_content_cnt,
      ct.package_qty,
      ct.loading_dt,
      ct.batch_nr,
      max(ct.dwh_src_file_name),
      max(ct.dwh_src_1_tmsp),
      ct.dwh_mapping_tmsp,
      ct.tf_error_fg,
      ct.deleted_fg,
      ct.record_id,
      max(ct.filename)
    from
      (
        select distinct
            'INVOICE_POSITION' as finance_key_type_cd,
            coalesce(ap.rechposid, '-1') as finance_id,
            'INVOICE' as invoice_finance_key_type_cd,
            coalesce(ap.rechid, '-1') as invoice_finance_id,
            'PRODUCT' as product_key_type_cd,
            case
              when round(safe_cast(substr(case
                when strpos(trim(ep.entitaetsnr, ' '), '_') > 0 then substr(trim(ep.entitaetsnr, ' '), 1, cast(strpos(trim(ep.entitaetsnr, ' '), '_') - 1 as int64))
                else trim(ep.entitaetsnr, ' ')
              end, 7) as bignumeric), 0) is null then substr(case
                when strpos(trim(ep.entitaetsnr, ' '), '_') > 0 then substr(trim(ep.entitaetsnr, ' '), 1, cast(strpos(trim(ep.entitaetsnr, ' '), '_') - 1 as int64))
                else trim(ep.entitaetsnr, ' ')
              end, 1, 6)
              else case
                when strpos(trim(ep.entitaetsnr, ' '), '_') > 0 then substr(trim(ep.entitaetsnr, ' '), 1, cast(strpos(trim(ep.entitaetsnr, ' '), '_') - 1 as int64))
                else trim(ep.entitaetsnr, ' ')
              end
            end as product_id,
            'COUNTRY_2' as origin_country_location_key_type_cd,
            case
              when trim(la.ustidlandcode, ' ') = '0' then '-1'
              else trim(la.ustidlandcode, ' ')
            end as origin_country_location_id,
            'EXPORT_WAREHOUSE' as export_warehouse_resource_item_key_type_cd,
            trim(el.entitaetsnr, ' ') as export_warehouse_resource_item_id,
            'HAULER' as carrier_party_key_type_cd,
            trim(es.entitaetsnr, ' ') as carrier_party_id,
            'INVOICE_POSITION' as reference_invoice_position_finance_key_type_cd,
            case
              when ap.refrechposid = '0' then '-1'
              else ap.refrechposid
            end as reference_invoice_position_finance_id,
            -- row_number() over (partition by ap.rechid order by ap.rechposid) as invoice_position_seq,
            case
              when a.buchungskzid not in(
                23763557, 23763570
              ) then case
                when strpos(trim(ep.entitaetsnr, ' '), '_') > 0 then substr(trim(ep.entitaetsnr, ' '), cast(strpos(trim(ep.entitaetsnr, ' '), '_') + 1 as int64))
                else ''
              end
              else ''
            end as additional_product_cd,
            trim(spp.bez, ' ') as product_name,
            upper(trim(eb.entitaetsnr, ' ')) as business_transaction_type_cd,
            spp.bruttomenge as unit_gross_weight_meas,
            spp.nettomenge as unit_net_weight_meas,
            spp.einwaage as item_net_weight_meas,
            case
              when spp.prodgruid = 40277723 then 1
              else 0
            end as non_food_fg,
            ap.betraghauswrg as amount_val,
            ap.preis as price_val,
            round(safe_cast(trim(ei.entitaetsnr, ' ') as bignumeric), 0) as package_content_cnt,
            vk.menge1 as package_qty,
            tr.verladedatum as loading_dt,
            max(trim(ea.entitaetsnr, ' ')) as batch_nr,
            ap.dwh_src_file_name,
            ap.dwh_src_1_tmsp as dwh_src_1_tmsp,
            ap.aenddatum as dwh_mapping_tmsp,
            0 as tf_error_fg,
            0 as deleted_fg,
            0 as record_id,
            ap.dwh_src_file_name as filename
          from
            szd_production.etl.t_cache_abrechpos_2 as ap
            inner join (
              select distinct
                  t_cache_abrech.rechid,
                  t_cache_abrech.buchungskzid
                from
                  szd_production.etl.t_cache_abrech_2
            ) as a on ap.rechid = a.rechid
            inner join szd_production.etl.t_cache_sventitaet_2 as ep on ap.prodid = ep.entitaetsid
            left outer join (
              select distinct
                  entitaetsart as entitaetsart,
                  round(cast(trim(t_cache_sventitaethis.entitaetsid, ' ') as bignumeric), 0) as entitaetsid
                from
                  szd_production.etl.t_cache_sventitaethis
                  cross join unnest(array[
                    trim(t_cache_sventitaethis.entitaetsart, ' ')
                  ]) as entitaetsart
                where trim(t_cache_sventitaethis.funktionskz, ' ') = 'D'
                 and trim(entitaetsart, ' ') in(
                  'REPO', 'TEIL'
                )
            ) as dr on dr.entitaetsart = trim(ep.entitaetsart, ' ')
             and dr.entitaetsid = round(cast(trim(ep.entitaetsid, ' ') as bignumeric), 0)
            inner join szd_production.etl.t_cache_sventitaet_2 as el on ap.lagerid = el.entitaetsid
            inner join szd_production.etl.t_cache_abrechtr_2 as tr on ap.rechtrid = tr.rechtrid
            inner join szd_production.etl.t_cache_sventitaet_2 as es on tr.spediteurid = es.entitaetsid
            inner join szd_production.etl.t_cache_sventitaet_2 as eb on ap.geschaeftsartid = eb.entitaetsid
            inner join szd_production.etl.t_cache_sventitaet_2 as ei on ap.pehid = ei.entitaetsid
            inner join szd_production.etl.t_cache_abrechposvk_2 as vk_2 on ap.rechposid = vk.rechposid
            inner join (
              select distinct
                  pp1.rechposid,
                  pp1.partieid
                from
                  szd_production.etl.t_cache_papartieteil_2 as pp1
                  left outer join (
                    select distinct
                        entitaetsart as entitaetsart,
                        round(cast(trim(t_cache_sventitaethis.entitaetsid, ' ') as bignumeric), 0) as entitaetsid
                      from
                        szd_production.etl.t_cache_sventitaethis
                        cross join unnest(array[
                          trim(t_cache_sventitaethis.entitaetsart, ' ')
                        ]) as entitaetsart
                      where trim(t_cache_sventitaethis.funktionskz, ' ') = 'D'
                       and trim(entitaetsart, ' ') in(
                        'REPO', 'TEIL'
                      )
                  ) as dr_0 on round(cast(trim(pp1.partieteilid, ' ') as bignumeric), 0) = dr_0.entitaetsid
                   and dr_0.entitaetsart = 'TEIL'
                where dr_0.entitaetsid is null
            ) as pp on ap.rechposid = pp.rechposid
            inner join szd_production.etl.t_cache_papartie_2 as pa on pp.partieid = pa.partieid
            inner join szd_production.etl.t_cache_koposekprod_2 as ko on pa.konposid = ko.konposid
            inner join szd_production.etl.t_cache_ssland_2 as la on ko.landid = la.landid
            inner join szd_production.etl.t_cache_sventitaet_2 as ea on pp.partieid = ea.entitaetsid
            inner join (
              select
                  t_cache_spprod.prodid,
                  t_cache_spprod.bez,
                  t_cache_spprod.bruttomenge,
                  t_cache_spprod.nettomenge,
                  t_cache_spprod.einwaage,
                  t_cache_spprod.prodgruid
                from
                  szd_production.etl.t_cache_spprod_2
                qualify row_number() over (partition by prodid order by if(t_cache_spprod.dwh_src_1_tmsp is null, 0, 1), t_cache_spprod.dwh_src_1_tmsp desc) = 1
            ) as spp on ap.prodid = spp.prodid
          where ep.entitaetsart = 'PROD'
           and cast(p.aenddatum as date) > date(timestamp_add(current_timestamp(), interval -6 month))
           and dr.entitaetsart is null
          group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29, 30, 31, 32, 33, 34
      ) as ct
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 31, 32, 33, 34
;
