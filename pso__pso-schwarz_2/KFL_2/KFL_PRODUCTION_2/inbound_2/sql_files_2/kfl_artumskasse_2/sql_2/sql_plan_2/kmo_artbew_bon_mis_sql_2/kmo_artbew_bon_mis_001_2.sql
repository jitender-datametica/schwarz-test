create or replace table dbp_etl.kmo_artbew_wg_sum_tmp_2 like dbp_data.artbew_wg_sum_2;

delete from dbp_etl.kmo_artbew_bon_2
where mandant_id = 6 and 
      kl_art_id in (9800130,9800131,9800132)
;

delete from dbp_etl.kmo_artbew_bon_2
where mandant_id = 2 and 
      kl_art_id in (81841,20268540,148593,20769937)
;

delete from dbp_etl.kmo_artbew_bon_2
where (mandant_id,lkp_art_id) in (select mandant_id,art_id
                                  from dbp_data.art_wg_zu_per_2
                                  where mandant_id = 7 and
                                        arthiertyp_id = 2 and
                                        dat_bis = '9999-12-31' and
                                        wg_id = 969 and
                                        wug_id = 6)
;

delete from dbp_etl.kmo_artbew_bon_2
where (mandant_id,lkp_art_id) in (select mandant_id,art_id 
                                  from dbp_data.art_wg_zu_per_2
                                  where mandant_id = 7 and
                                        arthiertyp_id = 2 and
                                        dat_bis = '9999-12-31' and
                                        wg_id = 980)
;

delete from dbp_etl.kmo_artbew_bon_2
where (mandant_id,lkp_wg_id) in (select mandant_id,wg_id from dbp_data.wg_filter_zu_2 where wg_filter_id = 49)
;

delete from dbp_etl.kmo_artbew_bon_2
where (mandant_id,lkp_art_id) in (select mandant_id,art_id
                                  from dbp_data.art_wg_zu_per_2
                                  where mandant_id in (2,5,6) and
                                        arthiertyp_id = 2 and
                                        dat_bis = '9999-12-31' and
                                        wg_id = 969 and
                                        wug_id between 1 and 4)
;

-- 22.10.2024,-dba-
-- Absatz raus fuer 823|002-004

update dbp_etl.kmo_artbew_bon_2 from (select *
                                    from dbp_data.art_wg_zu_per_2
                                    where arthiertyp_id = 2 and
                                          dat_bis = '9999-12-31' and
                                          wg_id = 823 and
                                          wug_id in (2,3,4)) b

set menge = 0

where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.lkp_art_id = b.art_id
;

insert into dbp_etl.kmo_artbew_wg_sum_tmp_2 (mandant_id
                                          ,wup_id
                                          ,wg_id
                                          ,bewart_id
                                          ,dat
                                          ,nb_id
                                          ,arthiertyp_id
                                          ,umsatz_brutto
                                          ,umsatz_netto
                                          ,umsatz_wrg
                                          ,umsatz_brutto_konz
                                          ,umsatz_netto_konz
                                          ,kjmo
                                          ,menge
                                          ,quelle)
select mandant_id
      ,wup_id
      ,wg_id
      ,1001 as bewart_id
      ,dat
      ,nb_id
      ,arthiertyp_id
      ,sum(umsatz_brutto)
      ,sum(umsatz_netto)
      ,umsatz_wrg
      ,sum(umsatz_brutto_konz)
      ,sum(umsatz_netto_konz)
      ,kjmo
      ,sum(menge)
      ,1 as quelle
from (select l.mandant_id as mandant_id
            ,l.wup_id as wup_id
            ,l.lkp_wg_id as wg_id
            ,l.dat_booking as dat
            ,l.lkp_nb_id as nb_id
            ,2 as arthiertyp_id
            ,umsatz_brutto_ umsatz_brutto  
            ,cast(umsatz_brutto / (1+(lkp_mwst/100)) as decimal(18,4)) as umsatz_netto
            ,lkp_wrg as umsatz_wrg
            ,0 as umsatz_brutto_konz
            ,0 as umsatz_netto_konz
            ,cast(to_varchar(l.dat_booking, 'yyyymm') as integer) as kjmo
            ,menge_ as menge
      from (select mandant_id
                  ,wup_id
                  ,lkp_wg_id 
                  ,dat_booking      
                  ,lkp_posten_id 
                  ,lkp_nb_id
                  ,lkp_mwst
                  ,lkp_wrg
                  ,sum(umsatz_brutto) as umsatz_brutto_
                  ,sum(umsatz_promotion_brutto) as umsatz_promotion_brutto_
                  ,sum(menge) as menge_
            from (select z.mandant_id
                        ,z.bon_id 
                        ,z.wup_id 
                        ,z.lkp_nb_id
                        ,z.lkp_art_id 
                        ,z.lkp_posten_id 
                        ,z.dat_booking
                        ,z.bon_zeile
                        ,cast(z.umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as umsatz_brutto
                        ,z.menge
                        ,z.lkp_mwst
                        ,z.lkp_mwst_id
                        ,z.lkp_wrg
                        ,z.lkp_umrechnungskurs 
                        ,coalesce(cast(promotion_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)), 0) as umsatz_promotion_brutto
                        ,lkp_wg_id
                  from dbp_etl.kmo_artbew_bon_2 z
                  left join (select a.*,
                                    1 as conv_fg
                             from dbp_data.mandant_wrg_zu_per_2 a
                             where a.von_wrg_id is not null and
                                   a.wrg_id <> a.von_wrg_id and
                                   current_date between a.dat_von and a.dat_bis) y
                    on z.mandant_id = y.mandant_id and
                       z.lkp_wrg = y.wrg_id
                  left join (select mandant_id
                                   ,bon_id
                                   ,dat_booking
                                   ,bon_zeile 
                                   ,sum(umsatz_brutto) as promotion_brutto
                             from dbp_etl.kmo_artbew_bon_promotion_2
                             group by 1,2,3,4) p
                    on z.mandant_id = p.mandant_id and 
                       z.bon_id = p.bon_id and 
                       z.dat_booking = p.dat_booking and 
                       z.bon_zeile = p.bon_zeile) z
            group by 1,2,3,4,5,6,7,8) l) a
group by mandant_id,wup_id,wg_id,bewart_id,dat,nb_id,arthiertyp_id,umsatz_wrg,kjmo,quelle
;

update dbp_etl.kmo_artbew_wg_sum_tmp_2
from dbp_data.kurs_2 k

set umsatz_brutto_konz = cast(umsatz_brutto * k.umrechnungskurs as decimal(18,4))
  , umsatz_netto_konz = cast(umsatz_netto * k.umrechnungskurs as decimal(18,4))

where dbp_etl.kmo_artbew_wg_sum_tmp.umsatz_wrg = k.von_wrg_id
  and dbp_etl.kmo_artbew_wg_sum_tmp.dat between k.dat_von and k.dat_bis
  and k.nach_wrg_id = 'EUR'
  and k.kurstyp_id = 3
;

delete from dbp_data.artbew_wg_sum_2
where bewart_id = 1001
  and (mandant_id,wup_id,nb_id,dat) in (select mandant_id,wup_id,nb_id,dat from dbp_etl.kmo_artbew_wg_sum_tmp_2)
  and quelle = 1
;

delete from dbp_data.artbew_wg_sum_2
where bewart_id in (1001,1009) and (mandant_id,wup_id,nb_id,dat) in (select mandant_id,wup_id,nb_id,dat from dbp_etl.kmo_artbew_wg_sum_tmp_2)
  and (mandant_id,wup_id,nb_id,dat) in (select mandant_id,wup_id,nb_id,dat from dbp_data.wupcal_2 where datenlieferung_artbew_wg_sum = 2)
;

delete from dbp_etl.kmo_artbew_wg_sum_tmp_2 
where (mandant_id,wup_id,dat,nb_id) in (select t.mandant_id,t.wup_id,t.dat,t.nb_id
                                        from dbp_etl.kmo_artbew_wg_sum_tmp_2 t
                                        join dbp_data.artbew_wg_sum_2 a
                                          on t.mandant_id = a.mandant_id and 
                                             t.wup_id = a.wup_id and 
                                             t.nb_id = a.nb_id and 
                                             t.dat = a.dat and 
                                             a.bewart_id in (1001,1009))
;

insert into dbp_data.artbew_wg_sum_2 (mandant_id
                                   ,wup_id
                                   ,wg_id
                                   ,bewart_id
                                   ,dat
                                   ,nb_id
                                   ,arthiertyp_id
                                   ,umsatz_brutto
                                   ,umsatz_netto
                                   ,umsatz_wrg
                                   ,umsatz_brutto_konz
                                   ,umsatz_netto_konz
                                   ,kjmo
                                   ,menge
                                   ,quelle
                                   ,umrechnungskurs_hist)
select a.mandant_id
      ,a.wup_id
      ,a.wg_id
      ,a.bewart_id
      ,a.dat
      ,a.nb_id
      ,a.arthiertyp_id
      ,a.umsatz_brutto
      ,a.umsatz_netto
      ,a.umsatz_wrg
      ,a.umsatz_brutto_konz
      ,a.umsatz_netto_konz
      ,a.kjmo
      ,a.menge
      ,a.quelle
      ,k.umrechnungskurs
from dbp_etl.kmo_artbew_wg_sum_tmp_2 a
left join dbp_data.kurs_2 k
  on a.umsatz_wrg = k.von_wrg_id and
     a.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
;

update dbp_data.wupcal_2 set datenlieferung_artbew_wg_sum = 1
where (mandant_id,wup_id,nb_id,dat) in (select mandant_id,wup_id,nb_id,dat from dbp_etl.kmo_artbew_wg_sum_tmp_2)
;

insert into dbp_etl_process.artbew_wg_sum_agg_wt_2 (mandant_id
                                                 ,wup_id
                                                 ,nb_id
                                                 ,dat
                                                 ,calc_fg
                                                 ,dat_lief)
select mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,0 as calc_fg
      ,current_date as dat_lief
from dbp_etl.kmo_artbew_wg_sum_tmp_2
group by 1,2,3,4,5,6
;

delete from dbp_etl.kmo_artbew_bon_2;
delete from dbp_etl.kmo_artbew_bon_promotion_2;
delete from dbp_etl.kmo_artbew_wg_sum_tmp_2;

delete from dbp_etl.kmo_artbew_bon_dat_2;
