INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  inv_reason_id,
  inv_reason_descr,
  inv_reason_descr_de,
  inv_reason_descr_en,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)

select de.inv_reason_id,
       de.inv_reason_descr,
       de.inv_reason_descr as inv_reason_descr_de,
       coalesce (en.inv_reason_descr , 'Unknown') as inv_reason_descr_en,
       ${LOAD_ID} dwh_load_id,
       de.dwh_node_cd dwh_node_cd,
       0 tf_error_fg,
       '' error_descr,
       0 record_id,
       'core_rel' filename
  from(select *
         from core_rel.t_inventory_reason_1
        where lang_cd = 'DE'
      ) de
  left join(select *
            from core_rel.t_inventory_reason_1
            where lang_cd = 'EN'
           ) en
    on de.inv_reason_id = en.inv_reason_id
 union
select -1,
       'Unbekannt',
       'Unbekannt',
       'Unknown',
       ${LOAD_ID} dwh_load_id,
       'MANUAL' dwh_node_cd,
       0 tf_error_fg,
       '' error_descr,
       0 record_id,
       'core_rel' filename
       ;
