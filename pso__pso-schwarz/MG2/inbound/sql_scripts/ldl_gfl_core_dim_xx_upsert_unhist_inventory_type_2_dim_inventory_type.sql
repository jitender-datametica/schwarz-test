INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  inv_type_cd,
  inv_type_descr,
  inv_type_descr_de,
  inv_type_descr_en,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)

select de.inv_type_cd,
       de.inv_type_descr,
       de.inv_type_descr as item_type_descr_de,
       coalesce (en.inv_type_descr , 'Unknown') as inv_type_descr_en,
       ${LOAD_ID} dwh_load_id,
       de.dwh_node_cd,
       0 tf_error_fg,
       '' error_descr,
       0 record_id,
       'core_rel' filename
  from(select *
         from core_rel.t_inventory_type
        where lang_cd = 'DE'
      ) de
  left join(select *
            from core_rel.t_inventory_type
            where lang_cd = 'EN'
           ) en
    on de.inv_type_cd = en.inv_type_cd
 union
select '@',
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
