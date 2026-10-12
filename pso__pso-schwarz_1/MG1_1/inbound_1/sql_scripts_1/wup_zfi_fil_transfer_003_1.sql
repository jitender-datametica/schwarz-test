update dbp_data.art_list_wup_zu_per_1 from (select mandant_id,
                                                 wup_id,
                                                 dat_bis
                                          from dbp_data.wup_1
                                          where mandant_id = 1 and
                                                wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.art_list_wup_zu_per.mandant_id = b.mandant_id and
      dbp_data.art_list_wup_zu_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.art_list_wup_zu_per.dat_von and dbp_data.art_list_wup_zu_per.dat_bis
;

update dbp_data.art_wup_nachschub_per_1 from (select mandant_id,
                                                   wup_id,
                                                   dat_bis
                                            from dbp_data.wup_1
                                            where mandant_id = 1 and
                                                  wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.art_wup_nachschub_per.mandant_id = b.mandant_id and
      dbp_data.art_wup_nachschub_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.art_wup_nachschub_per.dat_von and dbp_data.art_wup_nachschub_per.dat_bis
;

update dbp_data.art_wup_ordersatz_1 from (select mandant_id,
                                               wup_id,
                                               dat_bis
                                        from dbp_data.wup_1
                                        where mandant_id = 1 and
                                              wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.art_wup_ordersatz.mandant_id = b.mandant_id and
      dbp_data.art_wup_ordersatz.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.art_wup_ordersatz.dat_von and dbp_data.art_wup_ordersatz.dat_bis
;

update dbp_data.art_wup_status_per_1 from (select mandant_id,
                                                wup_id,
                                                dat_bis
                                         from dbp_data.wup_1
                                         where mandant_id = 1 and
                                               wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.art_wup_status_per.mandant_id = b.mandant_id and
      dbp_data.art_wup_status_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.art_wup_status_per.dat_von and dbp_data.art_wup_status_per.dat_bis
;

update dbp_data.art_wup_vk_per_1 from (select mandant_id,
                                            wup_id,
                                            dat_bis
                                     from dbp_data.wup_1
                                     where mandant_id = 1 and
                                           wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.art_wup_vk_per.mandant_id = b.mandant_id and
      dbp_data.art_wup_vk_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.art_wup_vk_per.dat_von and dbp_data.art_wup_vk_per.dat_bis
;

update dbp_data.art_wup_zu_per_1 from (select mandant_id,
                                            wup_id,
                                            dat_bis
                                     from dbp_data.wup_1
                                     where mandant_id = 1 and
                                           wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.art_wup_zu_per.mandant_id = b.mandant_id and
      dbp_data.art_wup_zu_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.art_wup_zu_per.dat_von and dbp_data.art_wup_zu_per.dat_bis
;

update dbp_data.ek_orderbuch_1 from (select mandant_id,
                                          wup_id,
                                          dat_bis
                                   from dbp_data.wup_1
                                   where mandant_id = 1 and
                                         wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.ek_orderbuch.mandant_id = b.mandant_id and
      dbp_data.ek_orderbuch.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.ek_orderbuch.dat_von and dbp_data.ek_orderbuch.dat_bis
;

update dbp_data.kasse_typ_per_1 from (select mandant_id,
                                           wup_id,
                                           dat_bis
                                    from dbp_data.wup_1
                                    where mandant_id = 1 and
                                          wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.kasse_typ_per.mandant_id = b.mandant_id and
      dbp_data.kasse_typ_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.kasse_typ_per.dat_von and dbp_data.kasse_typ_per.dat_bis
;

update dbp_data.vz_wg_wup_zu_per_1 from (select mandant_id,
                                              wup_id,
                                              dat_bis
                                       from dbp_data.wup_1
                                       where mandant_id = 1 and
                                             wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.vz_wg_wup_zu_per.mandant_id = b.mandant_id and
      dbp_data.vz_wg_wup_zu_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.vz_wg_wup_zu_per.dat_von and dbp_data.vz_wg_wup_zu_per.dat_bis
;

update dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1 from (select mandant_id,
                                                                   wup_id,
                                                                   dat_bis
                                                            from dbp_data.wup_1
                                                            where mandant_id = 1 and
                                                                  wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.mandant_id = b.mandant_id and
      dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.dat_von and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.dat_bis
;

update dbp_data.wup_marktmerkmal_zu_per_1 from (select mandant_id,
                                                     wup_id,
                                                     dat_bis
                                              from dbp_data.wup_1
                                              where mandant_id = 1 and
                                                    wup_aenderung_grund_id = 3) b
                                                
set dat_bis = b.dat_bis

where dbp_data.wup_marktmerkmal_zu_per.mandant_id = b.mandant_id and
      dbp_data.wup_marktmerkmal_zu_per.wup_id = b.wup_id and
      b.dat_bis+1 between dbp_data.wup_marktmerkmal_zu_per.dat_von and dbp_data.wup_marktmerkmal_zu_per.dat_bis
;

create or replace volatile table _zfil_kill as (
select a.mandant_id,
       a.wup_id,
       b.dat
from dbp_data.wup_1 a
join dbp_data.tag_1 b
  on b.dat >= a.dat_bis+1
where a.mandant_id = 1 and
      a.wup_aenderung_grund_id = 3
);

delete from dbp_data.art_list_wup_zu_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.art_wup_nachschub_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.art_wup_ordersatz_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.art_wup_status_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.art_wup_vk_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.art_wup_zu_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.ek_orderbuch_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.kasse_typ_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.vz_wg_wup_zu_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.wup_marktmerkmal_zu_per_1 where (mandant_id,wup_id,dat_von) in (select mandant_id,wup_id,dat from _zfil_kill);
delete from dbp_data.marktbestand_erp_1 where (mandant_id,wup_id,dat) in (select mandant_id,wup_id,dat from _zfil_kill);

update dbp_data.vaus_wup_1 set region_id = 1257 where mandant_id = 2 and wup_id in (4850);
update dbp_data.vaus_wup_1 set region_id = 671  where mandant_id = 2 and wup_id in (3550,3850);
update dbp_data.vaus_wup_1 set region_id = 669  where mandant_id = 2 and wup_id in (3150,3750);
update dbp_data.vaus_wup_1 set region_id = 667  where mandant_id = 2 and wup_id in (4000,4050,4150);

update dbp_data.wup_1 set region_id = 1257 where mandant_id = 2 and wup_id in (4850);
update dbp_data.wup_1 set region_id = 671  where mandant_id = 2 and wup_id in (3550,3850);
update dbp_data.wup_1 set region_id = 669  where mandant_id = 2 and wup_id in (3150,3750);
update dbp_data.wup_1 set region_id = 667  where mandant_id = 2 and wup_id in (4000,4050,4150);
