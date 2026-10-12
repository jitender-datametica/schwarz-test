create or replace table dbp_etl.zeitraum_fww_kmo_gld_1 as (
select a.dat,
       a.kjmo,
       case
         when mod(extract(year from a.dat),4) = 0 and
              extract(month from a.dat) >= 3
         then 366
         when mod(extract(year from a.dat),4) = 1 and
              extract(month from a.dat) <= 2
         then 366
         else 365
       end as days_back,
       case
         when extract(month from a.dat) = 2 and
              mod(extract(year from a.dat),4) = 0 and
              extract(day from a.dat) = 29
         then 1
         when extract(month from a.dat) = 2 and
              mod(extract(year from a.dat),4) = 1 and
              extract(day from a.dat) = 28
         then -1
         else 0
       end as sj
from dbp_data.tag_1 a
join (select min(x.kjmo) as min_kjmo,
             max(x.kjmo) as max_kjmo
      from (select kjmo
            from dbp_data.tag_1
            where akt_mo between (select akt_mo from dbp_etl_process.fww_gld_zeitraum_1) and 0
            group by 1) x) b
  on a.kjmo between b.min_kjmo and b.max_kjmo
where a.dat < current_date
);

merge into dbp_etl_process.ekc_zek_1 a using (select a.mandant_id,
                                                             a.art_id,
                                                             a.zek_id,
                                                             case when a.zek_id <> a.zek_vat_id then 1 else 0 end as eigenmarke_fg
                                                      from dbp_data.art_1 a
                                                      join dbp_data.art_wg_zu_per_1 b
                                                        on a.mandant_id = b.mandant_id and
                                                           a.art_id = b.art_id and
                                                           b.arthiertyp_id = 2 and
                                                           b.dat_bis = '9999-12-31'
                                                      join dbp_data.wg_per_1 c
                                                        on a.mandant_id = c.mandant_id and
                                                           b.wg_id = c.wg_id and 
                                                           c.arthiertyp_id = 2 and
                                                           c.dat_bis = '9999-12-31'
                                                      where a.dat_bis = '9999-12-31' and
                                                            a.mandant_id = 1 and
                                                            c.abt_id not in (8)
                                                      group by 1,2,3,4) b
									  
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id
	 
when matched then update set zek_id = b.zek_id,
                             eigenmarke_fg = b.eigenmarke_fg

when not matched then insert (mandant_id,
                              art_id,
                              zek_id,
                              eigenmarke_fg)
                      values (b.mandant_id,
                              b.art_id,
                              b.zek_id,
                              b.eigenmarke_fg)
;

merge into dbp_etl_process.ekc_zek_1 a using (select a.mandant_id,
                                                             a.art_id,
                                                             a.zek_id,
                                                             case when a.eigenmarke_id <> '' then 1 else 0 end as eigenmarke_fg
                                                      from dbp_data.art_1 a
                                                      join dbp_data.art_wg_zu_per_1 b
                                                        on a.mandant_id = b.mandant_id and
                                                           a.art_id = b.art_id and
                                                           b.arthiertyp_id = 2 and
                                                           b.dat_bis = '9999-12-31'
                                                      join dbp_data.wg_per_1 c
                                                        on a.mandant_id = c.mandant_id and
                                                           b.wg_id = c.wg_id and 
                                                           c.arthiertyp_id = 2 and
                                                           c.dat_bis = '9999-12-31'
                                                      where a.dat_bis = '9999-12-31' and
                                                            a.mandant_id = 1 and
                                                            c.abt_id in (8)
                                                      group by 1,2,3,4) b
									  
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id
	 
when matched then update set zek_id = b.zek_id,
                             eigenmarke_fg = b.eigenmarke_fg

when not matched then insert (mandant_id,
                              art_id,
                              zek_id,
                              eigenmarke_fg)
                      values (b.mandant_id,
                              b.art_id,
                              b.zek_id,
                              b.eigenmarke_fg)
;

merge into dbp_etl_process.ekc_zek_1 a using (select a.mandant_id,
                                                             a.art_id,
                                                             a.zek_id,
                                                             case when a.eigenmarke_id <> '' then 1 else 0 end as eigenmarke_fg
                                                      from dbp_data.art_1 a
                                                      where a.dat_bis = '9999-12-31' and
                                                            a.mandant_id > 1
                                                      group by 1,2,3,4) b
									  
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id
	 
when matched then update set zek_id = b.zek_id,
                             eigenmarke_fg = b.eigenmarke_fg

when not matched then insert (mandant_id,
                              art_id,
                              zek_id,
                              eigenmarke_fg)
                      values (b.mandant_id,
                              b.art_id,
                              b.zek_id,
                              b.eigenmarke_fg)
;
