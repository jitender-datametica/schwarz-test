truncate table core_dim.T_DIM_EXCHANGE_RATE_TYPE_2;

insert into core_dim.t_dim_exchange_rate_type_2 (exchange_rate_type_cd, exchange_rate_type_descr, exchange_rate_type_descr_de, exchange_rate_type_descr_en, active_for_bus_year_fg, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
select de.exchange_rate_type_cd,
       de.exchange_rate_type_descr,
       de.exchange_rate_type_descr as exchange_rate_type_descr_de,
       en.exchange_rate_type_descr as exchange_rate_type_descr_en,
       de.fixed_rate_fg,
       current_timestamp,
       current_timestamp,
       ${LOAD_ID},
       'CORE_REL'
  from(select *
        from core_rel.t_exchange_rate_type_2
       where lang_cd = 'DE'
      ) de
  join(select *
        from core_rel.t_exchange_rate_type_2
       where lang_cd = 'EN'
      ) en
    on de.exchange_rate_type_cd = en.exchange_rate_type_cd
 union
select '@',
       'Unbekannt',
       'Unbekannt',
       'Unknown',
       false,
       current_timestamp,
       current_timestamp,
       1,
       'MANUAL';
