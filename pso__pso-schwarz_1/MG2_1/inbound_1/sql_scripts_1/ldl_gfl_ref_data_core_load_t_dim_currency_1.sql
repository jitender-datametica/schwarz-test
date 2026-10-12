truncate table core_dim.t_dim_currency_1;
insert into core_dim.t_dim_currency_1 (curr_cd, curr_name, curr_name_de, curr_name_en, used_in_stores_fg, euro_exch_rate, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
select de.curr_cd,
       de.curr_name,
       de.curr_name as curr_name_de,
       en.curr_name as curr_name_en,
       de.used_in_stores_fg,
       r.exchange_rate as euro_exch_rate,
       current_timestamp,
       current_timestamp,
       ${LOAD_ID},
       'CORE_REL'
  from(select *
         from core_rel.t_currency_1
        where lang_cd = 'DE'
      ) de
  join(select *
         from core_rel.t_currency_1
        where lang_cd = 'EN'
      ) en
    on de.curr_cd = en.curr_cd
  left
  join(select *
         from core_rel.t_exchange_rate_1
        where exchange_rate_type_cd = 'BEW_ISK'
          and tgt_curr_cd = 'EUR'
          and dwh_valid_fg = true
      ) r
    on de.curr_cd = r.src_curr_cd
 union
select '@',
       'Unbekannt',
       'Unbekannt',
       'Unknown',
       false,
       null,
       current_timestamp,
       current_timestamp,
       1,
       'MANUAL';
