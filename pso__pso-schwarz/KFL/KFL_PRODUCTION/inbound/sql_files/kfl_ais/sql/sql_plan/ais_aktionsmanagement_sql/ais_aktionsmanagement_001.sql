set (aw) = (${WW});

set (akt_woche) = (SELECT kjwo_ww FROM dbp_data.werbewoche_kl WHERE mandant_id = 1 AND akt_kjwo_ww = $aw   GROUP BY 1);
set (vor_woche) = (SELECT kjwo_ww FROM dbp_data.werbewoche_kl WHERE mandant_id = 1 AND akt_kjwo_ww = $aw-1 GROUP BY 1);
set (flg_woche) = (SELECT kjwo_ww FROM dbp_data.werbewoche_kl WHERE mandant_id = 1 AND akt_kjwo_ww = $aw+1 GROUP BY 1);

create or replace volatile table _hit_the_actions as (
select akt.mandant_id,
       w.wup_id,
       x.kjwo_ww as kjwo,
       akt.aktion_id,
       cast('' as varchar(20)) as aktion_thema_gruppe_id,
       akt.werbe_kat_id,
       akta.art_id as art_id,
       a.kl_art_id as kl_art_id,
       'W' as muki,
       akt.dat_von,
       akt.dat_bis,
       cast(1 as decimal(15,3)) as mengen_faktor,
       a.posten_id,
       cast(0 as decimal(9,2)) as vk_brutto
from dbp_data.aktion akt
join dbp_data.aktion_art_wup_zu akta
  on akt.aktion_id = akta.aktion_id and 
     akt.mandant_id = akta.mandant_id
join dbp_data.art a
  on akta.mandant_id = a.mandant_id and 
     a.mutter_wb_id is null and 
     akta.art_id = a.art_id
join dbp_data.wup w
  on akta.wup_id = w.wup_id and 
     akta.mandant_id = w.mandant_id and 
     w.nb_id = 0 and 
     akt.dat_von between w.dat_von and w.dat_bis 
join dbp_data.art_wg_zu_per aw
  on akta.art_id = aw.art_id and 
     akta.mandant_id = aw.mandant_id and 
     akta.art_id = aw.art_id and 
     aw.arthiertyp_id = 2 and 
     aw.dat_bis = '9999-12-31'
join dbp_data.wg_per wp
  on aw.mandant_id = wp.mandant_id and 
     aw.arthiertyp_id = wp.arthiertyp_id and 
     aw.wg_id = wp.wg_id and 
     wp.dat_bis = '9999-12-31'
join (select a.kjwo_ww,
             min(coalesce(b.dat,a.dat)) as min_dat,
             max(coalesce(b.dat,a.dat)) as max_dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.akt_kjwo_ww = $aw and
            a.mandant_id = 1
      group by 1) x
  on akt.dat_bis between x.min_dat and x.max_dat
where akta.dat_sperrung is null and
      akt.preisaktiviert_fg = 1 and
      akt.mandant_id = 1
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
union all
select akt.mandant_id,
       w.wup_id,
       x.kjwo_ww as kjwo,
       akt.aktion_id,
       cast('' as varchar(20)) as aktion_thema_gruppe_id,
       akt.werbe_kat_id,
       akta.art_id as art_id,
       a.kl_art_id as kl_art_id,
       'M' as muki,
       akt.dat_von,
       akt.dat_bis,
       cast(1 as decimal(15,3)) as mengen_faktor,
       a.posten_id,
       cast(0 as decimal(9,2)) as vk_brutto
from dbp_data.aktion akt
join dbp_data.aktion_art_wup_zu akta
  on akt.aktion_id = akta.aktion_id and 
     akt.mandant_id = akta.mandant_id
join dbp_data.art a
  on akta.mandant_id = a.mandant_id and 
     a.mutter_wb_id is not null and 
     akta.art_id = a.mutter_wb_id
join dbp_data.wup w
  on akta.wup_id = w.wup_id and 
     akta.mandant_id = w.mandant_id and 
     w.nb_id = 0 and 
     akt.dat_von between w.dat_von and w.dat_bis
join dbp_data.art_wg_zu_per aw
  on akta.art_id = aw.art_id and 
     akta.mandant_id = aw.mandant_id and 
     akta.art_id = aw.art_id and 
     aw.arthiertyp_id = 2 and 
     aw.dat_bis = '9999-12-31'
join dbp_data.wg_per wp
  on aw.mandant_id = wp.mandant_id and 
     aw.arthiertyp_id = wp.arthiertyp_id and 
     aw.wg_id = wp.wg_id and 
     wp.dat_bis = '9999-12-31'
join (select a.kjwo_ww,
             min(coalesce(b.dat,a.dat)) as min_dat,
             max(coalesce(b.dat,a.dat)) as max_dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.akt_kjwo_ww = $aw and
            a.mandant_id = 1
      group by 1) x
  on akt.dat_bis between x.min_dat and x.max_dat
where akta.dat_sperrung is null and
      akt.preisaktiviert_fg = 1 and
      akt.mandant_id = 1
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
);

insert into _hit_the_actions
select a.mandant_id,
       a.wup_id,
       b.kjwo_ww,
       a.aktion_id,
       a.aktion_thema_gruppe_id,
       a.werbe_kat_id,
       a.art_id,
       a.kl_art_id,
       a.muki,
       a.dat_von,
       a.dat_bis,
       a.mengen_faktor,
       a.posten_id,
       a.vk_brutto
from _hit_the_actions a
join (select a.kjwo_ww,
             min(coalesce(b.dat,a.dat)) as min_dat,
             max(coalesce(b.dat,a.dat)) as max_dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1) b
  on a.dat_von between b.min_dat and b.max_dat
where a.kjwo <> b.kjwo_ww
;

insert into _hit_the_actions
select a.mandant_id,
       a.wup_id,
       x.kjwo_ww as kjwo,
       a.aktion_id,
       '' as aktion_thema_gruppe_id,
       null as werbe_kat_id,
       b.art_id as art_id,
       b.kl_art_id as kl_art_id,
       'W' as muki,
       '9999-12-31',
       '9999-12-31',
       cast(1 as decimal(15,3)) as mengen_faktor,
       b.posten_id,
       cast(0 as decimal(9,2)) as vk_brutto
from dbp_data.artbew a
join dbp_data.art b
  on a.mandant_id = b.mandant_id and 
     b.mutter_wb_id is null and 
     a.art_id = b.art_id
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.akt_kjwo_ww = $aw and
            a.mandant_id = 1
      group by 1,2,3) x
  on a.mandant_id = x.mandant_id and
     a.dat = x.dat
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
     (a.mandant_id,a.wup_id,a.art_id) not in (select mandant_id,wup_id,art_id from _hit_the_actions) and
      a.aktion_id <> '999999999'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
union all
select a.mandant_id,
       a.wup_id,
       x.kjwo_ww as kjwo,
       a.aktion_id,
       '' as aktion_thema_gruppe_id,
       null as werbe_kat_id,
       b.mutter_wb_id as art_id,
       b.kl_art_id as kl_art_id,
       'M' as muki,
       '9999-12-31',
       '9999-12-31',
       cast(1 as decimal(15,3)) as mengen_faktor,
       b.posten_id,
       cast(0 as decimal(9,2)) as vk_brutto
from dbp_data.artbew a
join dbp_data.art b
  on a.mandant_id = b.mandant_id and 
     b.mutter_wb_id is not null and 
     a.art_id = b.art_id
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.akt_kjwo_ww = $aw and
            a.mandant_id = 1
      group by 1,2,3) x
  on a.mandant_id = x.mandant_id and
     a.dat = x.dat
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
     (a.mandant_id,a.wup_id,a.art_id) not in (select mandant_id,wup_id,art_id from _hit_the_actions) and
      a.aktion_id <> '999999999'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

create or replace volatile table _hilfe1 as (
select a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       a.bewart_id,

       max(a.aktionsart_id_liste_txt) as aktionsart_id_liste_txt,
       max(a.aktionsart_bez_liste_txt) as aktionsart_bez_liste_txt,
       max(a.aktion_typ_id_liste_txt) as aktion_typ_id_liste_txt,
       max(a.aktion_typ_bez_liste_txt) as aktion_typ_bez_liste_txt,

       max(a.gp_id) as gp_id,
       sum(a.umsatz_netto) as umsatz_netto,
       sum(a.menge) as menge,
       sum(a.ek_mep) as ek_mep,
       sum(a.logkostenzuschlag) as logkostenzuschlag,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.menge else 0 end) as menge_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.menge else 0 end) as menge_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.menge else 0 end) as menge_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.menge else 0 end) as menge_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.menge else 0 end) as menge_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.menge else 0 end) as menge_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.menge else 0 end) as menge_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.menge else 0 end) as menge_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.menge else 0 end) as menge_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.menge else 0 end) as menge_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.ek_mep else 0 end) as ek_mep_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.ek_mep else 0 end) as ek_mep_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.ek_mep else 0 end) as ek_mep_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.ek_mep else 0 end) as ek_mep_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.ek_mep else 0 end) as ek_mep_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.ek_mep else 0 end) as ek_mep_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.ek_mep else 0 end) as ek_mep_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.ek_mep else 0 end) as ek_mep_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_non_loyalty

from dbp_data.artbew a
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo = $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo and
     a.wup_id = g.wup_id
where a.mandant_id = 1 and
      a.bewart_id = 1002
group by all
);

create or replace volatile table _hilfe2 as (
select a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       a.bewart_id,

       max(a.aktionsart_id_liste_txt) as aktionsart_id_liste_txt,
       max(a.aktionsart_bez_liste_txt) as aktionsart_bez_liste_txt,
       max(a.aktion_typ_id_liste_txt) as aktion_typ_id_liste_txt,
       max(a.aktion_typ_bez_liste_txt) as aktion_typ_bez_liste_txt,

       max(a.gp_id) as gp_id,
       sum(a.umsatz_netto) as umsatz_netto,
       sum(a.menge) as menge,
       sum(a.ek_mep) as ek_mep,
       sum(a.logkostenzuschlag) as logkostenzuschlag,
       
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.menge else 0 end) as menge_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.menge else 0 end) as menge_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.menge else 0 end) as menge_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.menge else 0 end) as menge_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.menge else 0 end) as menge_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.menge else 0 end) as menge_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.menge else 0 end) as menge_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.menge else 0 end) as menge_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.menge else 0 end) as menge_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.menge else 0 end) as menge_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.ek_mep else 0 end) as ek_mep_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.ek_mep else 0 end) as ek_mep_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.ek_mep else 0 end) as ek_mep_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.ek_mep else 0 end) as ek_mep_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.ek_mep else 0 end) as ek_mep_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.ek_mep else 0 end) as ek_mep_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.ek_mep else 0 end) as ek_mep_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.ek_mep else 0 end) as ek_mep_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_non_loyalty
       
from dbp_data.artbew a
join (select a.mandant_id,
             a.kjwo_ww,
             a.akt_kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3,4) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo <> $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo and
     a.wup_id = g.wup_id
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
      f.akt_kjwo_ww = $aw-1
group by all
);

create or replace volatile table _hilfe3 as (
select a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       a.bewart_id,

       max(a.aktionsart_id_liste_txt) as aktionsart_id_liste_txt,
       max(a.aktionsart_bez_liste_txt) as aktionsart_bez_liste_txt,
       max(a.aktion_typ_id_liste_txt) as aktion_typ_id_liste_txt,
       max(a.aktion_typ_bez_liste_txt) as aktion_typ_bez_liste_txt,

       max(a.gp_id) as gp_id,
       sum(a.umsatz_netto) as umsatz_netto,
       sum(a.menge) as menge,
       sum(a.ek_mep) as ek_mep,
       sum(a.logkostenzuschlag) as logkostenzuschlag,
       
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.menge else 0 end) as menge_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.menge else 0 end) as menge_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.menge else 0 end) as menge_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.menge else 0 end) as menge_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.menge else 0 end) as menge_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.menge else 0 end) as menge_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.menge else 0 end) as menge_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.menge else 0 end) as menge_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.menge else 0 end) as menge_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.menge else 0 end) as menge_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.ek_mep else 0 end) as ek_mep_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.ek_mep else 0 end) as ek_mep_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.ek_mep else 0 end) as ek_mep_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.ek_mep else 0 end) as ek_mep_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.ek_mep else 0 end) as ek_mep_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.ek_mep else 0 end) as ek_mep_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.ek_mep else 0 end) as ek_mep_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.ek_mep else 0 end) as ek_mep_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_non_loyalty
       
from dbp_data.artbew a
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo = $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo and
     a.wup_id = g.wup_id
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
      a.aktion_id = '999999999'
group by all
);

create or replace volatile table _hilfe4 as (
select a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       a.bewart_id,

       max(a.aktionsart_id_liste_txt) as aktionsart_id_liste_txt,
       max(a.aktionsart_bez_liste_txt) as aktionsart_bez_liste_txt,
       max(a.aktion_typ_id_liste_txt) as aktion_typ_id_liste_txt,
       max(a.aktion_typ_bez_liste_txt) as aktion_typ_bez_liste_txt,

       max(a.gp_id) as gp_id,
       sum(a.umsatz_netto) as umsatz_netto,
       sum(a.menge) as menge,
       sum(a.ek_mep) as ek_mep,
       sum(a.logkostenzuschlag) as logkostenzuschlag,
       
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.umsatz_netto else 0 end) as umsatz_netto_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.umsatz_netto else 0 end) as umsatz_netto_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.umsatz_netto else 0 end) as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.menge else 0 end) as menge_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.menge else 0 end) as menge_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.menge else 0 end) as menge_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.menge else 0 end) as menge_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.menge else 0 end) as menge_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.menge else 0 end) as menge_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.menge else 0 end) as menge_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.menge else 0 end) as menge_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.menge else 0 end) as menge_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.menge else 0 end) as menge_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.ek_mep else 0 end) as ek_mep_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.ek_mep else 0 end) as ek_mep_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.ek_mep else 0 end) as ek_mep_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.ek_mep else 0 end) as ek_mep_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.ek_mep else 0 end) as ek_mep_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.ek_mep else 0 end) as ek_mep_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.ek_mep else 0 end) as ek_mep_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.ek_mep else 0 end) as ek_mep_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.ek_mep else 0 end) as ek_mep_sa_bonrabatt_bby_non_loyalty,
  
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.logkostenzuschlag else 0 end) as logkostenzuschlag_sa_bby_non_loyalty
       
from dbp_data.artbew a
join (select a.mandant_id,
             a.kjwo_ww,
             a.akt_kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3,4) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo <> $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo and
     a.wup_id = g.wup_id
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
      f.akt_kjwo_ww = $aw-1 and
      a.aktion_id = '999999999'
group by all
);

create or replace volatile table _hilfe11 as (
select a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       a.bewart_id,
       sum(case when a.bewart_id = 1002 then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa,
       sum(case when a.bewart_id = 1002 and e.kreistyp_gruppe_id IN ('N','W') then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_west,
       sum(case when a.bewart_id = 1002 and e.kreistyp_gruppe_id IN ('O','Q') then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_ost,
       sum(case when a.bewart_id = 1002 and e.kreistyp_gruppe_id IN ('G','M') then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_sued,
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty
from dbp_data.artbew_dat_ek_cp_sum a
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo = $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo and
     a.wup_id = g.wup_id
JOIN dbp_data.wup e
  ON a.mandant_id = e.mandant_id AND
     a.wup_id = e.wup_id
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
      a.wup_bereinigt_fg = 0
group by 1,2,3,4,5
having (coalesce(wa_kalk_abschriften_sa,0) <> 0 or
        coalesce(wa_kalk_abschriften_sa_loyalty,0) <> 0)
);

create or replace volatile table _hilfe22 as (
select a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       a.bewart_id,
       sum(case when a.bewart_id = 1002 then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa,
       sum(case when a.bewart_id = 1002 and e.kreistyp_gruppe_id IN ('N','W') then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_west,
       sum(case when a.bewart_id = 1002 and e.kreistyp_gruppe_id IN ('O','Q') then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_ost,
       sum(case when a.bewart_id = 1002 and e.kreistyp_gruppe_id IN ('G','M') then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_sued,
       sum(case when a.bewart_det_id in (100211,100221,100231,100241,100251) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_loyalty,
       sum(case when a.bewart_det_id in (100211) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_aktion_loyalty,
       sum(case when a.bewart_det_id in (100221) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bby_loyalty,
       sum(case when a.bewart_det_id in (100231) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_kdn_bby_loyalty,
       sum(case when a.bewart_det_id in (100241) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_kdp_bby_loyalty,
       sum(case when a.bewart_det_id in (100251) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
       sum(case when a.bewart_det_id in (100210,100220,100250) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_non_loyalty,
       sum(case when a.bewart_det_id in (100210) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_aktion_non_loyalty,
       sum(case when a.bewart_det_id in (100220) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bby_non_loyalty,
       sum(case when a.bewart_det_id in (100250) then a.preis_abschrift_netto else 0 end) as wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty
from dbp_data.artbew_dat_ek_cp_sum a
join (select a.mandant_id,
             a.kjwo_ww,
             a.akt_kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3,4) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo <> $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo and
     a.wup_id = g.wup_id
JOIN dbp_data.wup e
  ON a.mandant_id = e.mandant_id AND
     a.wup_id = e.wup_id
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
      f.akt_kjwo_ww = $aw-1 and
      a.wup_bereinigt_fg = 0
group by 1,2,3,4,5
having (coalesce(wa_kalk_abschriften_sa,0) <> 0 or
        coalesce(wa_kalk_abschriften_sa_loyalty,0) <> 0)
);

create or replace volatile table _artbew1 as (
select a.mandant_id,
       f.kjwo_ww,
       a.art_id,
       g.art_id as mutter_art_id,
       g.muki,
       a.wup_id,
       a.gp_id,
       a.aktionsart_id_liste_txt,
       a.aktionsart_bez_liste_txt,
       a.aktion_typ_id_liste_txt,
       a.aktion_typ_bez_liste_txt,
       
       case when e.kreistyp_gruppe_id in ('N','W') then a.umsatz_netto else 0 end as umsatz_netto_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.menge else 0 end as absatz_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.ek_mep else 0 end as ek_mep_sa_west,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('N','W')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_west_wg30,
       case when e.kreistyp_gruppe_id in ('N','W') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_west,
       umsatz_netto_sa_west - ((ek_mep_sa_west + logkostenzuschlag_sa_west_wg30) - logkostenzuschlag_sa_west) as rohertrag_sa_west,
       rohertrag_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_west,
       rohertrag_sa_west-i.wa_kalk_abschriften_sa_west as wa_kalk_nach_pv_sa_west,
       wa_kalk_nach_pv_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_wa_kalk_nach_pv_sa_west,
       wa_kalk_abschriften_sa_west,
       
       case when e.kreistyp_gruppe_id in ('O','Q') then a.umsatz_netto else 0 end as umsatz_netto_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.menge else 0 end as absatz_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.ek_mep else 0 end as ek_mep_sa_ost,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('O','Q')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_ost_wg30,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_ost,
       umsatz_netto_sa_ost - ((ek_mep_sa_ost + logkostenzuschlag_sa_ost_wg30) - logkostenzuschlag_sa_ost) as rohertrag_sa_ost,
       rohertrag_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_ost,
       rohertrag_sa_ost-i.wa_kalk_abschriften_sa_ost as wa_kalk_nach_pv_sa_ost,
       wa_kalk_nach_pv_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_wa_kalk_nach_pv_sa_ost,
       wa_kalk_abschriften_sa_ost,
       
       case when e.kreistyp_gruppe_id in ('G','M') then a.umsatz_netto else 0 end as umsatz_netto_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.menge else 0 end as absatz_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.ek_mep else 0 end as ek_mep_sa_sued,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('G','M')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_sued_wg30,
       case when e.kreistyp_gruppe_id in ('G','M') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_sued,
       umsatz_netto_sa_sued - ((ek_mep_sa_sued + logkostenzuschlag_sa_sued_wg30) - logkostenzuschlag_sa_sued) as rohertrag_sa_sued,
       rohertrag_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_sued,
       rohertrag_sa_sued-i.wa_kalk_abschriften_sa_sued as wa_kalk_nach_pv_sa_sued,
       wa_kalk_nach_pv_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_wa_kalk_nach_pv_sa_sued,
       wa_kalk_abschriften_sa_sued,
       
       a.umsatz_netto as umsatz_netto_sa,
       a.menge as absatz_sa,
       a.ek_mep as ek_mep_sa,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_wg30,
       a.logkostenzuschlag as logkostenzuschlag_sa,
       umsatz_netto_sa - ((ek_mep_sa + logkostenzuschlag_sa_wg30) - logkostenzuschlag_sa) as rohertrag_sa,
       nullifzero(rohertrag_sa/nullifzero(umsatz_netto_sa))*100 as spanne_sa,
       coalesce(h.abschriftenbetrag_netto,0) as preisvorteil,
       rohertrag_sa-i.wa_kalk_abschriften_sa as wa_kalk_nach_pv_sa,
       wa_kalk_nach_pv_sa/nullifzero(umsatz_netto_sa)*100 as spanne_wa_kalk_nach_pv_sa,
       wa_kalk_abschriften_sa,

------------- sa_loyalty-------------

       a.umsatz_netto_sa_loyalty as umsatz_netto_sa_loyalty,
       a.menge_sa_loyalty as absatz_sa_loyalty,
       a.ek_mep_sa_loyalty as ek_mep_sa_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_loyalty 
         else 0
       end as logkostenzuschlag_sa_loyalty_wg30,
       a.logkostenzuschlag_sa_loyalty as logkostenzuschlag_sa_loyalty,
       umsatz_netto_sa_loyalty - ((ek_mep_sa_loyalty + logkostenzuschlag_sa_loyalty_wg30) - logkostenzuschlag_sa_loyalty) as rohertrag_sa_loyalty,
       rohertrag_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_sa_loyalty,
       rohertrag_sa_loyalty-i.wa_kalk_abschriften_sa_loyalty as wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_nach_pv_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_abschriften_sa_loyalty,
      
------------- sa_aktion_loyalty-------------

       a.umsatz_netto_sa_aktion_loyalty as umsatz_netto_sa_aktion_loyalty,
       a.menge_sa_aktion_loyalty as absatz_sa_aktion_loyalty,
       a.ek_mep_sa_aktion_loyalty as ek_mep_sa_aktion_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_loyalty 
         else 0
       end as logkostenzuschlag_sa_aktion_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_loyalty as logkostenzuschlag_sa_aktion_loyalty,
       umsatz_netto_sa_aktion_loyalty - ((ek_mep_sa_aktion_loyalty + logkostenzuschlag_sa_aktion_loyalty_wg30) - logkostenzuschlag_sa_aktion_loyalty) as rohertrag_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty-i.wa_kalk_abschriften_sa_aktion_loyalty as wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_nach_pv_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_abschriften_sa_aktion_loyalty,
       
------------- sa_bby_loyalty -------------

       a.umsatz_netto_sa_bby_loyalty as umsatz_netto_sa_bby_loyalty,
       a.menge_sa_bby_loyalty as absatz_sa_bby_loyalty,
       a.ek_mep_sa_bby_loyalty as ek_mep_sa_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_loyalty as logkostenzuschlag_sa_bby_loyalty,
       umsatz_netto_sa_bby_loyalty - ((ek_mep_sa_bby_loyalty + logkostenzuschlag_sa_bby_loyalty_wg30) - logkostenzuschlag_sa_bby_loyalty) as rohertrag_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty-i.wa_kalk_abschriften_sa_bby_loyalty as wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_nach_pv_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_abschriften_sa_bby_loyalty,
       
------------- sa_kdn_bby_loyalty -------------

       a.umsatz_netto_sa_kdn_bby_loyalty as umsatz_netto_sa_kdn_bby_loyalty,
       a.menge_sa_kdn_bby_loyalty as absatz_sa_kdn_bby_loyalty,
       a.ek_mep_sa_kdn_bby_loyalty as ek_mep_sa_kdn_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdn_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdn_bby_loyalty as logkostenzuschlag_sa_kdn_bby_loyalty,
       umsatz_netto_sa_kdn_bby_loyalty - ((ek_mep_sa_kdn_bby_loyalty + logkostenzuschlag_sa_kdn_bby_loyalty_wg30) - logkostenzuschlag_sa_kdn_bby_loyalty) as rohertrag_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty-i.wa_kalk_abschriften_sa_kdn_bby_loyalty as wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_nach_pv_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_abschriften_sa_kdn_bby_loyalty,
       
------------- sa_kdp_bby_loyalty -------------

       a.umsatz_netto_sa_kdp_bby_loyalty as umsatz_netto_sa_kdp_bby_loyalty,
       a.menge_sa_kdp_bby_loyalty as absatz_sa_kdp_bby_loyalty,
       a.ek_mep_sa_kdp_bby_loyalty as ek_mep_sa_kdp_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdp_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdp_bby_loyalty as logkostenzuschlag_sa_kdp_bby_loyalty,
       umsatz_netto_sa_kdp_bby_loyalty - ((ek_mep_sa_kdp_bby_loyalty + logkostenzuschlag_sa_kdp_bby_loyalty_wg30) - logkostenzuschlag_sa_kdp_bby_loyalty) as rohertrag_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty-i.wa_kalk_abschriften_sa_kdp_bby_loyalty as wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_nach_pv_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_abschriften_sa_kdp_bby_loyalty,

------------- sa_non_loyalty -------------

       a.umsatz_netto_sa_non_loyalty as umsatz_netto_sa_non_loyalty,
       a.menge_sa_non_loyalty as absatz_sa_non_loyalty,
       a.ek_mep_sa_non_loyalty as ek_mep_sa_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_non_loyalty
         else 0
       end as logkostenzuschlag_sa_non_loyalty_wg30,
       a.logkostenzuschlag_sa_non_loyalty as logkostenzuschlag_sa_non_loyalty,
       umsatz_netto_sa_non_loyalty - ((ek_mep_sa_non_loyalty + logkostenzuschlag_sa_non_loyalty_wg30) - logkostenzuschlag_sa_non_loyalty) as rohertrag_sa_non_loyalty,
       rohertrag_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_sa_non_loyalty,
       rohertrag_sa_non_loyalty-i.wa_kalk_abschriften_sa_non_loyalty as wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_nach_pv_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_abschriften_sa_non_loyalty,

------------- sa_aktion_non_loyalty -------------

       a.umsatz_netto_sa_aktion_non_loyalty as umsatz_netto_sa_aktion_non_loyalty,
       a.menge_sa_aktion_non_loyalty as absatz_sa_aktion_non_loyalty,
       a.ek_mep_sa_aktion_non_loyalty as ek_mep_sa_aktion_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_non_loyalty
         else 0
       end as logkostenzuschlag_sa_aktion_non_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_non_loyalty as logkostenzuschlag_sa_aktion_non_loyalty,
       umsatz_netto_sa_aktion_non_loyalty - ((ek_mep_sa_aktion_non_loyalty + logkostenzuschlag_sa_aktion_non_loyalty_wg30) - logkostenzuschlag_sa_aktion_non_loyalty) as rohertrag_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty-i.wa_kalk_abschriften_sa_aktion_non_loyalty as wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_nach_pv_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_abschriften_sa_aktion_non_loyalty,

------------- sa_bby_non_loyalty -------------

       a.umsatz_netto_sa_bby_non_loyalty as umsatz_netto_sa_bby_non_loyalty,
       a.menge_sa_bby_non_loyalty as absatz_sa_bby_non_loyalty,
       a.ek_mep_sa_bby_non_loyalty as ek_mep_sa_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bby_non_loyalty,
       umsatz_netto_sa_bby_non_loyalty - ((ek_mep_sa_bby_non_loyalty + logkostenzuschlag_sa_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bby_non_loyalty) as rohertrag_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty-i.wa_kalk_abschriften_sa_bby_non_loyalty as wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_abschriften_sa_bby_non_loyalty,

------------- sa_bonrabatt_bby_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_loyalty as umsatz_netto_sa_bonrabatt_bby_loyalty,
       a.menge_sa_bonrabatt_bby_loyalty as absatz_sa_bonrabatt_bby_loyalty,
       a.ek_mep_sa_bonrabatt_bby_loyalty as ek_mep_sa_bonrabatt_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bonrabatt_bby_loyalty as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       umsatz_netto_sa_bonrabatt_bby_loyalty - ((ek_mep_sa_bonrabatt_bby_loyalty + logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_loyalty) as rohertrag_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,

------------- sa_bonrabatt_bby_non_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_non_loyalty as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       a.menge_sa_bonrabatt_bby_non_loyalty as absatz_sa_bonrabatt_bby_non_loyalty,
       a.ek_mep_sa_bonrabatt_bby_non_loyalty as ek_mep_sa_bonrabatt_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
       umsatz_netto_sa_bonrabatt_bby_non_loyalty - ((ek_mep_sa_bonrabatt_bby_non_loyalty + logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) as rohertrag_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
      
       j.pv_aktion_loy,
       j.pv_aktion_non_loy,
       j.pv_bby_loy,
       j.pv_bby_non_loy,
       j.pv_kdn_bby,
       j.pv_kdp_bby,
       j.pv_bonrabatt_bby_loy,
       j.pv_bonrabatt_bby_non_loy,
  
       b.wg_id,
       c.owg_id,
       d.hwg_id,
       c.abt_id
from _hilfe1 a
join dbp_data.art_wg_zu_per b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     b.dat_bis = '9999-12-31' and
     b.arthiertyp_id = 2
join dbp_data.wg_per c
  on a.mandant_id = c.mandant_id and
     b.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     c.arthiertyp_id = 2
join dbp_data.owg_per d
  on a.mandant_id = d.mandant_id and
     c.owg_id = d.owg_id and
     d.dat_bis = '9999-12-31' and
     d.arthiertyp_id = 2
join dbp_data.wup e
  on a.mandant_id = e.mandant_id and
     a.wup_id = e.wup_id
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo = $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo and
     a.wup_id = g.wup_id
left join (select mandant_id,
                  wup_id,
                  art_id,
                  dat,
                  sum(abschriftenbetrag_netto) as abschriftenbetrag_netto
           from dbp_msi_view2.mv_marktabschriften
           where abschriftenart_id = -1
           group by 1,2,3,4) h
  on a.art_id = h.art_id and
     a.mandant_id = h.mandant_id and
     a.wup_id = h.wup_id and
     a.dat = h.dat
left join _hilfe11 i
  on a.art_id = i.art_id and
     a.mandant_id = i.mandant_id and
     a.wup_id = i.wup_id and
     a.dat = i.dat
left join (select v01.mandant_id,
                  v01.wup_id,
                  v01.art_id,
                  v01.dat,
                  sum(case when v01.wv_grund_id = 2 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_loy,
                  sum(case when v01.wv_grund_id = 0 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (52,53,54) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (52,54,54,55) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (56,57,58) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (56,57,58,59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (60,61,62) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (60,61,62,63) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdn_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (64,65,66,73,74,75) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (64,65,66,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdp_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (55,63,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_loy
           from dbp_data.marktabschriften v01
           left join (select art_id
                            ,gp_id
                            ,wup_id
                            ,dat_von
                            ,dat_bis
                      from dbp_data.art_gp_nm_zu_per
                      where mandant_id = 1) v02	
             on v01.art_id = v02.art_id	and 
                v01.wup_id = v02.wup_id	and 
                v01.dat between v02.dat_von and v02.dat_bis	
           join (select art_id
                       ,gewart_id
                 from dbp_data.art
                 where mandant_id = 1) v03	
             on v01.art_id = v03.art_id	
           where v01.mandant_id = 1
           group by 1,2,3,4) j
  on a.art_id = j.art_id and
     a.mandant_id = j.mandant_id and
     a.wup_id = j.wup_id and
     a.dat = j.dat
where a.mandant_id = 1 and
      a.bewart_id = 1002
);

insert into _artbew1
select a.mandant_id,
       f.kjwo_ww,
       a.art_id,
       g.art_id as mutter_art_id,
       g.muki,
       a.wup_id,
       a.gp_id,
       a.aktionsart_id_liste_txt,
       a.aktionsart_bez_liste_txt,
       a.aktion_typ_id_liste_txt,
       a.aktion_typ_bez_liste_txt,
       
       case when e.kreistyp_gruppe_id in ('N','W') then a.umsatz_netto else 0 end as umsatz_netto_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.menge else 0 end as absatz_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.ek_mep else 0 end as ek_mep_sa_west,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('N','W')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_west_wg30,
       case when e.kreistyp_gruppe_id in ('N','W') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_west,
       umsatz_netto_sa_west - ((ek_mep_sa_west + logkostenzuschlag_sa_west_wg30) - logkostenzuschlag_sa_west) as rohertrag_sa_west,
       rohertrag_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_west,
       rohertrag_sa_west-i.wa_kalk_abschriften_sa_west as wa_kalk_nach_pv_sa_west,
       wa_kalk_nach_pv_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_wa_kalk_nach_pv_sa_west,
       wa_kalk_abschriften_sa_west,
       
       case when e.kreistyp_gruppe_id in ('O','Q') then a.umsatz_netto else 0 end as umsatz_netto_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.menge else 0 end as absatz_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.ek_mep else 0 end as ek_mep_sa_ost,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('O','Q')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_ost_wg30,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_ost,
       umsatz_netto_sa_ost - ((ek_mep_sa_ost + logkostenzuschlag_sa_ost_wg30) - logkostenzuschlag_sa_ost) as rohertrag_sa_ost,
       rohertrag_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_ost,
       rohertrag_sa_ost-i.wa_kalk_abschriften_sa_ost as wa_kalk_nach_pv_sa_ost,
       wa_kalk_nach_pv_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_wa_kalk_nach_pv_sa_ost,
       wa_kalk_abschriften_sa_ost,
       
       case when e.kreistyp_gruppe_id in ('G','M') then a.umsatz_netto else 0 end as umsatz_netto_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.menge else 0 end as absatz_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.ek_mep else 0 end as ek_mep_sa_sued,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('G','M')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_sued_wg30,
       case when e.kreistyp_gruppe_id in ('G','M') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_sued,
       umsatz_netto_sa_sued - ((ek_mep_sa_sued + logkostenzuschlag_sa_sued_wg30) - logkostenzuschlag_sa_sued) as rohertrag_sa_sued,
       rohertrag_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_sued,
       rohertrag_sa_sued-i.wa_kalk_abschriften_sa_sued as wa_kalk_nach_pv_sa_sued,
       wa_kalk_nach_pv_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_wa_kalk_nach_pv_sa_sued,
       wa_kalk_abschriften_sa_sued,
       
       a.umsatz_netto as umsatz_netto_sa,
       a.menge as absatz_sa,
       a.ek_mep as ek_mep_sa,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_wg30,
       a.logkostenzuschlag as logkostenzuschlag_sa,
       umsatz_netto_sa - ((ek_mep_sa + logkostenzuschlag_sa_wg30) - logkostenzuschlag_sa) as rohertrag_sa,
       nullifzero(rohertrag_sa/nullifzero(umsatz_netto_sa))*100 as spanne_sa,
       coalesce(h.abschriftenbetrag_netto,0) as preisvorteil,
       rohertrag_sa-i.wa_kalk_abschriften_sa as wa_kalk_nach_pv_sa,
       wa_kalk_nach_pv_sa/nullifzero(umsatz_netto_sa)*100 as spanne_wa_kalk_nach_pv_sa,
       wa_kalk_abschriften_sa,

------------- sa_loyalty-------------

       a.umsatz_netto_sa_loyalty as umsatz_netto_sa_loyalty,
       a.menge_sa_loyalty as absatz_sa_loyalty,
       a.ek_mep_sa_loyalty as ek_mep_sa_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_loyalty 
         else 0
       end as logkostenzuschlag_sa_loyalty_wg30,
       a.logkostenzuschlag_sa_loyalty as logkostenzuschlag_sa_loyalty,
       umsatz_netto_sa_loyalty - ((ek_mep_sa_loyalty + logkostenzuschlag_sa_loyalty_wg30) - logkostenzuschlag_sa_loyalty) as rohertrag_sa_loyalty,
       rohertrag_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_sa_loyalty,
       rohertrag_sa_loyalty-i.wa_kalk_abschriften_sa_loyalty as wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_nach_pv_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_abschriften_sa_loyalty,
      
------------- sa_aktion_loyalty-------------

       a.umsatz_netto_sa_aktion_loyalty as umsatz_netto_sa_aktion_loyalty,
       a.menge_sa_aktion_loyalty as absatz_sa_aktion_loyalty,
       a.ek_mep_sa_aktion_loyalty as ek_mep_sa_aktion_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_loyalty 
         else 0
       end as logkostenzuschlag_sa_aktion_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_loyalty as logkostenzuschlag_sa_aktion_loyalty,
       umsatz_netto_sa_aktion_loyalty - ((ek_mep_sa_aktion_loyalty + logkostenzuschlag_sa_aktion_loyalty_wg30) - logkostenzuschlag_sa_aktion_loyalty) as rohertrag_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty-i.wa_kalk_abschriften_sa_aktion_loyalty as wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_nach_pv_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_abschriften_sa_aktion_loyalty,
       
------------- sa_bby_loyalty -------------

       a.umsatz_netto_sa_bby_loyalty as umsatz_netto_sa_bby_loyalty,
       a.menge_sa_bby_loyalty as absatz_sa_bby_loyalty,
       a.ek_mep_sa_bby_loyalty as ek_mep_sa_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_loyalty as logkostenzuschlag_sa_bby_loyalty,
       umsatz_netto_sa_bby_loyalty - ((ek_mep_sa_bby_loyalty + logkostenzuschlag_sa_bby_loyalty_wg30) - logkostenzuschlag_sa_bby_loyalty) as rohertrag_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty-i.wa_kalk_abschriften_sa_bby_loyalty as wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_nach_pv_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_abschriften_sa_bby_loyalty,
       
------------- sa_kdn_bby_loyalty -------------

       a.umsatz_netto_sa_kdn_bby_loyalty as umsatz_netto_sa_kdn_bby_loyalty,
       a.menge_sa_kdn_bby_loyalty as absatz_sa_kdn_bby_loyalty,
       a.ek_mep_sa_kdn_bby_loyalty as ek_mep_sa_kdn_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdn_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdn_bby_loyalty as logkostenzuschlag_sa_kdn_bby_loyalty,
       umsatz_netto_sa_kdn_bby_loyalty - ((ek_mep_sa_kdn_bby_loyalty + logkostenzuschlag_sa_kdn_bby_loyalty_wg30) - logkostenzuschlag_sa_kdn_bby_loyalty) as rohertrag_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty-i.wa_kalk_abschriften_sa_kdn_bby_loyalty as wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_nach_pv_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_abschriften_sa_kdn_bby_loyalty,
       
------------- sa_kdp_bby_loyalty -------------

       a.umsatz_netto_sa_kdp_bby_loyalty as umsatz_netto_sa_kdp_bby_loyalty,
       a.menge_sa_kdp_bby_loyalty as absatz_sa_kdp_bby_loyalty,
       a.ek_mep_sa_kdp_bby_loyalty as ek_mep_sa_kdp_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdp_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdp_bby_loyalty as logkostenzuschlag_sa_kdp_bby_loyalty,
       umsatz_netto_sa_kdp_bby_loyalty - ((ek_mep_sa_kdp_bby_loyalty + logkostenzuschlag_sa_kdp_bby_loyalty_wg30) - logkostenzuschlag_sa_kdp_bby_loyalty) as rohertrag_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty-i.wa_kalk_abschriften_sa_kdp_bby_loyalty as wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_nach_pv_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_abschriften_sa_kdp_bby_loyalty,

------------- sa_non_loyalty -------------

       a.umsatz_netto_sa_non_loyalty as umsatz_netto_sa_non_loyalty,
       a.menge_sa_non_loyalty as absatz_sa_non_loyalty,
       a.ek_mep_sa_non_loyalty as ek_mep_sa_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_non_loyalty
         else 0
       end as logkostenzuschlag_sa_non_loyalty_wg30,
       a.logkostenzuschlag_sa_non_loyalty as logkostenzuschlag_sa_non_loyalty,
       umsatz_netto_sa_non_loyalty - ((ek_mep_sa_non_loyalty + logkostenzuschlag_sa_non_loyalty_wg30) - logkostenzuschlag_sa_non_loyalty) as rohertrag_sa_non_loyalty,
       rohertrag_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_sa_non_loyalty,
       rohertrag_sa_non_loyalty-i.wa_kalk_abschriften_sa_non_loyalty as wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_nach_pv_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_abschriften_sa_non_loyalty,

------------- sa_aktion_non_loyalty -------------

       a.umsatz_netto_sa_aktion_non_loyalty as umsatz_netto_sa_aktion_non_loyalty,
       a.menge_sa_aktion_non_loyalty as absatz_sa_aktion_non_loyalty,
       a.ek_mep_sa_aktion_non_loyalty as ek_mep_sa_aktion_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_non_loyalty
         else 0
       end as logkostenzuschlag_sa_aktion_non_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_non_loyalty as logkostenzuschlag_sa_aktion_non_loyalty,
       umsatz_netto_sa_aktion_non_loyalty - ((ek_mep_sa_aktion_non_loyalty + logkostenzuschlag_sa_aktion_non_loyalty_wg30) - logkostenzuschlag_sa_aktion_non_loyalty) as rohertrag_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty-i.wa_kalk_abschriften_sa_aktion_non_loyalty as wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_nach_pv_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_abschriften_sa_aktion_non_loyalty,

------------- sa_bby_non_loyalty -------------

       a.umsatz_netto_sa_bby_non_loyalty as umsatz_netto_sa_bby_non_loyalty,
       a.menge_sa_bby_non_loyalty as absatz_sa_bby_non_loyalty,
       a.ek_mep_sa_bby_non_loyalty as ek_mep_sa_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bby_non_loyalty,
       umsatz_netto_sa_bby_non_loyalty - ((ek_mep_sa_bby_non_loyalty + logkostenzuschlag_sa_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bby_non_loyalty) as rohertrag_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty-i.wa_kalk_abschriften_sa_bby_non_loyalty as wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_abschriften_sa_bby_non_loyalty,
      
------------- sa_bonrabatt_bby_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_loyalty as umsatz_netto_sa_bonrabatt_bby_loyalty,
       a.menge_sa_bonrabatt_bby_loyalty as absatz_sa_bonrabatt_bby_loyalty,
       a.ek_mep_sa_bonrabatt_bby_loyalty as ek_mep_sa_bonrabatt_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bonrabatt_bby_loyalty as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       umsatz_netto_sa_bonrabatt_bby_loyalty - ((ek_mep_sa_bonrabatt_bby_loyalty + logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_loyalty) as rohertrag_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,

------------- sa_bonrabatt_bby_non_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_non_loyalty as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       a.menge_sa_bonrabatt_bby_non_loyalty as absatz_sa_bonrabatt_bby_non_loyalty,
       a.ek_mep_sa_bonrabatt_bby_non_loyalty as ek_mep_sa_bonrabatt_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
       umsatz_netto_sa_bonrabatt_bby_non_loyalty - ((ek_mep_sa_bonrabatt_bby_non_loyalty + logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) as rohertrag_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
      
       j.pv_aktion_loy,
       j.pv_aktion_non_loy,
       j.pv_bby_loy,
       j.pv_bby_non_loy,
       j.pv_kdn_bby,
       j.pv_kdp_bby,
       j.pv_bonrabatt_bby_loy,
       j.pv_bonrabatt_bby_non_loy,
      
       b.wg_id,
       c.owg_id,
       d.hwg_id,
       c.abt_id
from _hilfe2 a
join dbp_data.art_wg_zu_per b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     b.dat_bis = '9999-12-31' and
     b.arthiertyp_id = 2
join dbp_data.wg_per c
  on a.mandant_id = c.mandant_id and
     b.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     c.arthiertyp_id = 2
join dbp_data.owg_per d
  on a.mandant_id = d.mandant_id and
     c.owg_id = d.owg_id and
     d.dat_bis = '9999-12-31' and
     d.arthiertyp_id = 2
join dbp_data.wup e
  on a.mandant_id = e.mandant_id and
     a.wup_id = e.wup_id
join (select a.mandant_id,
             a.kjwo_ww,
             a.akt_kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3,4) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             wup_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo <> $akt_woche
      group by 1,2,3,4,5,6) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     a.wup_id = g.wup_id
left join (select mandant_id,
                  wup_id,
                  art_id,
                  dat,
                  sum(abschriftenbetrag_netto) as abschriftenbetrag_netto
           from dbp_msi_view2.mv_marktabschriften
           where abschriftenart_id = -1
           group by 1,2,3,4) h
  on a.art_id = h.art_id and
     a.mandant_id = h.mandant_id and
     a.wup_id = h.wup_id and
     a.dat = h.dat
left join _hilfe22 i
  on a.art_id = i.art_id and
     a.mandant_id = i.mandant_id and
     a.wup_id = i.wup_id and
     a.dat = i.dat
left join (select v01.mandant_id,
                  v01.wup_id,
                  v01.art_id,
                  v01.dat,
                  sum(case when v01.wv_grund_id = 2 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_loy,
                  sum(case when v01.wv_grund_id = 0 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (52,53,54) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (52,54,54,55) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (56,57,58) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (56,57,58,59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (60,61,62) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (60,61,62,63) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdn_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (64,65,66,73,74,75) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (64,65,66,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdp_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (55,63,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_loy
           from dbp_data.marktabschriften v01	
           left join (select art_id
                            ,gp_id
                            ,wup_id
                            ,dat_von
                            ,dat_bis
                      from dbp_data.art_gp_nm_zu_per
                      where mandant_id = 1) v02	
             on v01.art_id = v02.art_id	and 
                v01.wup_id = v02.wup_id	and 
                v01.dat between v02.dat_von and v02.dat_bis	
           join (select art_id
                       ,gewart_id
                 from dbp_data.art
                 where mandant_id = 1) v03	
             on v01.art_id = v03.art_id	
           where v01.mandant_id = 1
           group by 1,2,3,4) j
  on a.art_id = j.art_id and
     a.mandant_id = j.mandant_id and
     a.wup_id = j.wup_id and
     a.dat = j.dat
where a.mandant_id = 1 and
      a.bewart_id = 1002 and
      f.akt_kjwo_ww = $aw-1
;

insert into _artbew1
select a.mandant_id,
       f.kjwo_ww,
       a.art_id,
       g.art_id as mutter_art_id,
       g.muki,
       a.wup_id,
       a.gp_id,
       a.aktionsart_id_liste_txt,
       a.aktionsart_bez_liste_txt,
       a.aktion_typ_id_liste_txt,
       a.aktion_typ_bez_liste_txt,
       
       case when e.kreistyp_gruppe_id in ('N','W') then a.umsatz_netto else 0 end as umsatz_netto_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.menge else 0 end as absatz_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.ek_mep else 0 end as ek_mep_sa_west,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('N','W')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_west_wg30,
       case when e.kreistyp_gruppe_id in ('N','W') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_west,
       umsatz_netto_sa_west - ((ek_mep_sa_west + logkostenzuschlag_sa_west_wg30) - logkostenzuschlag_sa_west) as rohertrag_sa_west,
       rohertrag_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_west,
       rohertrag_sa_west-i.wa_kalk_abschriften_sa_west as wa_kalk_nach_pv_sa_west,
       wa_kalk_nach_pv_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_wa_kalk_nach_pv_sa_west,
       wa_kalk_abschriften_sa_west,
       
       case when e.kreistyp_gruppe_id in ('O','Q') then a.umsatz_netto else 0 end as umsatz_netto_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.menge else 0 end as absatz_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.ek_mep else 0 end as ek_mep_sa_ost,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('O','Q')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_ost_wg30,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_ost,
       umsatz_netto_sa_ost - ((ek_mep_sa_ost + logkostenzuschlag_sa_ost_wg30) - logkostenzuschlag_sa_ost) as rohertrag_sa_ost,
       rohertrag_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_ost,
       rohertrag_sa_ost-i.wa_kalk_abschriften_sa_ost as wa_kalk_nach_pv_sa_ost,
       wa_kalk_nach_pv_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_wa_kalk_nach_pv_sa_ost,
       wa_kalk_abschriften_sa_ost,
       
       case when e.kreistyp_gruppe_id in ('G','M') then a.umsatz_netto else 0 end as umsatz_netto_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.menge else 0 end as absatz_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.ek_mep else 0 end as ek_mep_sa_sued,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('G','M')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_sued_wg30,
       case when e.kreistyp_gruppe_id in ('G','M') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_sued,
       umsatz_netto_sa_sued - ((ek_mep_sa_sued + logkostenzuschlag_sa_sued_wg30) - logkostenzuschlag_sa_sued) as rohertrag_sa_sued,
       rohertrag_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_sued,
       rohertrag_sa_sued-i.wa_kalk_abschriften_sa_sued as wa_kalk_nach_pv_sa_sued,
       wa_kalk_nach_pv_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_wa_kalk_nach_pv_sa_sued,
       wa_kalk_abschriften_sa_sued,
       
       a.umsatz_netto as umsatz_netto_sa,
       a.menge as absatz_sa,
       a.ek_mep as ek_mep_sa,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_wg30,
       a.logkostenzuschlag as logkostenzuschlag_sa,
       umsatz_netto_sa - ((ek_mep_sa + logkostenzuschlag_sa_wg30) - logkostenzuschlag_sa) as rohertrag_sa,
       nullifzero(rohertrag_sa/nullifzero(umsatz_netto_sa))*100 as spanne_sa,
       coalesce(h.abschriftenbetrag_netto,0) as preisvorteil,
       rohertrag_sa-i.wa_kalk_abschriften_sa as wa_kalk_nach_pv_sa,
       wa_kalk_nach_pv_sa/nullifzero(umsatz_netto_sa)*100 as spanne_wa_kalk_nach_pv_sa,
       wa_kalk_abschriften_sa,

------------- sa_loyalty-------------

       a.umsatz_netto_sa_loyalty as umsatz_netto_sa_loyalty,
       a.menge_sa_loyalty as absatz_sa_loyalty,
       a.ek_mep_sa_loyalty as ek_mep_sa_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_loyalty 
         else 0
       end as logkostenzuschlag_sa_loyalty_wg30,
       a.logkostenzuschlag_sa_loyalty as logkostenzuschlag_sa_loyalty,
       umsatz_netto_sa_loyalty - ((ek_mep_sa_loyalty + logkostenzuschlag_sa_loyalty_wg30) - logkostenzuschlag_sa_loyalty) as rohertrag_sa_loyalty,
       rohertrag_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_sa_loyalty,
       rohertrag_sa_loyalty-i.wa_kalk_abschriften_sa_loyalty as wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_nach_pv_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_abschriften_sa_loyalty,
      
------------- sa_aktion_loyalty-------------

       a.umsatz_netto_sa_aktion_loyalty as umsatz_netto_sa_aktion_loyalty,
       a.menge_sa_aktion_loyalty as absatz_sa_aktion_loyalty,
       a.ek_mep_sa_aktion_loyalty as ek_mep_sa_aktion_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_loyalty 
         else 0
       end as logkostenzuschlag_sa_aktion_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_loyalty as logkostenzuschlag_sa_aktion_loyalty,
       umsatz_netto_sa_aktion_loyalty - ((ek_mep_sa_aktion_loyalty + logkostenzuschlag_sa_aktion_loyalty_wg30) - logkostenzuschlag_sa_aktion_loyalty) as rohertrag_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty-i.wa_kalk_abschriften_sa_aktion_loyalty as wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_nach_pv_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_abschriften_sa_aktion_loyalty,
       
------------- sa_bby_loyalty -------------

       a.umsatz_netto_sa_bby_loyalty as umsatz_netto_sa_bby_loyalty,
       a.menge_sa_bby_loyalty as absatz_sa_bby_loyalty,
       a.ek_mep_sa_bby_loyalty as ek_mep_sa_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_loyalty as logkostenzuschlag_sa_bby_loyalty,
       umsatz_netto_sa_bby_loyalty - ((ek_mep_sa_bby_loyalty + logkostenzuschlag_sa_bby_loyalty_wg30) - logkostenzuschlag_sa_bby_loyalty) as rohertrag_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty-i.wa_kalk_abschriften_sa_bby_loyalty as wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_nach_pv_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_abschriften_sa_bby_loyalty,
       
------------- sa_kdn_bby_loyalty -------------

       a.umsatz_netto_sa_kdn_bby_loyalty as umsatz_netto_sa_kdn_bby_loyalty,
       a.menge_sa_kdn_bby_loyalty as absatz_sa_kdn_bby_loyalty,
       a.ek_mep_sa_kdn_bby_loyalty as ek_mep_sa_kdn_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdn_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdn_bby_loyalty as logkostenzuschlag_sa_kdn_bby_loyalty,
       umsatz_netto_sa_kdn_bby_loyalty - ((ek_mep_sa_kdn_bby_loyalty + logkostenzuschlag_sa_kdn_bby_loyalty_wg30) - logkostenzuschlag_sa_kdn_bby_loyalty) as rohertrag_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty-i.wa_kalk_abschriften_sa_kdn_bby_loyalty as wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_nach_pv_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_abschriften_sa_kdn_bby_loyalty,
       
------------- sa_kdp_bby_loyalty -------------

       a.umsatz_netto_sa_kdp_bby_loyalty as umsatz_netto_sa_kdp_bby_loyalty,
       a.menge_sa_kdp_bby_loyalty as absatz_sa_kdp_bby_loyalty,
       a.ek_mep_sa_kdp_bby_loyalty as ek_mep_sa_kdp_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdp_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdp_bby_loyalty as logkostenzuschlag_sa_kdp_bby_loyalty,
       umsatz_netto_sa_kdp_bby_loyalty - ((ek_mep_sa_kdp_bby_loyalty + logkostenzuschlag_sa_kdp_bby_loyalty_wg30) - logkostenzuschlag_sa_kdp_bby_loyalty) as rohertrag_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty-i.wa_kalk_abschriften_sa_kdp_bby_loyalty as wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_nach_pv_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_abschriften_sa_kdp_bby_loyalty,

------------- sa_non_loyalty -------------

       a.umsatz_netto_sa_non_loyalty as umsatz_netto_sa_non_loyalty,
       a.menge_sa_non_loyalty as absatz_sa_non_loyalty,
       a.ek_mep_sa_non_loyalty as ek_mep_sa_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_non_loyalty
         else 0
       end as logkostenzuschlag_sa_non_loyalty_wg30,
       a.logkostenzuschlag_sa_non_loyalty as logkostenzuschlag_sa_non_loyalty,
       umsatz_netto_sa_non_loyalty - ((ek_mep_sa_non_loyalty + logkostenzuschlag_sa_non_loyalty_wg30) - logkostenzuschlag_sa_non_loyalty) as rohertrag_sa_non_loyalty,
       rohertrag_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_sa_non_loyalty,
       rohertrag_sa_non_loyalty-i.wa_kalk_abschriften_sa_non_loyalty as wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_nach_pv_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_abschriften_sa_non_loyalty,

------------- sa_aktion_non_loyalty -------------

       a.umsatz_netto_sa_aktion_non_loyalty as umsatz_netto_sa_aktion_non_loyalty,
       a.menge_sa_aktion_non_loyalty as absatz_sa_aktion_non_loyalty,
       a.ek_mep_sa_aktion_non_loyalty as ek_mep_sa_aktion_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_non_loyalty
         else 0
       end as logkostenzuschlag_sa_aktion_non_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_non_loyalty as logkostenzuschlag_sa_aktion_non_loyalty,
       umsatz_netto_sa_aktion_non_loyalty - ((ek_mep_sa_aktion_non_loyalty + logkostenzuschlag_sa_aktion_non_loyalty_wg30) - logkostenzuschlag_sa_aktion_non_loyalty) as rohertrag_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty-i.wa_kalk_abschriften_sa_aktion_non_loyalty as wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_nach_pv_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_abschriften_sa_aktion_non_loyalty,

------------- sa_bby_non_loyalty -------------

       a.umsatz_netto_sa_bby_non_loyalty as umsatz_netto_sa_bby_non_loyalty,
       a.menge_sa_bby_non_loyalty as absatz_sa_bby_non_loyalty,
       a.ek_mep_sa_bby_non_loyalty as ek_mep_sa_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bby_non_loyalty,
       umsatz_netto_sa_bby_non_loyalty - ((ek_mep_sa_bby_non_loyalty + logkostenzuschlag_sa_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bby_non_loyalty) as rohertrag_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty-i.wa_kalk_abschriften_sa_bby_non_loyalty as wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_abschriften_sa_bby_non_loyalty,

------------- sa_bonrabatt_bby_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_loyalty as umsatz_netto_sa_bonrabatt_bby_loyalty,
       a.menge_sa_bonrabatt_bby_loyalty as absatz_sa_bonrabatt_bby_loyalty,
       a.ek_mep_sa_bonrabatt_bby_loyalty as ek_mep_sa_bonrabatt_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bonrabatt_bby_loyalty as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       umsatz_netto_sa_bonrabatt_bby_loyalty - ((ek_mep_sa_bonrabatt_bby_loyalty + logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_loyalty) as rohertrag_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,

------------- sa_bonrabatt_bby_non_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_non_loyalty as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       a.menge_sa_bonrabatt_bby_non_loyalty as absatz_sa_bonrabatt_bby_non_loyalty,
       a.ek_mep_sa_bonrabatt_bby_non_loyalty as ek_mep_sa_bonrabatt_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
       umsatz_netto_sa_bonrabatt_bby_non_loyalty - ((ek_mep_sa_bonrabatt_bby_non_loyalty + logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) as rohertrag_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
      
       j.pv_aktion_loy,
       j.pv_aktion_non_loy,
       j.pv_bby_loy,
       j.pv_bby_non_loy,
       j.pv_kdn_bby,
       j.pv_kdp_bby,
       j.pv_bonrabatt_bby_loy,
       j.pv_bonrabatt_bby_non_loy,

       b.wg_id,
       c.owg_id,
       d.hwg_id,
       c.abt_id
from _hilfe3 a
join dbp_data.art_wg_zu_per b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     b.dat_bis = '9999-12-31' and
     b.arthiertyp_id = 2
join dbp_data.wg_per c
  on a.mandant_id = c.mandant_id and
     b.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     c.arthiertyp_id = 2
join dbp_data.owg_per d
  on a.mandant_id = d.mandant_id and
     c.owg_id = d.owg_id and
     d.dat_bis = '9999-12-31' and
     d.arthiertyp_id = 2
join dbp_data.wup e
  on a.mandant_id = e.mandant_id and
     a.wup_id = e.wup_id
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo = $akt_woche
      group by 1,2,3,4,5) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id and
     f.kjwo_ww = g.kjwo
left join (select mandant_id,
                  wup_id,
                  art_id,
                  dat,
                  sum(abschriftenbetrag_netto) as abschriftenbetrag_netto
           from dbp_msi_view2.mv_marktabschriften
           where abschriftenart_id = -1
           group by 1,2,3,4) h
  on a.art_id = h.art_id and
     a.mandant_id = h.mandant_id and
     a.wup_id = h.wup_id and
     a.dat = h.dat
     
left join _hilfe11 i
  on a.art_id = i.art_id and
     a.mandant_id = i.mandant_id and
     a.wup_id = i.wup_id and
     a.dat = i.dat
     
left join (select v01.mandant_id,
                  v01.wup_id,
                  v01.art_id,
                  v01.dat,
                  sum(case when v01.wv_grund_id = 2 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_loy,
                  sum(case when v01.wv_grund_id = 0 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (52,53,54) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (52,54,54,55) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (56,57,58) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (56,57,58,59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (60,61,62) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (60,61,62,63) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdn_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (64,65,66,73,74,75) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (64,65,66,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdp_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (55,63,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_loy
           from dbp_data.marktabschriften v01	
           left join (select art_id
                            ,gp_id
                            ,wup_id
                            ,dat_von
                            ,dat_bis
                      from dbp_data.art_gp_nm_zu_per
                      where mandant_id = 1) v02	
             on v01.art_id = v02.art_id	and 
                v01.wup_id = v02.wup_id	and 
                v01.dat between v02.dat_von	and v02.dat_bis	
           join (select art_id
                       ,gewart_id
                 from dbp_data.art
                 where mandant_id = 1) v03	
             on v01.art_id = v03.art_id	
           where v01.mandant_id = 1
           group by 1,2,3,4) j
  on a.art_id = j.art_id and
     a.mandant_id = j.mandant_id and
     a.wup_id = j.wup_id and
     a.dat = j.dat
     
where a.mandant_id = 1 and
      a.bewart_id = 1002
;

insert into _artbew1
select a.mandant_id,
       f.kjwo_ww,
       a.art_id,
       g.art_id as mutter_art_id,
       g.muki,
       a.wup_id,
       a.gp_id,
       a.aktionsart_id_liste_txt,
       a.aktionsart_bez_liste_txt,
       a.aktion_typ_id_liste_txt,
       a.aktion_typ_bez_liste_txt,
       
       case when e.kreistyp_gruppe_id in ('N','W') then a.umsatz_netto else 0 end as umsatz_netto_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.menge else 0 end as absatz_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then a.ek_mep else 0 end as ek_mep_sa_west,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('N','W')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_west_wg30,
       case when e.kreistyp_gruppe_id in ('N','W') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_west,
       umsatz_netto_sa_west - ((ek_mep_sa_west + logkostenzuschlag_sa_west_wg30) - logkostenzuschlag_sa_west) as rohertrag_sa_west,
       rohertrag_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_sa_west,
       case when e.kreistyp_gruppe_id in ('N','W') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_west,
       rohertrag_sa_west-i.wa_kalk_abschriften_sa_west as wa_kalk_nach_pv_sa_west,
       wa_kalk_nach_pv_sa_west/nullifzero(umsatz_netto_sa_west)*100 as spanne_wa_kalk_nach_pv_sa_west,
       wa_kalk_abschriften_sa_west,
       
       case when e.kreistyp_gruppe_id in ('O','Q') then a.umsatz_netto else 0 end as umsatz_netto_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.menge else 0 end as absatz_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.ek_mep else 0 end as ek_mep_sa_ost,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('O','Q')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_ost_wg30,
       case when e.kreistyp_gruppe_id in ('O','Q') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_ost,
       umsatz_netto_sa_ost - ((ek_mep_sa_ost + logkostenzuschlag_sa_ost_wg30) - logkostenzuschlag_sa_ost) as rohertrag_sa_ost,
       rohertrag_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_sa_ost,
       case when e.kreistyp_gruppe_id in ('O','Q') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_ost,
       rohertrag_sa_ost-i.wa_kalk_abschriften_sa_ost as wa_kalk_nach_pv_sa_ost,
       wa_kalk_nach_pv_sa_ost/nullifzero(umsatz_netto_sa_ost)*100 as spanne_wa_kalk_nach_pv_sa_ost,
       wa_kalk_abschriften_sa_ost,
       
       case when e.kreistyp_gruppe_id in ('G','M') then a.umsatz_netto else 0 end as umsatz_netto_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.menge else 0 end as absatz_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then a.ek_mep else 0 end as ek_mep_sa_sued,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) and
              e.kreistyp_gruppe_id in ('G','M')
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_sued_wg30,
       case when e.kreistyp_gruppe_id in ('G','M') then a.logkostenzuschlag else 0 end as logkostenzuschlag_sa_sued,
       umsatz_netto_sa_sued - ((ek_mep_sa_sued + logkostenzuschlag_sa_sued_wg30) - logkostenzuschlag_sa_sued) as rohertrag_sa_sued,
       rohertrag_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_sa_sued,
       case when e.kreistyp_gruppe_id in ('G','M') then coalesce(h.abschriftenbetrag_netto,0) else 0 end as preisvorteil_sued,
       rohertrag_sa_sued-i.wa_kalk_abschriften_sa_sued as wa_kalk_nach_pv_sa_sued,
       wa_kalk_nach_pv_sa_sued/nullifzero(umsatz_netto_sa_sued)*100 as spanne_wa_kalk_nach_pv_sa_sued,
       wa_kalk_abschriften_sa_sued,
       
       a.umsatz_netto as umsatz_netto_sa,
       a.menge as absatz_sa,
       a.ek_mep as ek_mep_sa,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag 
         else 0
       end as logkostenzuschlag_sa_wg30,
       a.logkostenzuschlag as logkostenzuschlag_sa,
       umsatz_netto_sa - ((ek_mep_sa + logkostenzuschlag_sa_wg30) - logkostenzuschlag_sa) as rohertrag_sa,
       nullifzero(rohertrag_sa/nullifzero(umsatz_netto_sa))*100 as spanne_sa,
       coalesce(h.abschriftenbetrag_netto,0) as preisvorteil,
       rohertrag_sa-i.wa_kalk_abschriften_sa as wa_kalk_nach_pv_sa,
       wa_kalk_nach_pv_sa/nullifzero(umsatz_netto_sa)*100 as spanne_wa_kalk_nach_pv_sa,
       wa_kalk_abschriften_sa,

------------- sa_loyalty-------------

       a.umsatz_netto_sa_loyalty as umsatz_netto_sa_loyalty,
       a.menge_sa_loyalty as absatz_sa_loyalty,
       a.ek_mep_sa_loyalty as ek_mep_sa_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_loyalty 
         else 0
       end as logkostenzuschlag_sa_loyalty_wg30,
       a.logkostenzuschlag_sa_loyalty as logkostenzuschlag_sa_loyalty,
       umsatz_netto_sa_loyalty - ((ek_mep_sa_loyalty + logkostenzuschlag_sa_loyalty_wg30) - logkostenzuschlag_sa_loyalty) as rohertrag_sa_loyalty,
       rohertrag_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_sa_loyalty,
       rohertrag_sa_loyalty-i.wa_kalk_abschriften_sa_loyalty as wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_nach_pv_sa_loyalty/nullifzero(umsatz_netto_sa_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_loyalty,
       wa_kalk_abschriften_sa_loyalty,
      
------------- sa_aktion_loyalty-------------

       a.umsatz_netto_sa_aktion_loyalty as umsatz_netto_sa_aktion_loyalty,
       a.menge_sa_aktion_loyalty as absatz_sa_aktion_loyalty,
       a.ek_mep_sa_aktion_loyalty as ek_mep_sa_aktion_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_loyalty 
         else 0
       end as logkostenzuschlag_sa_aktion_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_loyalty as logkostenzuschlag_sa_aktion_loyalty,
       umsatz_netto_sa_aktion_loyalty - ((ek_mep_sa_aktion_loyalty + logkostenzuschlag_sa_aktion_loyalty_wg30) - logkostenzuschlag_sa_aktion_loyalty) as rohertrag_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_sa_aktion_loyalty,
       rohertrag_sa_aktion_loyalty-i.wa_kalk_abschriften_sa_aktion_loyalty as wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_nach_pv_sa_aktion_loyalty/nullifzero(umsatz_netto_sa_aktion_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
       wa_kalk_abschriften_sa_aktion_loyalty,
       
------------- sa_bby_loyalty -------------

       a.umsatz_netto_sa_bby_loyalty as umsatz_netto_sa_bby_loyalty,
       a.menge_sa_bby_loyalty as absatz_sa_bby_loyalty,
       a.ek_mep_sa_bby_loyalty as ek_mep_sa_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_loyalty as logkostenzuschlag_sa_bby_loyalty,
       umsatz_netto_sa_bby_loyalty - ((ek_mep_sa_bby_loyalty + logkostenzuschlag_sa_bby_loyalty_wg30) - logkostenzuschlag_sa_bby_loyalty) as rohertrag_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_sa_bby_loyalty,
       rohertrag_sa_bby_loyalty-i.wa_kalk_abschriften_sa_bby_loyalty as wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_nach_pv_sa_bby_loyalty/nullifzero(umsatz_netto_sa_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_loyalty,
       wa_kalk_abschriften_sa_bby_loyalty,
       
------------- sa_kdn_bby_loyalty -------------

       a.umsatz_netto_sa_kdn_bby_loyalty as umsatz_netto_sa_kdn_bby_loyalty,
       a.menge_sa_kdn_bby_loyalty as absatz_sa_kdn_bby_loyalty,
       a.ek_mep_sa_kdn_bby_loyalty as ek_mep_sa_kdn_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdn_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdn_bby_loyalty as logkostenzuschlag_sa_kdn_bby_loyalty,
       umsatz_netto_sa_kdn_bby_loyalty - ((ek_mep_sa_kdn_bby_loyalty + logkostenzuschlag_sa_kdn_bby_loyalty_wg30) - logkostenzuschlag_sa_kdn_bby_loyalty) as rohertrag_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_sa_kdn_bby_loyalty,
       rohertrag_sa_kdn_bby_loyalty-i.wa_kalk_abschriften_sa_kdn_bby_loyalty as wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_nach_pv_sa_kdn_bby_loyalty/nullifzero(umsatz_netto_sa_kdn_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
       wa_kalk_abschriften_sa_kdn_bby_loyalty,
       
------------- sa_kdp_bby_loyalty -------------

       a.umsatz_netto_sa_kdp_bby_loyalty as umsatz_netto_sa_kdp_bby_loyalty,
       a.menge_sa_kdp_bby_loyalty as absatz_sa_kdp_bby_loyalty,
       a.ek_mep_sa_kdp_bby_loyalty as ek_mep_sa_kdp_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_kdp_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_kdp_bby_loyalty as logkostenzuschlag_sa_kdp_bby_loyalty,
       umsatz_netto_sa_kdp_bby_loyalty - ((ek_mep_sa_kdp_bby_loyalty + logkostenzuschlag_sa_kdp_bby_loyalty_wg30) - logkostenzuschlag_sa_kdp_bby_loyalty) as rohertrag_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_sa_kdp_bby_loyalty,
       rohertrag_sa_kdp_bby_loyalty-i.wa_kalk_abschriften_sa_kdp_bby_loyalty as wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_nach_pv_sa_kdp_bby_loyalty/nullifzero(umsatz_netto_sa_kdp_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
       wa_kalk_abschriften_sa_kdp_bby_loyalty,

------------- sa_non_loyalty -------------

       a.umsatz_netto_sa_non_loyalty as umsatz_netto_sa_non_loyalty,
       a.menge_sa_non_loyalty as absatz_sa_non_loyalty,
       a.ek_mep_sa_non_loyalty as ek_mep_sa_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_non_loyalty
         else 0
       end as logkostenzuschlag_sa_non_loyalty_wg30,
       a.logkostenzuschlag_sa_non_loyalty as logkostenzuschlag_sa_non_loyalty,
       umsatz_netto_sa_non_loyalty - ((ek_mep_sa_non_loyalty + logkostenzuschlag_sa_non_loyalty_wg30) - logkostenzuschlag_sa_non_loyalty) as rohertrag_sa_non_loyalty,
       rohertrag_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_sa_non_loyalty,
       rohertrag_sa_non_loyalty-i.wa_kalk_abschriften_sa_non_loyalty as wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_nach_pv_sa_non_loyalty/nullifzero(umsatz_netto_sa_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_non_loyalty,
       wa_kalk_abschriften_sa_non_loyalty,

------------- sa_aktion_non_loyalty -------------

       a.umsatz_netto_sa_aktion_non_loyalty as umsatz_netto_sa_aktion_non_loyalty,
       a.menge_sa_aktion_non_loyalty as absatz_sa_aktion_non_loyalty,
       a.ek_mep_sa_aktion_non_loyalty as ek_mep_sa_aktion_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_aktion_non_loyalty
         else 0
       end as logkostenzuschlag_sa_aktion_non_loyalty_wg30,
       a.logkostenzuschlag_sa_aktion_non_loyalty as logkostenzuschlag_sa_aktion_non_loyalty,
       umsatz_netto_sa_aktion_non_loyalty - ((ek_mep_sa_aktion_non_loyalty + logkostenzuschlag_sa_aktion_non_loyalty_wg30) - logkostenzuschlag_sa_aktion_non_loyalty) as rohertrag_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_sa_aktion_non_loyalty,
       rohertrag_sa_aktion_non_loyalty-i.wa_kalk_abschriften_sa_aktion_non_loyalty as wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_nach_pv_sa_aktion_non_loyalty/nullifzero(umsatz_netto_sa_aktion_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
       wa_kalk_abschriften_sa_aktion_non_loyalty,

------------- sa_bby_non_loyalty -------------

       a.umsatz_netto_sa_bby_non_loyalty as umsatz_netto_sa_bby_non_loyalty,
       a.menge_sa_bby_non_loyalty as absatz_sa_bby_non_loyalty,
       a.ek_mep_sa_bby_non_loyalty as ek_mep_sa_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bby_non_loyalty,
       umsatz_netto_sa_bby_non_loyalty - ((ek_mep_sa_bby_non_loyalty + logkostenzuschlag_sa_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bby_non_loyalty) as rohertrag_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_sa_bby_non_loyalty,
       rohertrag_sa_bby_non_loyalty-i.wa_kalk_abschriften_sa_bby_non_loyalty as wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bby_non_loyalty/nullifzero(umsatz_netto_sa_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
       wa_kalk_abschriften_sa_bby_non_loyalty,

------------- sa_bonrabatt_bby_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_loyalty as umsatz_netto_sa_bonrabatt_bby_loyalty,
       a.menge_sa_bonrabatt_bby_loyalty as absatz_sa_bonrabatt_bby_loyalty,
       a.ek_mep_sa_bonrabatt_bby_loyalty as ek_mep_sa_bonrabatt_bby_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
       a.logkostenzuschlag_sa_bonrabatt_bby_loyalty as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       umsatz_netto_sa_bonrabatt_bby_loyalty - ((ek_mep_sa_bonrabatt_bby_loyalty + logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_loyalty) as rohertrag_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_sa_bonrabatt_bby_loyalty,
       rohertrag_sa_bonrabatt_bby_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,

------------- sa_bonrabatt_bby_non_loyalty -------------

       a.umsatz_netto_sa_bonrabatt_bby_non_loyalty as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       a.menge_sa_bonrabatt_bby_non_loyalty as absatz_sa_bonrabatt_bby_non_loyalty,
       a.ek_mep_sa_bonrabatt_bby_non_loyalty as ek_mep_sa_bonrabatt_bby_non_loyalty,
       case
         when b.wg_id in (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
         then a.logkostenzuschlag_sa_bby_non_loyalty
         else 0
       end as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
       a.logkostenzuschlag_sa_bby_non_loyalty as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
       umsatz_netto_sa_bonrabatt_bby_non_loyalty - ((ek_mep_sa_bonrabatt_bby_non_loyalty + logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30) - logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) as rohertrag_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_sa_bonrabatt_bby_non_loyalty,
       rohertrag_sa_bonrabatt_bby_non_loyalty-i.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty as wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
       wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
      
       j.pv_aktion_loy,
       j.pv_aktion_non_loy,
       j.pv_bby_loy,
       j.pv_bby_non_loy,
       j.pv_kdn_bby,
       j.pv_kdp_bby,
       j.pv_bonrabatt_bby_loy,
       j.pv_bonrabatt_bby_non_loy,

       b.wg_id,
       c.owg_id,
       d.hwg_id,
       c.abt_id
from _hilfe4 a
join dbp_data.art_wg_zu_per b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     b.dat_bis = '9999-12-31' and
     b.arthiertyp_id = 2
join dbp_data.wg_per c
  on a.mandant_id = c.mandant_id and
     b.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     c.arthiertyp_id = 2
join dbp_data.owg_per d
  on a.mandant_id = d.mandant_id and
     c.owg_id = d.owg_id and
     d.dat_bis = '9999-12-31' and
     d.arthiertyp_id = 2
join dbp_data.wup e
  on a.mandant_id = e.mandant_id and
     a.wup_id = e.wup_id
join (select a.mandant_id,
             a.kjwo_ww,
             coalesce(b.dat,a.dat) as dat
      from dbp_data.werbewoche_kl a
      left join dbp_etl_process.werbewoche_real_manuell b
        on a.kjwo_ww = b.kjwo_ww and
           a.mandant_id = b.mandant_id
      where a.mandant_id = 1
      group by 1,2,3) f
  on a.mandant_id = f.mandant_id and
     a.dat = f.dat
join (select mandant_id,
             kjwo,
             art_id,
             kl_art_id,
             muki
      from _hit_the_actions
      where kjwo <> $akt_woche
      group by 1,2,3,4,5) g
  on floor(a.art_id/100) = g.kl_art_id and
     a.mandant_id = g.mandant_id
left join (select mandant_id,
                  wup_id,
                  art_id,
                  dat,
                  sum(abschriftenbetrag_netto) as abschriftenbetrag_netto
           from dbp_msi_view2.mv_marktabschriften
           where abschriftenart_id = -1
           group by 1,2,3,4) h
  on a.art_id = h.art_id and
     a.mandant_id = h.mandant_id and
     a.wup_id = h.wup_id and
     a.dat = h.dat

left join _hilfe11 i
  on a.art_id = i.art_id and
     a.mandant_id = i.mandant_id and
     a.wup_id = i.wup_id and
     a.dat = i.dat
     
left join (select v01.mandant_id,
                  v01.wup_id,
                  v01.art_id,
                  v01.dat,
                  sum(case when v01.wv_grund_id = 2 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_loy,
                  sum(case when v01.wv_grund_id = 0 and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_aktion_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (52,53,54) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (52,54,54,55) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (56,57,58) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (56,57,58,59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (60,61,62) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (60,61,62,63) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdn_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (64,65,66,73,74,75) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto when v01.dat < '2022-04-01' and v01.wv_grund_id in (64,65,66,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_kdp_bby,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (59) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_non_loy,
                  sum(case when v01.dat >= '2022-04-01' and v01.wv_grund_id in (55,63,67) and v01.abschriftart_id = -1 then v01.abschriftbetrag_netto else 0 end) as pv_bonrabatt_bby_loy
           from dbp_data.marktabschriften v01	
           left join (select art_id
                            ,gp_id
                            ,wup_id
                            ,dat_von
                            ,dat_bis
                      from dbp_data.art_gp_nm_zu_per
                      where mandant_id = 1) v02	
             on v01.art_id = v02.art_id	and 
                v01.wup_id = v02.wup_id	and 
                v01.dat between v02.dat_von	and v02.dat_bis	
           join (select art_id
                       ,gewart_id
                 from dbp_data.art
                 where mandant_id = 1) v03	
             on v01.art_id = v03.art_id	
           where v01.mandant_id = 1
           group by 1,2,3,4) j
  on a.art_id = j.art_id and
     a.mandant_id = j.mandant_id and
     a.wup_id = j.wup_id and
     a.dat = j.dat
     
where a.mandant_id = 1 and
      a.bewart_id = 1002
;

create or replace volatile table _artbew2 as (
select mandant_id,
       kjwo_ww,
       wup_id,
       mutter_art_id,
       art_id,
       gp_id,
       aktionsart_id_liste_txt,
       aktionsart_bez_liste_txt,
       aktion_typ_id_liste_txt,
       aktion_typ_bez_liste_txt,
       wg_id,
       owg_id,
       hwg_id,
       abt_id,
       sum(umsatz_netto_sa_west) as umsatz_netto_sa_west,
       sum(absatz_sa_west) as absatz_sa_west,
       sum(ek_mep_sa_west) as ek_mep_sa_west,
       sum(logkostenzuschlag_sa_west_wg30) as logkostenzuschlag_sa_west_wg30,
       sum(logkostenzuschlag_sa_west) as logkostenzuschlag_sa_west,
       sum(preisvorteil_west) as preisvorteil_west,
       sum(wa_kalk_nach_pv_sa_west) as wa_kalk_nach_pv_sa_west,
       sum(wa_kalk_abschriften_sa_west) as wa_kalk_abschriften_sa_west,
       ---
       sum(umsatz_netto_sa_ost) as umsatz_netto_sa_ost,
       sum(absatz_sa_ost) as absatz_sa_ost,
       sum(ek_mep_sa_ost) as ek_mep_sa_ost,
       sum(logkostenzuschlag_sa_ost_wg30) as logkostenzuschlag_sa_ost_wg30,
       sum(logkostenzuschlag_sa_ost) as logkostenzuschlag_sa_ost,
       sum(preisvorteil_ost) as preisvorteil_ost,
       sum(wa_kalk_nach_pv_sa_ost) as wa_kalk_nach_pv_sa_ost,
       sum(wa_kalk_abschriften_sa_ost) as wa_kalk_abschriften_sa_ost,
       ---
       sum(umsatz_netto_sa_sued) as umsatz_netto_sa_sued,
       sum(absatz_sa_sued) as absatz_sa_sued,
       sum(ek_mep_sa_sued) as ek_mep_sa_sued,
       sum(logkostenzuschlag_sa_sued_wg30) as logkostenzuschlag_sa_sued_wg30,
       sum(logkostenzuschlag_sa_sued) as logkostenzuschlag_sa_sued,
       sum(preisvorteil_sued) as preisvorteil_sued,
       sum(wa_kalk_nach_pv_sa_sued) as wa_kalk_nach_pv_sa_sued,
       sum(wa_kalk_abschriften_sa_sued) as wa_kalk_abschriften_sa_sued,
       ---
       sum(umsatz_netto_sa) as umsatz_netto_sa,
       sum(absatz_sa) as absatz_sa,
       sum(ek_mep_sa) as ek_mep_sa,
       sum(logkostenzuschlag_sa_wg30) as logkostenzuschlag_sa_wg30,
       sum(logkostenzuschlag_sa) as logkostenzuschlag_sa,
       sum(preisvorteil) as preisvorteil,
       sum(wa_kalk_nach_pv_sa) as wa_kalk_nach_pv_sa,
       sum(wa_kalk_abschriften_sa) as wa_kalk_abschriften_sa,

       -- sa_loyalty --
       
       sum(umsatz_netto_sa_loyalty) as umsatz_netto_sa_loyalty,
       sum(absatz_sa_loyalty) as absatz_sa_loyalty,
       sum(ek_mep_sa_loyalty) as ek_mep_sa_loyalty,
       sum(logkostenzuschlag_sa_loyalty_wg30) as logkostenzuschlag_sa_loyalty_wg30,
       sum(logkostenzuschlag_sa_loyalty) as logkostenzuschlag_sa_loyalty,
       sum(wa_kalk_abschriften_sa_loyalty) as wa_kalk_abschriften_sa_loyalty,
       
       -- sa_aktion_loyalty --
         
       sum(umsatz_netto_sa_aktion_loyalty) as umsatz_netto_sa_aktion_loyalty,
       sum(absatz_sa_aktion_loyalty) as absatz_sa_aktion_loyalty,
       sum(ek_mep_sa_aktion_loyalty) as ek_mep_sa_aktion_loyalty,
       sum(logkostenzuschlag_sa_aktion_loyalty_wg30) as logkostenzuschlag_sa_aktion_loyalty_wg30,
       sum(logkostenzuschlag_sa_aktion_loyalty) as logkostenzuschlag_sa_aktion_loyalty,
       sum(wa_kalk_abschriften_sa_aktion_loyalty) as wa_kalk_abschriften_sa_aktion_loyalty,
       
       -- sa_bby_loyalty --
         
       sum(umsatz_netto_sa_bby_loyalty) as umsatz_netto_sa_bby_loyalty,
       sum(absatz_sa_bby_loyalty) as absatz_sa_bby_loyalty,
       sum(ek_mep_sa_bby_loyalty) as ek_mep_sa_bby_loyalty,
       sum(logkostenzuschlag_sa_bby_loyalty_wg30) as logkostenzuschlag_sa_bby_loyalty_wg30,
       sum(logkostenzuschlag_sa_bby_loyalty) as logkostenzuschlag_sa_bby_loyalty,
       sum(wa_kalk_abschriften_sa_bby_loyalty) as wa_kalk_abschriften_sa_bby_loyalty,
       
       -- sa_kdn_bby_loyalty --
         
       sum(umsatz_netto_sa_kdn_bby_loyalty) as umsatz_netto_sa_kdn_bby_loyalty,
       sum(absatz_sa_kdn_bby_loyalty) as absatz_sa_kdn_bby_loyalty,
       sum(ek_mep_sa_kdn_bby_loyalty) as ek_mep_sa_kdn_bby_loyalty,
       sum(logkostenzuschlag_sa_kdn_bby_loyalty_wg30) as logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
       sum(logkostenzuschlag_sa_kdn_bby_loyalty) as logkostenzuschlag_sa_kdn_bby_loyalty,
       sum(wa_kalk_abschriften_sa_kdn_bby_loyalty) as wa_kalk_abschriften_sa_kdn_bby_loyalty,
         
       -- sa_kdp_bby_loyalty --
       
       sum(umsatz_netto_sa_kdp_bby_loyalty) as umsatz_netto_sa_kdp_bby_loyalty,
       sum(absatz_sa_kdp_bby_loyalty) as absatz_sa_kdp_bby_loyalty,
       sum(ek_mep_sa_kdp_bby_loyalty) as ek_mep_sa_kdp_bby_loyalty,
       sum(logkostenzuschlag_sa_kdp_bby_loyalty_wg30) as logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
       sum(logkostenzuschlag_sa_kdp_bby_loyalty) as logkostenzuschlag_sa_kdp_bby_loyalty,
       sum(wa_kalk_abschriften_sa_kdp_bby_loyalty) as wa_kalk_abschriften_sa_kdp_bby_loyalty,
         
       -- sa_non_loyalty --
         
       sum(umsatz_netto_sa_non_loyalty) as umsatz_netto_sa_non_loyalty,
       sum(absatz_sa_non_loyalty) as absatz_sa_non_loyalty,
       sum(ek_mep_sa_non_loyalty) as ek_mep_sa_non_loyalty,
       sum(logkostenzuschlag_sa_non_loyalty_wg30) as logkostenzuschlag_sa_non_loyalty_wg30,
       sum(logkostenzuschlag_sa_non_loyalty) as logkostenzuschlag_sa_non_loyalty,
       sum(wa_kalk_abschriften_sa_non_loyalty) as wa_kalk_abschriften_sa_non_loyalty,
         
       -- sa_aktion_non_loyalty --
         
       sum(umsatz_netto_sa_aktion_non_loyalty) as umsatz_netto_sa_aktion_non_loyalty,
       sum(absatz_sa_aktion_non_loyalty) as absatz_sa_aktion_non_loyalty,
       sum(ek_mep_sa_aktion_non_loyalty) as ek_mep_sa_aktion_non_loyalty,
       sum(logkostenzuschlag_sa_aktion_non_loyalty_wg30) as logkostenzuschlag_sa_aktion_non_loyalty_wg30,
       sum(logkostenzuschlag_sa_aktion_non_loyalty) as logkostenzuschlag_sa_aktion_non_loyalty,
       sum(wa_kalk_abschriften_sa_aktion_non_loyalty) as wa_kalk_abschriften_sa_aktion_non_loyalty,
         
       -- sa_bby_non_loyalty --
         
       sum(umsatz_netto_sa_bby_non_loyalty) as umsatz_netto_sa_bby_non_loyalty,
       sum(absatz_sa_bby_non_loyalty) as absatz_sa_bby_non_loyalty,
       sum(ek_mep_sa_bby_non_loyalty) as ek_mep_sa_bby_non_loyalty,
       sum(logkostenzuschlag_sa_bby_non_loyalty_wg30) as logkostenzuschlag_sa_bby_non_loyalty_wg30,
       sum(logkostenzuschlag_sa_bby_non_loyalty) as logkostenzuschlag_sa_bby_non_loyalty,
       sum(wa_kalk_abschriften_sa_bby_non_loyalty) as wa_kalk_abschriften_sa_bby_non_loyalty,
       
       -- sa_bonrabatt_bby_loyalty --
       
       sum(umsatz_netto_sa_bonrabatt_bby_loyalty) as umsatz_netto_sa_bonrabatt_bby_loyalty,
       sum(absatz_sa_bonrabatt_bby_loyalty) as absatz_sa_bonrabatt_bby_loyalty,
       sum(ek_mep_sa_bonrabatt_bby_loyalty) as ek_mep_sa_bonrabatt_bby_loyalty,
       sum(logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30) as logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
       sum(logkostenzuschlag_sa_bonrabatt_bby_loyalty) as logkostenzuschlag_sa_bonrabatt_bby_loyalty,
       sum(wa_kalk_abschriften_sa_bonrabatt_bby_loyalty) as wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
       
       -- sa_bonrabatt_bby_non_loyalty --
       
       sum(umsatz_netto_sa_bonrabatt_bby_non_loyalty) as umsatz_netto_sa_bonrabatt_bby_non_loyalty,
       sum(absatz_sa_bonrabatt_bby_non_loyalty) as absatz_sa_bonrabatt_bby_non_loyalty,
       sum(ek_mep_sa_bonrabatt_bby_non_loyalty) as ek_mep_sa_bonrabatt_bby_non_loyalty,
       sum(logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30) as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
       sum(logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
       sum(wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty) as wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
       
       sum(pv_aktion_loy) as pv_aktion_loy,
       sum(pv_aktion_non_loy) as pv_aktion_non_loy,
       sum(pv_bby_loy) as pv_bby_loy,
       sum(pv_bby_non_loy) as pv_bby_non_loy,
       sum(pv_kdn_bby) as pv_kdn_bby,
       sum(pv_kdp_bby) as pv_kdp_bby,
       sum(pv_bonrabatt_bby_loy) as pv_bonrabatt_bby_loy,
       sum(pv_bonrabatt_bby_non_loy) as pv_bonrabatt_bby_non_loy
  
from _artbew1
group by all
);

update _hit_the_actions from (select a.mandant_id
                                    ,a.wup_id
                                    ,a.kl_art_id
                                    ,b.kjwo_ww
                                    ,max(a.aktion_thema_id) as aktion_thema_id
                              from dbp_etl_process.bon_aktion_thema_group a
                              join dbp_data.werbewoche_kl b
                                on a.bon_dat = b.dat
                              group by 1,2,3,4) b

set aktion_thema_gruppe_id = b.aktion_thema_id

where _hit_the_actions.mandant_id = b.mandant_id and
      _hit_the_actions.wup_id = b.wup_id and
      _hit_the_actions.kl_art_id = b.kl_art_id and
      _hit_the_actions.kjwo = b.kjwo_ww
;

select *
from dbp_data.aktionsart_spr_zu
where aktionsart_id = 'ZKX'
;

create or replace volatile table _distinct_aktionsart as (
select mandant_id,
       mutter_art_id,
       s.value as aktionsart_id_liste_txt,
       t.value as aktionsart_bez_liste_txt
from _artbew2 a,lateral split_to_table(a.aktionsart_id_liste_txt,',') s,lateral split_to_table(a.aktionsart_bez_liste_txt,',') t
where s.value <> '' and
      t.value <> ''
group by all
);

create or replace volatile table _distinct_aktionsart2 as (
select x.mandant_id,
       x.mutter_art_id,
       max(x.aktionsart_id_liste_txt_) as aktionsart_id_liste_txt,
       max(x.aktionsart_bez_liste_txt_) as aktionsart_bez_liste_txt
from (select mandant_id,
             mutter_art_id,
             rtrim((listagg(distinct aktionsart_id_liste_txt , ',' ) within group (order by null)), ',') as aktionsart_id_liste_txt_,
             rtrim((listagg(distinct aktionsart_bez_liste_txt , ',' ) within group (order by null)), ',') as aktionsart_bez_liste_txt_,
             length(aktionsart_id_liste_txt_) as anz
      from _distinct_aktionsart
      group by 1,2) x
join (select x.mandant_id,
             x.mutter_art_id,
             max(x.anz) as anz
      from (select mandant_id,
                   mutter_art_id,
                   rtrim((listagg(distinct aktionsart_id_liste_txt , ',' ) within group (order by null)), ',') as aktionsart_id_liste_txt_,
                   rtrim((listagg(distinct aktionsart_bez_liste_txt , ',' ) within group (order by null)), ',') as aktionsart_bez_liste_txt_,
                   length(aktionsart_id_liste_txt_) as anz
            from _distinct_aktionsart
            group by 1,2) x
      group by 1,2) y
  on x.mandant_id = y.mandant_id and
     x.mutter_art_id = y.mutter_art_id and
     x.anz = y.anz
group by 1,2
);

create or replace volatile table _distinct_aktiontyp as (
select mandant_id,
       mutter_art_id,
       s.value as aktion_typ_id_liste_txt,
       t.value as aktion_typ_bez_liste_txt
from _artbew2 a,lateral split_to_table(a.aktion_typ_id_liste_txt,',') s,lateral split_to_table(a.aktion_typ_bez_liste_txt,',') t
where s.value <> '' and
      t.value <> ''
group by 1,2,3,4
);

create or replace volatile table _distinct_aktiontyp2 as (
select x.mandant_id,
       x.mutter_art_id,
       max(x.aktion_typ_id_liste_txt_) as aktion_typ_id_liste_txt,
       max(x.aktion_typ_bez_liste_txt_) as aktion_typ_bez_liste_txt
from (select mandant_id,
             mutter_art_id,
             rtrim((listagg(distinct aktion_typ_id_liste_txt , ',' ) within group (order by null)), ',') as aktion_typ_id_liste_txt_,
             rtrim((listagg(distinct aktion_typ_bez_liste_txt , ',' ) within group (order by null)), ',') as aktion_typ_bez_liste_txt_,
             length(aktion_typ_id_liste_txt_) as anz
      from _distinct_aktiontyp
      group by 1,2) x
join (select x.mandant_id,
             x.mutter_art_id,
             max(x.anz) as anz
      from (select mandant_id,
                   mutter_art_id,
                   rtrim((listagg(distinct aktion_typ_id_liste_txt , ',' ) within group (order by null)), ',') as aktion_typ_id_liste_txt_,
                   rtrim((listagg(distinct aktion_typ_bez_liste_txt , ',' ) within group (order by null)), ',') as aktion_typ_bez_liste_txt_,
                   length(aktion_typ_id_liste_txt_) as anz
            from _distinct_aktiontyp
            group by 1,2) x
      group by 1,2) y
  on x.mandant_id = y.mandant_id and
     x.mutter_art_id = y.mutter_art_id and
     x.anz = y.anz
group by 1,2
);

create or replace volatile table _distinct_art1 as (
select mandant_id,
       mutter_art_id,
       art_id
from _artbew2
group by 1,2,3
);

create or replace volatile table _distinct_art2 as (
select x.mandant_id,
       x.mutter_art_id,
       max(x.kl_art_id_) as kl_art_id
from (select mandant_id,
             mutter_art_id,
             translate(rtrim((listagg(cast(art_id/100 as number(10)), ',' ) within group (order by cast(art_id/100 as number(10)))), ','),' ', '') as kl_art_id_,
             length(kl_art_id_) as anz
      from _distinct_art1
      group by 1,2) x
join (select x.mandant_id,
             x.mutter_art_id,
             max(x.anz) as anz
      from (select mandant_id,
                   mutter_art_id,
                   translate(rtrim((listagg(cast(art_id/100 as number(10)), ',' ) within group (order by cast(art_id/100 as number(10)))), ','),' ', '') as kl_art_id_,
                   length(kl_art_id_) as anz
            from _distinct_art1
            group by 1,2) x
      group by 1,2) y
  on x.mandant_id = y.mandant_id and
     x.mutter_art_id = y.mutter_art_id and
     x.anz = y.anz
group by 1,2
);

create or replace volatile table _distinct_aktion_thema1 as (
select a.mandant_id,
       a.art_id as mutter_art_id,
       b.art_id,
       a.wup_id,
       a.aktion_thema_gruppe_id
from _hit_the_actions a
join dbp_data.art b
  on a.mandant_id = b.mandant_id and
     a.kl_art_id = b.kl_art_id and
     b.dat_bis = '9999-12-31'
group by 1,2,3,4,5
);

create or replace volatile table _distinct_aktion_thema2 as (
select a.mandant_id,
       a.mutter_art_id,
       a.art_id,
       a.wup_id,
       max(a.aktion_thema_gruppe_id) as aktion_thema_gruppe_id
from _distinct_aktion_thema1 a
group by 1,2,3,4
);

create or replace volatile table _distinct_wg1 as (
select mandant_id,
       mutter_art_id,
       wg_id
from _artbew2
group by 1,2,3
);

create or replace volatile table _distinct_wg2 as (
select x.mandant_id,
       x.mutter_art_id,
       max(x.wg_id_) as wg_id
from (select mandant_id,
             mutter_art_id,
             translate(rtrim((listagg(wg_id , ',' ) within group (order by wg_id)), ','),' ', '') as wg_id_,
             length(wg_id_) as anz
      from _distinct_wg1
      group by 1,2) x
join (select x.mandant_id,
             x.mutter_art_id,
             max(x.anz) as anz
      from (select mandant_id,
                   mutter_art_id,
                   translate(rtrim((listagg(wg_id , ',' ) within group (order by wg_id)), ','),' ', '') as wg_id_,
                   length(wg_id_) as anz
            from _distinct_wg1
            group by 1,2) x
      group by 1,2) y
  on x.mandant_id = y.mandant_id and
     x.mutter_art_id = y.mutter_art_id and
     x.anz = y.anz
group by 1,2
);

create or replace volatile table _distinct_werbe_kat1 as (
select mandant_id,
       art_id as mutter_art_id,
       werbe_kat_id
from _hit_the_actions
group by 1,2,3
);

create or replace volatile table _distinct_werbe_kat2 as (
select x.mandant_id,
       x.mutter_art_id,
       max(x.werbe_kat_id_) as werbe_kat_id
from (select mandant_id,
             mutter_art_id,
             translate(rtrim((listagg(werbe_kat_id , ',' ) within group (order by werbe_kat_id)), ','),' ', '') as werbe_kat_id_,
             length(werbe_kat_id_) as anz
      from _distinct_werbe_kat1
      group by 1,2) x
join (select x.mandant_id,
             x.mutter_art_id,
             max(x.anz) as anz
      from (select mandant_id,
                   mutter_art_id,
                   translate(rtrim((listagg(werbe_kat_id , ',' ) within group (order by werbe_kat_id)), ','),' ', '') as werbe_kat_id_,
                   length(werbe_kat_id_) as anz
            from _distinct_werbe_kat1
            group by 1,2) x
      group by 1,2) y
  on x.mandant_id = y.mandant_id and
     x.mutter_art_id = y.mutter_art_id and
     x.anz = y.anz
group by 1,2
);

create or replace volatile table _artbew4 as (
select a.mandant_id,
       $akt_woche as kjwo_ww,
       a.kjwo_ww as kjwo,
       a.mutter_art_id,
       b.kl_art_id,
       coalesce(c.aktion_thema_gruppe_id,'') as aktion_thema_gruppe_id,
       e.werbe_kat_id,
       a.gp_id,
       f.aktionsart_id_liste_txt,
       f.aktionsart_bez_liste_txt,
       g.aktion_typ_id_liste_txt,
       g.aktion_typ_bez_liste_txt,
       d.wg_id,
       sum(umsatz_netto_sa_west) as umsatz_netto_sa_west_,
       sum(absatz_sa_west) as absatz_sa_west_,
       sum(ek_mep_sa_west) as ek_mep_sa_west_,
       sum(0) as logkostenzuschlag_sa_west_wg30_,
       sum(logkostenzuschlag_sa_west) as logkostenzuschlag_sa_west_,
       umsatz_netto_sa_west_ - ((ek_mep_sa_west_ + logkostenzuschlag_sa_west_wg30_) - logkostenzuschlag_sa_west_) as rohertrag_sa_west_,
       rohertrag_sa_west_/nullifzero(umsatz_netto_sa_west_)*100 as spanne_sa_west_,
       sum(preisvorteil_west) as preisvorteil_west,
       sum(coalesce(wa_kalk_abschriften_sa_west,0)) as wa_kalk_abschriften_sa_west_,
       rohertrag_sa_west_-wa_kalk_abschriften_sa_west_ as wa_kalk_nach_pv_sa_west_,
       wa_kalk_nach_pv_sa_west_/nullifzero(umsatz_netto_sa_west_)*100 as spanne_wa_kalk_nach_pv_sa_west_,
  
       sum(umsatz_netto_sa_ost) as umsatz_netto_sa_ost_,
       sum(absatz_sa_ost) as absatz_sa_ost_,
       sum(ek_mep_sa_ost) as ek_mep_sa_ost_,
       sum(0) as logkostenzuschlag_sa_ost_wg30_,
       sum(logkostenzuschlag_sa_ost) as logkostenzuschlag_sa_ost_,
       umsatz_netto_sa_ost_ - ((ek_mep_sa_ost_ + logkostenzuschlag_sa_ost_wg30_) - logkostenzuschlag_sa_ost_) as rohertrag_sa_ost_,
       rohertrag_sa_ost_/nullifzero(umsatz_netto_sa_ost_)*100 as spanne_sa_ost_,
       sum(preisvorteil_ost) as preisvorteil_ost,
       sum(coalesce(wa_kalk_abschriften_sa_ost,0)) as wa_kalk_abschriften_sa_ost_,
       rohertrag_sa_ost_-wa_kalk_abschriften_sa_ost_ as wa_kalk_nach_pv_sa_ost_,
       wa_kalk_nach_pv_sa_ost_/nullifzero(umsatz_netto_sa_ost_)*100 as spanne_wa_kalk_nach_pv_sa_ost_,
  
       sum(umsatz_netto_sa_sued) as umsatz_netto_sa_sued_,
       sum(absatz_sa_sued) as absatz_sa_sued_,
       sum(ek_mep_sa_sued) as ek_mep_sa_sued_,
       sum(0) as logkostenzuschlag_sa_sued_wg30_,
       sum(logkostenzuschlag_sa_sued) as logkostenzuschlag_sa_sued_,
       umsatz_netto_sa_sued_ - ((ek_mep_sa_sued_ + logkostenzuschlag_sa_sued_wg30_) - logkostenzuschlag_sa_sued_) as rohertrag_sa_sued_,
       rohertrag_sa_sued_/nullifzero(umsatz_netto_sa_sued_)*100 as spanne_sa_sued_,
       sum(preisvorteil_sued) as preisvorteil_sued,
       sum(coalesce(wa_kalk_abschriften_sa_sued,0)) as wa_kalk_abschriften_sa_sued_,
       rohertrag_sa_sued_-wa_kalk_abschriften_sa_sued_ as wa_kalk_nach_pv_sa_sued_,
       wa_kalk_nach_pv_sa_sued_/nullifzero(umsatz_netto_sa_sued_)*100 as spanne_wa_kalk_nach_pv_sa_sued_,
  
       sum(umsatz_netto_sa) as umsatz_netto_sa_,
       sum(absatz_sa) as absatz_sa_,
       sum(ek_mep_sa) as ek_mep_sa_,
       sum(0) as logkostenzuschlag_sa_wg30_,
       sum(logkostenzuschlag_sa) as logkostenzuschlag_sa_,
       umsatz_netto_sa_ - ((ek_mep_sa_ + logkostenzuschlag_sa_wg30_) - logkostenzuschlag_sa_) as rohertrag_sa_,
       rohertrag_sa_/nullifzero(umsatz_netto_sa_)*100 as spanne_sa_,
       sum(preisvorteil) as preisvorteil,
       sum(coalesce(wa_kalk_abschriften_sa,0)) as wa_kalk_abschriften_sa_,
       rohertrag_sa_-wa_kalk_abschriften_sa_ as wa_kalk_nach_pv_sa_,
       wa_kalk_nach_pv_sa_/nullifzero(umsatz_netto_sa_)*100 as spanne_wa_kalk_nach_pv_sa_,
  
       -- sa_loyalty --
       
       sum(umsatz_netto_sa_loyalty) as umsatz_netto_sa_loyalty_,
       sum(absatz_sa_loyalty) as absatz_sa_loyalty_,
       sum(ek_mep_sa_loyalty) as ek_mep_sa_loyalty_,
       sum(0) as logkostenzuschlag_sa_loyalty_wg30_,
       sum(logkostenzuschlag_sa_loyalty) as logkostenzuschlag_sa_loyalty_,
       umsatz_netto_sa_loyalty_ - ((ek_mep_sa_loyalty_ + logkostenzuschlag_sa_loyalty_wg30_) - logkostenzuschlag_sa_loyalty_) as rohertrag_sa_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_loyalty,0)) as wa_kalk_abschriften_sa_loyalty_,
       rohertrag_sa_loyalty_-wa_kalk_abschriften_sa_loyalty_ as wa_kalk_nach_pv_sa_loyalty_,
       wa_kalk_nach_pv_sa_loyalty_/nullifzero(umsatz_netto_sa_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_loyalty_,
       
       -- sa_aktion_loyalty --
         
       sum(umsatz_netto_sa_aktion_loyalty) as umsatz_netto_sa_aktion_loyalty_,
       sum(absatz_sa_aktion_loyalty) as absatz_sa_aktion_loyalty_,
       sum(ek_mep_sa_aktion_loyalty) as ek_mep_sa_aktion_loyalty_,
       sum(0) as logkostenzuschlag_sa_aktion_loyalty_wg30_,
       sum(logkostenzuschlag_sa_aktion_loyalty) as logkostenzuschlag_sa_aktion_loyalty_,
       umsatz_netto_sa_aktion_loyalty_ - ((ek_mep_sa_aktion_loyalty_ + logkostenzuschlag_sa_aktion_loyalty_wg30_) - logkostenzuschlag_sa_aktion_loyalty_) as rohertrag_sa_aktion_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_aktion_loyalty,0)) as wa_kalk_abschriften_sa_aktion_loyalty_,
       rohertrag_sa_aktion_loyalty_-wa_kalk_abschriften_sa_aktion_loyalty_ as wa_kalk_nach_pv_sa_aktion_loyalty_,
       wa_kalk_nach_pv_sa_aktion_loyalty_/nullifzero(umsatz_netto_sa_aktion_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_aktion_loyalty_,
       
       -- sa_bby_loyalty --
         
       sum(umsatz_netto_sa_bby_loyalty) as umsatz_netto_sa_bby_loyalty_,
       sum(absatz_sa_bby_loyalty) as absatz_sa_bby_loyalty_,
       sum(ek_mep_sa_bby_loyalty) as ek_mep_sa_bby_loyalty_,
       sum(0) as logkostenzuschlag_sa_bby_loyalty_wg30_,
       sum(logkostenzuschlag_sa_bby_loyalty) as logkostenzuschlag_sa_bby_loyalty_,
       umsatz_netto_sa_bby_loyalty_ - ((ek_mep_sa_bby_loyalty_ + logkostenzuschlag_sa_bby_loyalty_wg30_) - logkostenzuschlag_sa_bby_loyalty_) as rohertrag_sa_bby_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_bby_loyalty,0)) as wa_kalk_abschriften_sa_bby_loyalty_,
       rohertrag_sa_bby_loyalty_-wa_kalk_abschriften_sa_bby_loyalty_ as wa_kalk_nach_pv_sa_bby_loyalty_,
       wa_kalk_nach_pv_sa_bby_loyalty_/nullifzero(umsatz_netto_sa_bby_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_bby_loyalty_,
       
       -- sa_kdn_bby_loyalty --
         
       sum(umsatz_netto_sa_kdn_bby_loyalty) as umsatz_netto_sa_kdn_bby_loyalty_,
       sum(absatz_sa_kdn_bby_loyalty) as absatz_sa_kdn_bby_loyalty_,
       sum(ek_mep_sa_kdn_bby_loyalty) as ek_mep_sa_kdn_bby_loyalty_,
       sum(0) as logkostenzuschlag_sa_kdn_bby_loyalty_wg30_,
       sum(logkostenzuschlag_sa_kdn_bby_loyalty) as logkostenzuschlag_sa_kdn_bby_loyalty_,
       umsatz_netto_sa_kdn_bby_loyalty_ - ((ek_mep_sa_kdn_bby_loyalty_ + logkostenzuschlag_sa_kdn_bby_loyalty_wg30_) - logkostenzuschlag_sa_kdn_bby_loyalty_) as rohertrag_sa_kdn_bby_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_kdn_bby_loyalty,0)) as wa_kalk_abschriften_sa_kdn_bby_loyalty_,
       rohertrag_sa_kdn_bby_loyalty_-wa_kalk_abschriften_sa_kdn_bby_loyalty_ as wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
       wa_kalk_nach_pv_sa_kdn_bby_loyalty_/nullifzero(umsatz_netto_sa_kdn_bby_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
         
       -- sa_kdp_bby_loyalty --
         
       sum(umsatz_netto_sa_kdp_bby_loyalty) as umsatz_netto_sa_kdp_bby_loyalty_,
       sum(absatz_sa_kdp_bby_loyalty) as absatz_sa_kdp_bby_loyalty_,
       sum(ek_mep_sa_kdp_bby_loyalty) as ek_mep_sa_kdp_bby_loyalty_,
       sum(0) as logkostenzuschlag_sa_kdp_bby_loyalty_wg30_,
       sum(logkostenzuschlag_sa_kdp_bby_loyalty) as logkostenzuschlag_sa_kdp_bby_loyalty_,
       umsatz_netto_sa_kdp_bby_loyalty_ - ((ek_mep_sa_kdp_bby_loyalty_ + logkostenzuschlag_sa_kdp_bby_loyalty_wg30_) - logkostenzuschlag_sa_kdp_bby_loyalty_) as rohertrag_sa_kdp_bby_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_kdp_bby_loyalty,0)) as wa_kalk_abschriften_sa_kdp_bby_loyalty_,
       rohertrag_sa_kdp_bby_loyalty_-wa_kalk_abschriften_sa_kdp_bby_loyalty_ as wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
       wa_kalk_nach_pv_sa_kdp_bby_loyalty_/nullifzero(umsatz_netto_sa_kdp_bby_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
         
       -- sa_non_loyalty --
         
       sum(umsatz_netto_sa_non_loyalty) as umsatz_netto_sa_non_loyalty_,
       sum(absatz_sa_non_loyalty) as absatz_sa_non_loyalty_,
       sum(ek_mep_sa_non_loyalty) as ek_mep_sa_non_loyalty_,
       sum(0) as logkostenzuschlag_sa_non_loyalty_wg30_,
       sum(logkostenzuschlag_sa_non_loyalty) as logkostenzuschlag_sa_non_loyalty_,
       umsatz_netto_sa_non_loyalty_ - ((ek_mep_sa_non_loyalty_ + logkostenzuschlag_sa_non_loyalty_wg30_) - logkostenzuschlag_sa_non_loyalty_) as rohertrag_sa_non_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_non_loyalty,0)) as wa_kalk_abschriften_sa_non_loyalty_,
       rohertrag_sa_non_loyalty_-wa_kalk_abschriften_sa_non_loyalty_ as wa_kalk_nach_pv_sa_non_loyalty_,
       wa_kalk_nach_pv_sa_non_loyalty_/nullifzero(umsatz_netto_sa_non_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_non_loyalty_,
         
       -- sa_aktion_non_loyalty --
         
       sum(umsatz_netto_sa_aktion_non_loyalty) as umsatz_netto_sa_aktion_non_loyalty_,
       sum(absatz_sa_aktion_non_loyalty) as absatz_sa_aktion_non_loyalty_,
       sum(ek_mep_sa_aktion_non_loyalty) as ek_mep_sa_aktion_non_loyalty_,
       sum(0) as logkostenzuschlag_sa_aktion_non_loyalty_wg30_,
       sum(logkostenzuschlag_sa_aktion_non_loyalty) as logkostenzuschlag_sa_aktion_non_loyalty_,
       umsatz_netto_sa_aktion_non_loyalty_ - ((ek_mep_sa_aktion_non_loyalty_ + logkostenzuschlag_sa_aktion_non_loyalty_wg30_) - logkostenzuschlag_sa_aktion_non_loyalty_) as rohertrag_sa_aktion_non_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_aktion_non_loyalty,0)) as wa_kalk_abschriften_sa_aktion_non_loyalty_,
       rohertrag_sa_aktion_non_loyalty_-wa_kalk_abschriften_sa_aktion_non_loyalty_ as wa_kalk_nach_pv_sa_aktion_non_loyalty_,
       wa_kalk_nach_pv_sa_aktion_non_loyalty_/nullifzero(umsatz_netto_sa_aktion_non_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty_,
       
       -- sa_bby_non_loyalty --
         
       sum(umsatz_netto_sa_bby_non_loyalty) as umsatz_netto_sa_bby_non_loyalty_,
       sum(absatz_sa_bby_non_loyalty) as absatz_sa_bby_non_loyalty_,
       sum(ek_mep_sa_bby_non_loyalty) as ek_mep_sa_bby_non_loyalty_,
       sum(0) as logkostenzuschlag_sa_bby_non_loyalty_wg30_,
       sum(logkostenzuschlag_sa_bby_non_loyalty) as logkostenzuschlag_sa_bby_non_loyalty_,
       umsatz_netto_sa_bby_non_loyalty_ - ((ek_mep_sa_bby_non_loyalty_ + logkostenzuschlag_sa_bby_non_loyalty_wg30_) - logkostenzuschlag_sa_bby_non_loyalty_) as rohertrag_sa_bby_non_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_bby_non_loyalty,0)) as wa_kalk_abschriften_sa_bby_non_loyalty_,
       rohertrag_sa_bby_non_loyalty_-wa_kalk_abschriften_sa_bby_non_loyalty_ as wa_kalk_nach_pv_sa_bby_non_loyalty_,
       wa_kalk_nach_pv_sa_bby_non_loyalty_/nullifzero(umsatz_netto_sa_bby_non_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_bby_non_loyalty_,
       
       -- sa_bonrabatt_bby_loyalty --
         
       sum(umsatz_netto_sa_bonrabatt_bby_loyalty) as umsatz_netto_sa_bonrabatt_bby_loyalty_,
       sum(absatz_sa_bonrabatt_bby_loyalty) as absatz_sa_bonrabatt_bby_loyalty_,
       sum(ek_mep_sa_bonrabatt_bby_loyalty) as ek_mep_sa_bonrabatt_bby_loyalty_,
       sum(0) as logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30_,
       sum(logkostenzuschlag_sa_bonrabatt_bby_loyalty) as logkostenzuschlag_sa_bonrabatt_bby_loyalty_,
       umsatz_netto_sa_bonrabatt_bby_loyalty_ - ((ek_mep_sa_bonrabatt_bby_loyalty_ + logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30_) - logkostenzuschlag_sa_bonrabatt_bby_loyalty_) as rohertrag_sa_bonrabatt_bby_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,0)) as wa_kalk_abschriften_sa_bonrabatt_bby_loyalty_,
       rohertrag_sa_bonrabatt_bby_loyalty_-wa_kalk_abschriften_sa_bonrabatt_bby_loyalty_ as wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_,
       wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_/nullifzero(umsatz_netto_sa_bonrabatt_bby_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_,
       
       -- sa_bonrabatt_bby_non_loyalty --
         
       sum(umsatz_netto_sa_bonrabatt_bby_non_loyalty) as umsatz_netto_sa_bonrabatt_bby_non_loyalty_,
       sum(absatz_sa_bonrabatt_bby_non_loyalty) as absatz_sa_bonrabatt_bby_non_loyalty_,
       sum(ek_mep_sa_bonrabatt_bby_non_loyalty) as ek_mep_sa_bonrabatt_bby_non_loyalty_,
       sum(0) as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30_,
       sum(logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) as logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_,
       umsatz_netto_sa_bonrabatt_bby_non_loyalty_ - ((ek_mep_sa_bonrabatt_bby_non_loyalty_ + logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30_) - logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_) as rohertrag_sa_bonrabatt_bby_non_loyalty_,
       sum(coalesce(wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,0)) as wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty_,
       rohertrag_sa_bonrabatt_bby_non_loyalty_-wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty_ as wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
       wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_/nullifzero(umsatz_netto_sa_bonrabatt_bby_non_loyalty_)*100 as spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
       
       sum(pv_aktion_loy) as pv_aktion_loy,
       sum(pv_aktion_non_loy) as pv_aktion_non_loy,
       sum(pv_bby_loy) as pv_bby_loy,
       sum(pv_bby_non_loy) as pv_bby_non_loy,
       sum(pv_kdn_bby) as pv_kdn_bby,
       sum(pv_kdp_bby) as pv_kdp_bby,
       sum(pv_bonrabatt_bby_loy) as pv_bonrabatt_bby_loy,
       sum(pv_bonrabatt_bby_non_loy) as pv_bonrabatt_bby_non_loy
  
from _artbew2 a
join _distinct_art2 b
  on a.mandant_id = b.mandant_id and
     a.mutter_art_id = b.mutter_art_id
left join (select a.mandant_id,
                  a.mutter_art_id,
                  a.wup_id,
                  a.art_id,
                  max(case when trim(a.aktion_thema_gruppe_id) = '' then b.aktion_thema_gruppe_id else a.aktion_thema_gruppe_id end) as aktion_thema_gruppe_id
           from _distinct_aktion_thema2 a
           left join (select mandant_id,
                             mutter_art_id,
                             max(aktion_thema_gruppe_id) as aktion_thema_gruppe_id
                      from _distinct_aktion_thema2
                      group by 1,2) b
             on a.mandant_id = b.mandant_id and
                a.mutter_art_id = b.mutter_art_id
           group by 1,2,3,4) c
  on a.mandant_id = c.mandant_id and
     a.mutter_art_id = c.mutter_art_id and
     a.art_id = c.art_id and
     a.wup_id = c.wup_id
join _distinct_wg2 d
  on a.mandant_id = d.mandant_id and
     a.mutter_art_id = d.mutter_art_id
join _distinct_werbe_kat2 e
  on a.mandant_id = e.mandant_id and
     a.mutter_art_id = e.mutter_art_id
join _distinct_aktionsart2 f
  on a.mandant_id = f.mandant_id and
     a.mutter_art_id = f.mutter_art_id
join _distinct_aktiontyp2 g
  on a.mandant_id = g.mandant_id and
     a.mutter_art_id = g.mutter_art_id
group by all
);

CREATE OR REPLACE VOLATILE TABLE ZZMQ00_avq  (
	art_id	INTEGER, 
	mandant_id	BYTEINT, 
	wup_id	INTEGER, 
	mandant_id0	BYTEINT, 
	werbe_typ_id	BYTEINT, 
	kjwo	INTEGER)
;

INSERT INTO ZZMQ00_avq 
SELECT	a11.art_id  art_id,
	a11.mandant_id  mandant_id,
	a11.wup_id  wup_id,
	a11.mandant_id  mandant_id0,
	a11.werbe_typ_id  werbe_typ_id,
	a11.kjwo  kjwo
FROM	dbp_msi_view_vis.mv_werbung_kennzahlen_woche	a11
	JOIN	dbp_msi_view_vis.mv_wup	a12
	  ON 	(a11.mandant_id = a12.mandant_id AND 
	a11.wup_id = a12.wup_id)
WHERE	(a12.nb_id = 0
 AND (a11.kjwo = $akt_woche OR
      a11.kjwo = $vor_woche OR
     (a11.kjwo = $flg_woche AND
      a11.werbe_typ_id = 3))
 AND a11.art_display_id = 0
 AND (NOT (a11.mandant_id IN (1))
 OR a11.mandant_id IN (1)))
GROUP BY	a11.art_id,
	a11.mandant_id,
	a11.wup_id,
	a11.mandant_id,
	a11.werbe_typ_id,
	a11.kjwo
HAVING	SUM((a11.menge_aktionsstart / NULLIFZERO(NULLIFZERO(a11.faktor_flaki)))) <> 0.0
;

CREATE OR REPLACE VOLATILE TABLE ZZMQ01_avq  (
	art_id	INTEGER, 
	mandant_id	BYTEINT, 
	wup_id	INTEGER, 
	mandant_id0	BYTEINT, 
	werbe_typ_id	BYTEINT, 
	kjwo	INTEGER)
;

INSERT INTO ZZMQ01_avq 
SELECT	a11.art_id  art_id,
	a11.mandant_id  mandant_id,
	a11.wup_id  wup_id,
	a11.mandant_id  mandant_id0,
	a11.werbe_typ_id  werbe_typ_id,
	a11.kjwo  kjwo
FROM	dbp_msi_view_vis.mv_werbung_kennzahlen_woche	a11
	JOIN	dbp_msi_view_vis.mv_wup	a12
	  ON 	(a11.mandant_id = a12.mandant_id AND 
	a11.wup_id = a12.wup_id)
WHERE	(a12.nb_id = 0
 AND (a11.kjwo = $akt_woche OR
      a11.kjwo = $vor_woche OR
     (a11.kjwo = $flg_woche AND
      a11.werbe_typ_id = 3))
 AND a11.art_display_id = 0
 AND (NOT (a11.mandant_id IN (1))
 OR a11.mandant_id IN (1)))
GROUP BY	a11.art_id,
	a11.mandant_id,
	a11.wup_id,
	a11.mandant_id,
	a11.werbe_typ_id,
	a11.kjwo
HAVING	(SUM((a11.menge / NULLIFZERO(NULLIFZERO(a11.faktor_flaki)))) <> 0.0
 OR SUM((a11.menge_we_zentrale / NULLIFZERO(NULLIFZERO(a11.faktor_flaki)))) <> 0.0)

;

CREATE OR REPLACE VOLATILE TABLE ZZMD02_avq  (
	mandant_id	BYTEINT, 
	ROTEMARKIERUNGBEIAVQX	FLOAT, 
	FILTERWARENEINGANGZLBESTANDSTA	FLOAT)
;

INSERT INTO ZZMD02_avq 
SELECT	a11.mandant_id  mandant_id,
	a11.avq_schwellwert  ROTEMARKIERUNGBEIAVQX,
	a11.we_bestand_schwellwert  FILTERWARENEINGANGZLBESTANDSTA
FROM	dbp_msi_view_vis.mv_ts_avq_schwellwert	a11

;

CREATE OR REPLACE VOLATILE TABLE ZZMD03_avq  (
	kjwo	INTEGER, 
	werbe_typ_id	BYTEINT, 
	wup_id	INTEGER, 
	mandant_id	BYTEINT, 
	art_id	INTEGER, 
	mandant_id0	BYTEINT, 
	ABVERKAUFTEMENGEWEBESTANDWERBU	FLOAT, 
	WEZLAKTIONBESTANDSTART	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND01	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND0103	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND04	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND07	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND03	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND05	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND02	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND06	FLOAT, 
	ANZARTIKELXFILIALENXTAGEHILFSM	FLOAT, 
	MINSICHERHEITSBESTAND	FLOAT, 
	EINHEITWB	CHAR(3), 
	BESTANDAKTIONSSTART	FLOAT, 
	VERPACKUNGWB	VARCHAR(3), 
	UMSATZNETTOWERBUNG	FLOAT, 
	ABVERKAUFTEMENGEWERBUNG	FLOAT, 
	ABVERKAUFTEMENGE6WO	FLOAT, 
	ENDBESTAND	FLOAT, 
	ANZAHLNULLBESTNDE	FLOAT, 
	MARKTRESTLAUFZEIT	FLOAT, 
	WJXBFS1	FLOAT, 
	WARENEINGANGZLINAKTION	FLOAT, 
	WARENEINGANGZLVORAKTION	FLOAT, 
	ABVERKAUFTEMENGE01	FLOAT, 
	ABVERKAUFTEMENGE0103	FLOAT, 
	WARENEINGANGZL	FLOAT, 
	UPDATETIMESTAMP	TIMESTAMP, 
	SOLLBESTAND	FLOAT, 
	NULLBESTNDE01TAG	FLOAT, 
	NULLBESTNDE0103TAG	FLOAT)
;

create or replace volatile table _perf_avq as (
select *
from dbp_msi_view_vis.mv_werbung_kennzahlen_woche
where (kjwo = $akt_woche or
       kjwo = $vor_woche or
      (kjwo = $flg_woche and
       werbe_typ_id = 3))
);

INSERT INTO ZZMD03_avq 
SELECT	a11.kjwo  kjwo,
	a11.werbe_typ_id  werbe_typ_id,
	a11.wup_id  wup_id,
	a11.mandant_id  mandant_id,
	a11.art_id  art_id,
	a11.mandant_id  mandant_id0,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTANDWERBU,
	SUM(CASE WHEN a11.mandant_id = 1 THEN a11.menge_we_zentrale / NULLIFZERO(a11.faktor_flaki) ELSE (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki) END)  WEZLAKTIONBESTANDSTART,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge_tag1 * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge_tag1 * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND01,
	SUM(CASE WHEN a11.mandant_id = 1 THEN ((a11.menge_tag1+a11.menge_tag2+a11.menge_tag3) * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE ((a11.menge_tag1+a11.menge_tag2+a11.menge_tag3) * (a11.menge_we_zentrale+a11.menge_aktionsstart)) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale+a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND0103,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge_tag4 * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge_tag4 * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND04,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge_tag7 * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge_tag7 * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND07,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge_tag3 * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge_tag3 * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND03,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge_tag5 * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge_tag5 * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND05,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge_tag2 * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge_tag2 * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND02,
	SUM(CASE WHEN a11.mandant_id = 1 THEN (a11.menge_tag6 * a11.menge_we_zentrale) / NULLIFZERO(a11.faktor_flaki * a11.menge_we_zentrale) ELSE a11.menge_tag6 * (a11.menge_we_zentrale + a11.menge_aktionsstart) / NULLIFZERO(a11.faktor_flaki * (a11.menge_we_zentrale + a11.menge_aktionsstart)) END)  ABVERKAUFTEMENGEWEBESTAND06,
	((COUNT(DISTINCT a11.wup_id) * MAX(a11.anzahl_tage_aktion)) * COUNT(DISTINCT a11.art_id))  ANZARTIKELXFILIALENXTAGEHILFSM,
	SUM(a11.min_sicherh_bestand)  MINSICHERHEITSBESTAND,
	MAX(a11.mwb_basismenge_einh_id)  EINHEITWB,
	SUM((a11.menge_aktionsstart / NULLIFZERO(NULLIFZERO(a11.faktor_flaki))))  BESTANDAKTIONSSTART,
	MAX(a11.mwb_verpart_id)  VERPACKUNGWB,
	SUM(a11.umsatz_netto)  UMSATZNETTOWERBUNG,
	SUM((a11.menge / NULLIFZERO(NULLIFZERO(a11.faktor_flaki))))  ABVERKAUFTEMENGEWERBUNG,
	SUM((a11.menge_historie_af / NULLIFZERO(NULLIFZERO(a11.faktor_flaki))))  ABVERKAUFTEMENGE6WO,
	SUM((a11.menge_endbestand / NULLIFZERO(NULLIFZERO(a11.faktor_flaki))))  ENDBESTAND,
	SUM(a11.anzahl_nullbestand)  ANZAHLNULLBESTNDE,
	SUM((a11.mhd_zeitraum * a11.lager_prozent))  MARKTRESTLAUFZEIT,
	(SUM((a11.menge_endbestand / NULLIFZERO(NULLIFZERO(a11.faktor_flaki)))) - (SUM(a11.min_sicherh_bestand) + SUM(a11.sollbestand)))  WJXBFS1,
	SUM(a11.menge_we)  WARENEINGANGZLINAKTION,
	SUM(a11.we_menge_vor_aktion)  WARENEINGANGZLVORAKTION,
	SUM((a11.menge_tag1 / NULLIFZERO(NULLIFZERO(a11.faktor_flaki))))  ABVERKAUFTEMENGE01,
	SUM((((a11.menge_tag1 + a11.menge_tag2) + a11.menge_tag3) / NULLIFZERO(NULLIFZERO(a11.faktor_flaki))))  ABVERKAUFTEMENGE0103,
	SUM((a11.menge_we_zentrale / NULLIFZERO(NULLIFZERO(a11.faktor_flaki))))  WARENEINGANGZL,
	CURRENT_TIMESTAMP  UPDATETIMESTAMP,
	SUM(a11.sollbestand)  SOLLBESTAND,
	SUM(a11.anzahl_nullbestand_tag1)  NULLBESTNDE01TAG,
	SUM(a11.anzahl_nullbestand_tag1bis3)  NULLBESTNDE0103TAG
FROM	_perf_avq	a11
	JOIN	dbp_msi_view_vis.mv_wup	a12
	  ON 	(a11.mandant_id = a12.mandant_id AND 
	a11.wup_id = a12.wup_id)
WHERE	((a11.mandant_id IN (1)
 OR (a11.art_id,
	a11.mandant_id,
	a11.wup_id,
	a11.mandant_id,
	a11.werbe_typ_id,
	a11.kjwo)
 IN	(((SELECT	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo
	FROM	ZZMQ01_avq	ps21)
 UNION (SELECT	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo
	FROM	ZZMQ00_avq	ps21
		JOIN	dbp_msi_view_vis.mv_wup	s22
		  ON 	(ps21.mandant_id0 = s22.mandant_id AND 
		ps21.wup_id = s22.wup_id)
	WHERE	NOT (s22.mandant_id IN (1))
	GROUP BY	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo))))
 AND a12.nb_id = 0
 AND (a11.kjwo = $akt_woche OR
      a11.kjwo = $vor_woche OR
     (a11.kjwo = $flg_woche AND
      a11.werbe_typ_id = 3))
 AND a11.art_display_id = 0)
GROUP BY	a11.kjwo,
	a11.werbe_typ_id,
	a11.wup_id,
	a11.mandant_id,
	a11.art_id,
	a11.mandant_id

;

CREATE OR REPLACE VOLATILE TABLE ZZMD04_avq  (
	kjwo	INTEGER, 
	werbe_typ_id	BYTEINT, 
	posten_fg	BYTEINT, 
	owg_id	SMALLINT, 
	mandant_id	BYTEINT, 
	art_mutter_wb_id	INTEGER, 
	mandant_id0	BYTEINT, 
	ANZAHLTAGEDERAKTION	INTEGER, 
	ANZAHLARTIKELWERBUNG	INTEGER, 
	ANZAHLFILIALENWERBUNG	INTEGER)
;

INSERT INTO ZZMD04_avq 
SELECT	a11.kjwo  kjwo,
	a11.werbe_typ_id  werbe_typ_id,
	a11.posten_fg  posten_fg,
	a14.owg_id  owg_id,
	a11.mandant_id  mandant_id,
	a11.art_mutter_wb_id  art_mutter_wb_id,
	a11.mandant_id  mandant_id0,
	MAX(a11.anzahl_tage_aktion)  ANZAHLTAGEDERAKTION,
	COUNT(DISTINCT a11.art_id)  ANZAHLARTIKELWERBUNG,
	COUNT(DISTINCT a11.wup_id)  ANZAHLFILIALENWERBUNG
FROM	_perf_avq	a11
	JOIN	dbp_msi_view_vis.mv_wup	a12
	  ON 	(a11.mandant_id = a12.mandant_id AND 
	a11.wup_id = a12.wup_id)
	JOIN	dbp_msi_view_vis.mv_art_wg_zu	a13
	  ON 	(a11.art_id = a13.art_id AND 
	a11.mandant_id = a13.mandant_id)
	JOIN	dbp_msi_view_vis.mv_wg_int	a14
	  ON 	(a13.wg_id = a14.wg_id)
WHERE	((a11.mandant_id IN (1)
 OR (a11.art_id,
	a11.mandant_id,
	a11.wup_id,
	a11.mandant_id,
	a11.werbe_typ_id,
	a11.kjwo)
 IN	(((SELECT	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo
	FROM	ZZMQ01_avq	ps21)
 UNION (SELECT	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo
	FROM	ZZMQ00_avq	ps21
		JOIN	dbp_msi_view_vis.mv_wup	s22
		  ON 	(ps21.mandant_id0 = s22.mandant_id AND 
		ps21.wup_id = s22.wup_id)
	WHERE	NOT (s22.mandant_id IN (1))
	GROUP BY	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo))))
 AND a12.nb_id = 0
 AND (a11.kjwo = $akt_woche OR
      a11.kjwo = $vor_woche OR
     (a11.kjwo = $flg_woche AND
      a11.werbe_typ_id = 3))
 AND a11.art_display_id = 0)
GROUP BY	a11.kjwo,
	a11.werbe_typ_id,
	a11.posten_fg,
	a14.owg_id,
	a11.mandant_id,
	a11.art_mutter_wb_id,
	a11.mandant_id

;

CREATE OR REPLACE VOLATILE TABLE ZZMD05_avq  (
	kjwo	INTEGER, 
	werbe_typ_id	BYTEINT, 
	posten_fg	BYTEINT, 
	mandant_id	BYTEINT, 
	art_mutter_wb_id	INTEGER, 
	mandant_id0	BYTEINT, 
	abt_id	SMALLINT, 
	ANZAHLFILIALENWERBUNGFRHILFSME	INTEGER)
;

INSERT INTO ZZMD05_avq 
SELECT	a11.kjwo  kjwo,
	a11.werbe_typ_id  werbe_typ_id,
	a11.posten_fg  posten_fg,
	a11.mandant_id  mandant_id,
	a11.art_mutter_wb_id  art_mutter_wb_id,
	a11.mandant_id  mandant_id0,
	a15.abt_id  abt_id,
	COUNT(DISTINCT a11.wup_id)  ANZAHLFILIALENWERBUNGFRHILFSME
FROM	_perf_avq	a11
	JOIN	dbp_msi_view_vis.mv_art_wg_zu	a12
	  ON 	(a11.art_id = a12.art_id AND 
	a11.mandant_id = a12.mandant_id)
	JOIN	dbp_msi_view_vis.mv_wg_int	a13
	  ON 	(a12.wg_id = a13.wg_id)
	JOIN	dbp_msi_view_vis.mv_owg_int	a14
	  ON 	(a13.owg_id = a14.owg_id)
	JOIN	dbp_msi_view_vis.mv_hwg_int	a15
	  ON 	(a14.hwg_id = a15.hwg_id)
	JOIN	dbp_msi_view_vis.mv_wup	a16
	  ON 	(a11.mandant_id = a16.mandant_id AND 
	a11.wup_id = a16.wup_id)
WHERE	((a11.mandant_id IN (1)
 OR (a11.art_id,
	a11.mandant_id,
	a11.wup_id,
	a11.mandant_id,
	a11.werbe_typ_id,
	a11.kjwo)
 IN	(((SELECT	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo
	FROM	ZZMQ01_avq	ps21)
 UNION (SELECT	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo
	FROM	ZZMQ00_avq	ps21
		JOIN	dbp_msi_view_vis.mv_wup	s22
		  ON 	(ps21.mandant_id0 = s22.mandant_id AND 
		ps21.wup_id = s22.wup_id)
	WHERE	NOT (s22.mandant_id IN (1))
	GROUP BY	ps21.art_id,
		ps21.mandant_id,
		ps21.wup_id,
		ps21.mandant_id0,
		ps21.werbe_typ_id,
		ps21.kjwo))))
 AND a16.nb_id = 0
 AND (a11.kjwo = $akt_woche OR
      a11.kjwo = $vor_woche OR
     (a11.kjwo = $flg_woche AND
      a11.werbe_typ_id = 3))
 AND a11.art_display_id = 0)
GROUP BY	a11.kjwo,
	a11.werbe_typ_id,
	a11.posten_fg,
	a11.mandant_id,
	a11.art_mutter_wb_id,
	a11.mandant_id,
	a15.abt_id

;

CREATE OR REPLACE VOLATILE TABLE ZZMD06_avq  (
	mandant_id	BYTEINT, 
	AKTUALISIERUNGSDATUM	TIMESTAMP)
;

INSERT INTO ZZMD06_avq 
SELECT	a12.mandant_id  mandant_id,
	MAX(a11.dat_letzte_aktualisierung)  AKTUALISIERUNGSDATUM
FROM	dbp_msi_view_vis.mv_avq_aktualisierung	a11
	CROSS JOIN	dbp_msi_view_vis.mv_mandant	a12
GROUP BY	a12.mandant_id

;

CREATE OR REPLACE VOLATILE TABLE ZZMD07_avq  (
	art_id	INTEGER, 
	mandant_id	BYTEINT, 
	kl_art_nr	CHAR(8), 
	wup_id	INTEGER, 
	mandant_id0	BYTEINT, 
	mandant_id1	BYTEINT, 
	mandant_sort_id	BYTEINT, 
	vs_id	BYTEINT, 
	mandant_id2	BYTEINT, 
	werbe_typ_id	BYTEINT, 
	sort_id	INTEGER, 
	ww_von_bis	VARCHAR(35)	COLLATE 'en-cs', 
	kjwo	INTEGER, 
	wo_von_bis	VARCHAR(20), 
	kjwo_bez	VARCHAR(30), 
	akt_wo	SMALLINT, 
	wo_kj	INTEGER, 
	abt_id	SMALLINT, 
	sort_id0	INTEGER, 
	posten_fg	BYTEINT, 
	art_mutter_wb_id	INTEGER, 
	mandant_id3	BYTEINT, 
	wg_id	SMALLINT, 
	sort_id1	INTEGER, 
	vkl_id	INTEGER, 
	mandant_id4	BYTEINT, 
	vkl_sort	VARCHAR(40)	COLLATE 'en-cs', 
	ROTEMARKIERUNGBEIAVQX	FLOAT, 
	ABVERKAUFTEMENGEPERANZAHLTAGEH	FLOAT, 
	ANZARTIKELXFILIALENXTAGEHILFSM	FLOAT, 
	FILTERWARENEINGANGZLBESTANDSTA	FLOAT, 
	MINSICHERHEITSBESTAND	FLOAT, 
	ANZAHLFILIALENHILFSMETRIK	FLOAT, 
	EINHEITWB	CHAR(3), 
	BESTANDAKTIONSSTART	FLOAT, 
	VERPACKUNGWB	VARCHAR(3), 
	ABVERKAUFTEMENGEWEBESTANDWERBU	FLOAT, 
	UMSATZNETTOWERBUNG	FLOAT, 
	ABVERKAUFTEMENGEWERBUNG	FLOAT, 
	ABVERKAUFTEMENGE6WO	FLOAT, 
	ENDBESTAND	FLOAT, 
	ANZAHLNULLBESTNDE	FLOAT, 
	ANZAHLTAGEDERAKTION	INTEGER, 
	MARKTRESTLAUFZEIT	FLOAT, 
	BERBESTAND	FLOAT, 
	WARENEINGANGZLINAKTION	FLOAT, 
	WEZLAKTIONBESTANDSTART	FLOAT, 
	WARENEINGANGZLVORAKTION	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND01	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND0103	FLOAT, 
	ABVERKAUFTEMENGE01	FLOAT, 
	ABVERKAUFTEMENGE0103	FLOAT, 
	ANZAHLARTIKELWERBUNG	INTEGER, 
	ANZAHLFILIALENWERBUNG	INTEGER, 
	LFDNRMENGE	FLOAT, 
	WARENEINGANGZL	FLOAT, 
	AKTUALISIERUNGSDATUM	TIMESTAMP, 
	UPDATETIMESTAMP	TIMESTAMP, 
	ABVERKAUFTEMENGEWEBESTAND04	FLOAT, 
	SOLLBESTAND	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND07	FLOAT, 
	NULLBESTNDE01TAG	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND03	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND05	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND02	FLOAT, 
	ABVERKAUFTEMENGEWEBESTAND06	FLOAT, 
	NULLBESTNDE0103TAG	FLOAT)
;

INSERT INTO ZZMD07_avq 
SELECT	pa12.art_id  art_id,
	pa12.mandant_id0  mandant_id,
	MAX(a114.kl_art_nr)  kl_art_nr,
	pa12.wup_id  wup_id,
	pa12.mandant_id  mandant_id0,
	a13.mandant_id  mandant_id1,
	MAX(a119.mandant_sort_id)  mandant_sort_id,
	CASE WHEN a13.mandant_id=1 AND a13.vs_id=7 THEN 11 WHEN a13.mandant_id=1 AND a13.vs_id=2 THEN 12 WHEN a13.mandant_id=1 AND a13.vs_id=3 THEN 13 WHEN a13.mandant_id=1 AND a13.vs_id=1 THEN 14 WHEN a13.mandant_id=1 AND a13.vs_id=8 THEN 15 WHEN a13.mandant_id=1 AND a13.vs_id=6 THEN 16 WHEN a13.mandant_id=2 AND a13.vs_id=1 THEN 21 WHEN a13.mandant_id=2 AND a13.vs_id=2 THEN 22 ELSE a13.mandant_id*10+9 END  vs_id,
	a13.mandant_id  mandant_id2,
	pa12.werbe_typ_id  werbe_typ_id,
	MAX(a115.werbe_typ_id)  sort_id,
	a113.ww_von_bis  ww_von_bis,
	pa12.kjwo  kjwo,
	MAX(a116.wo_von_bis)  wo_von_bis,
	MAX((TRIM(a116.kj, ' ') || ' ' || a116.wo_von_bis))  kjwo_bez,
	MAX(a116.akt_wo)  akt_wo,
	MAX(a116.wo_kj)  wo_kj,
	a110.abt_id  abt_id,
	MAX(a118.sort_id)  sort_id0,
	a15.posten_fg  posten_fg,
	a15.art_mutter_wb_id  art_mutter_wb_id,
	a15.mandant_id  mandant_id3,
	a16.wg_id  wg_id,
	MAX(a17.sort_id)  sort_id1,
	a13.vkl_id  vkl_id,
	a13.mandant_id  mandant_id4,
	MAX(CASE WHEN a117.vkl_id < 0 THEN 'ZZZ' || a117.vkl_id ELSE a117.ma_name END)  vkl_sort,
	MAX(pa14.ROTEMARKIERUNGBEIAVQX)  ROTEMARKIERUNGBEIAVQX,
	ZEROIFNULL((MAX(pa12.ABVERKAUFTEMENGEWEBESTANDWERBU) / NULLIFZERO(MAX(pa18.ANZAHLTAGEDERAKTION))))  ABVERKAUFTEMENGEPERANZAHLTAGEH,
	MAX(pa12.ANZARTIKELXFILIALENXTAGEHILFSM)  ANZARTIKELXFILIALENXTAGEHILFSM,
	MAX(pa14.FILTERWARENEINGANGZLBESTANDSTA)  FILTERWARENEINGANGZLBESTANDSTA,
	MAX(pa12.MINSICHERHEITSBESTAND)  MINSICHERHEITSBESTAND,
	ZEROIFNULL(((MAX(pa111.ANZAHLFILIALENWERBUNGFRHILFSME) * MAX(pa18.ANZAHLTAGEDERAKTION)) / NULLIFZERO(MAX(pa18.ANZAHLTAGEDERAKTION))))  ANZAHLFILIALENHILFSMETRIK,
	MAX(pa12.EINHEITWB)  EINHEITWB,
	MAX(pa12.BESTANDAKTIONSSTART)  BESTANDAKTIONSSTART,
	MAX(pa12.VERPACKUNGWB)  VERPACKUNGWB,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTANDWERBU)  ABVERKAUFTEMENGEWEBESTANDWERBU,
	MAX(pa12.UMSATZNETTOWERBUNG)  UMSATZNETTOWERBUNG,
	MAX(pa12.ABVERKAUFTEMENGEWERBUNG)  ABVERKAUFTEMENGEWERBUNG,
	MAX(pa12.ABVERKAUFTEMENGE6WO)  ABVERKAUFTEMENGE6WO,
	MAX(pa12.ENDBESTAND)  ENDBESTAND,
	MAX(pa12.ANZAHLNULLBESTNDE)  ANZAHLNULLBESTNDE,
	MAX(pa18.ANZAHLTAGEDERAKTION)  ANZAHLTAGEDERAKTION,
	MAX(pa12.MARKTRESTLAUFZEIT)  MARKTRESTLAUFZEIT,
	(CASE WHEN MAX(pa12.WJXBFS1) < 0 THEN 0 ELSE MAX(pa12.WJXBFS1) end)  BERBESTAND,
	MAX(pa12.WARENEINGANGZLINAKTION)  WARENEINGANGZLINAKTION,
	MAX(pa12.WEZLAKTIONBESTANDSTART)  WEZLAKTIONBESTANDSTART,
	MAX(pa12.WARENEINGANGZLVORAKTION)  WARENEINGANGZLVORAKTION,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND01)  ABVERKAUFTEMENGEWEBESTAND01,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND0103)  ABVERKAUFTEMENGEWEBESTAND0103,
	MAX(pa12.ABVERKAUFTEMENGE01)  ABVERKAUFTEMENGE01,
	MAX(pa12.ABVERKAUFTEMENGE0103)  ABVERKAUFTEMENGE0103,
	MAX(pa18.ANZAHLARTIKELWERBUNG)  ANZAHLARTIKELWERBUNG,
	MAX(pa18.ANZAHLFILIALENWERBUNG)  ANZAHLFILIALENWERBUNG,
	RANK() OVER ( PARTITION BY pa12.kjwo, pa12.werbe_typ_id, CASE WHEN a13.mandant_id=1 AND a13.vs_id=7 THEN 11 WHEN a13.mandant_id=1 AND a13.vs_id=2 THEN 12 WHEN a13.mandant_id=1 AND a13.vs_id=3 THEN 13 WHEN a13.mandant_id=1 AND a13.vs_id=1 THEN 14 WHEN a13.mandant_id=1 AND a13.vs_id=8 THEN 15 WHEN a13.mandant_id=1 AND a13.vs_id=6 THEN 16 WHEN a13.mandant_id=2 AND a13.vs_id=1 THEN 21 WHEN a13.mandant_id=2 AND a13.vs_id=2 THEN 22 ELSE a13.mandant_id*10+9 END, a13.mandant_id, a13.mandant_id ORDER BY MAX(a119.mandant_sort_id) ASC, MAX(a116.akt_wo) ASC, pa12.kjwo ASC, MAX((TRIM(a116.kj, ' ') || ' ' || a116.wo_von_bis)) DESC, MAX(a116.wo_kj) ASC, MAX(a116.wo_von_bis) DESC, pa12.werbe_typ_id ASC, MAX(a115.werbe_typ_id) ASC, CASE WHEN a13.mandant_id=1 AND a13.vs_id=7 THEN 11 WHEN a13.mandant_id=1 AND a13.vs_id=2 THEN 12 WHEN a13.mandant_id=1 AND a13.vs_id=3 THEN 13 WHEN a13.mandant_id=1 AND a13.vs_id=1 THEN 14 WHEN a13.mandant_id=1 AND a13.vs_id=8 THEN 15 WHEN a13.mandant_id=1 AND a13.vs_id=6 THEN 16 WHEN a13.mandant_id=2 AND a13.vs_id=1 THEN 21 WHEN a13.mandant_id=2 AND a13.vs_id=2 THEN 22 ELSE a13.mandant_id*10+9 END ASC, MAX(a118.sort_id) ASC, a15.posten_fg DESC, MAX(ZEROIFNULL((pa12.ABVERKAUFTEMENGEWERBUNG / NULLIFZERO(((pa111.ANZAHLFILIALENWERBUNGFRHILFSME * pa18.ANZAHLTAGEDERAKTION) / NULLIFZERO(pa18.ANZAHLTAGEDERAKTION)))))) ASC, a15.art_mutter_wb_id ASC, a15.mandant_id ASC, MAX(a114.kl_art_nr) ASC, MAX(a17.sort_id) ASC, MAX(CASE WHEN a117.vkl_id < 0 THEN 'ZZZ' || a117.vkl_id ELSE a117.ma_name END) ASC )  LFDNRMENGE,
	MAX(pa12.WARENEINGANGZL)  WARENEINGANGZL,
	MAX(pa112.AKTUALISIERUNGSDATUM)  AKTUALISIERUNGSDATUM,
	MAX(pa12.UPDATETIMESTAMP)  UPDATETIMESTAMP,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND04)  ABVERKAUFTEMENGEWEBESTAND04,
	MAX(pa12.SOLLBESTAND)  SOLLBESTAND,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND07)  ABVERKAUFTEMENGEWEBESTAND07,
	MAX(pa12.NULLBESTNDE01TAG)  NULLBESTNDE01TAG,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND03)  ABVERKAUFTEMENGEWEBESTAND03,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND05)  ABVERKAUFTEMENGEWEBESTAND05,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND02)  ABVERKAUFTEMENGEWEBESTAND02,
	MAX(pa12.ABVERKAUFTEMENGEWEBESTAND06)  ABVERKAUFTEMENGEWEBESTAND06,
	MAX(pa12.NULLBESTNDE0103TAG)  NULLBESTNDE0103TAG
FROM	ZZMD03_avq	pa12
	JOIN	dbp_msi_view_vis.mv_wup	a13
	  ON 	(pa12.mandant_id = a13.mandant_id AND 
	pa12.wup_id = a13.wup_id)
	LEFT OUTER JOIN	ZZMD02_avq	pa14
	  ON 	(a13.mandant_id = pa14.mandant_id)
	JOIN	dbp_msi_view_vis.mv_art_mutter_wb	a15
	  ON 	(pa12.art_id = a15.art_id AND 
	pa12.mandant_id0 = a15.mandant_id)
	JOIN	dbp_msi_view_vis.mv_art_wg_zu	a16
	  ON 	(pa12.art_id = a16.art_id AND 
	pa12.mandant_id0 = a16.mandant_id)
	JOIN	dbp_msi_view_vis.mv_wg_int	a17
	  ON 	(a16.wg_id = a17.wg_id)
	LEFT OUTER JOIN	ZZMD04_avq	pa18
	  ON 	(a13.mandant_id = pa18.mandant_id AND 
	a15.art_mutter_wb_id = pa18.art_mutter_wb_id AND 
	a15.mandant_id = pa18.mandant_id0 AND 
	a15.posten_fg = pa18.posten_fg AND 
	a17.owg_id = pa18.owg_id AND 
	pa12.kjwo = pa18.kjwo AND 
	pa12.werbe_typ_id = pa18.werbe_typ_id)
	JOIN	dbp_msi_view_vis.mv_owg_int	a19
	  ON 	(a17.owg_id = a19.owg_id)
	JOIN	dbp_msi_view_vis.mv_hwg_int	a110
	  ON 	(a19.hwg_id = a110.hwg_id)
	LEFT OUTER JOIN	ZZMD05_avq	pa111
	  ON 	(a110.abt_id = pa111.abt_id AND 
	a13.mandant_id = pa111.mandant_id AND 
	a15.art_mutter_wb_id = pa111.art_mutter_wb_id AND 
	a15.mandant_id = pa111.mandant_id0 AND 
	a15.posten_fg = pa111.posten_fg AND 
	pa12.kjwo = pa111.kjwo AND 
	pa12.werbe_typ_id = pa111.werbe_typ_id)
	LEFT OUTER JOIN	ZZMD06_avq	pa112
	  ON 	(a13.mandant_id = pa112.mandant_id)
	JOIN	dbp_msi_view_vis.mv_werbe_woche	a113
	  ON 	(pa12.kjwo = a113.kjwo AND 
	pa12.werbe_typ_id = a113.werbe_typ_id)
	JOIN	dbp_msi_view_vis.mv_art	a114
	  ON 	(a13.mandant_id = a114.mandant_id AND 
	pa12.art_id = a114.art_id AND 
	pa12.mandant_id0 = a114.mandant_id)
	JOIN	dbp_msi_view_vis.mv_l_werbe_typ	a115
	  ON 	(pa12.werbe_typ_id = a115.werbe_typ_id)
	JOIN	dbp_msi_view_vis.mv_woche	a116
	  ON 	(pa12.kjwo = a116.kjwo)
	JOIN	dbp_msi_view_vis.mv_vkl	a117
	  ON 	(a13.mandant_id = a117.mandant_id AND 
	a13.vkl_id = a117.vkl_id)
	JOIN	dbp_msi_view_vis.mv_abt_int	a118
	  ON 	(a110.abt_id = a118.abt_id)
	JOIN	dbp_msi_view_vis.mv_mandant	a119
	  ON 	(a115.mandant_id = a119.mandant_id AND 
	a13.mandant_id = a119.mandant_id)
GROUP BY	pa12.art_id,
	pa12.mandant_id0,
	pa12.wup_id,
	pa12.mandant_id,
	a13.mandant_id,
	CASE WHEN a13.mandant_id=1 AND a13.vs_id=7 THEN 11 WHEN a13.mandant_id=1 AND a13.vs_id=2 THEN 12 WHEN a13.mandant_id=1 AND a13.vs_id=3 THEN 13 WHEN a13.mandant_id=1 AND a13.vs_id=1 THEN 14 WHEN a13.mandant_id=1 AND a13.vs_id=8 THEN 15 WHEN a13.mandant_id=1 AND a13.vs_id=6 THEN 16 WHEN a13.mandant_id=2 AND a13.vs_id=1 THEN 21 WHEN a13.mandant_id=2 AND a13.vs_id=2 THEN 22 ELSE a13.mandant_id*10+9 END,
	a13.mandant_id,
	pa12.werbe_typ_id,
	a113.ww_von_bis,
	pa12.kjwo,
	a110.abt_id,
	a15.posten_fg,
	a15.art_mutter_wb_id,
	a15.mandant_id,
	a16.wg_id,
	a13.vkl_id,
	a13.mandant_id

;

CREATE OR REPLACE VOLATILE TABLE ZZMD08_avq  (
	art_id	INTEGER, 
	mandant_id	BYTEINT)
;

INSERT INTO ZZMD08_avq 
SELECT	pa11.art_id  art_id,
	pa11.mandant_id  mandant_id
FROM	ZZMD07_avq	pa11
GROUP BY	pa11.art_id,
	pa11.mandant_id

;


CREATE OR REPLACE VOLATILE TABLE ZZMD09_avq  (
	abt_id	SMALLINT, 
	sort_id	INTEGER, 
	abt_bez_BG	VARCHAR(100)	COLLATE 'en-cs', 
	abt_bez_CZ	VARCHAR(100)	COLLATE 'en-cs', 
	abt_bez	VARCHAR(100)	COLLATE 'en-cs', 
	abt_bez_PL	VARCHAR(100)	COLLATE 'en-cs', 
	abt_bez_RO	VARCHAR(100)	COLLATE 'en-cs', 
	abt_bez_HR	VARCHAR(100)	COLLATE 'en-cs', 
	abt_bez_SK	VARCHAR(100)	COLLATE 'en-cs', 
	art_id	INTEGER, 
	mandant_id	BYTEINT, 
	art_bez_BG	VARCHAR(50)	COLLATE 'en-cs', 
	art_bez_CZ	VARCHAR(50)	COLLATE 'en-cs', 
	art_bez	VARCHAR(50)	COLLATE 'en-cs', 
	art_bez_PL	VARCHAR(50)	COLLATE 'en-cs', 
	art_bez_RO	VARCHAR(50)	COLLATE 'en-cs', 
	art_bez_HR	VARCHAR(50)	COLLATE 'en-cs', 
	art_bez_SK	VARCHAR(50)	COLLATE 'en-cs', 
	kl_art_nr	CHAR(8), 
	art_mutter_wb_id	INTEGER, 
	mandant_id0	BYTEINT, 
	art_mutter_wb_bez	VARCHAR(50)	COLLATE 'en-cs', 
	art_mutter_wb_fg	BYTEINT, 
	art_mutter_wb_nr	CHAR(8), 
	art_mutter_bezugsweg_id	BYTEINT, 
	bezugsweg_bez	VARCHAR(30)	COLLATE 'en-cs', 
	art_display_id	BYTEINT, 
	owg_id	SMALLINT, 
	owg_bez_BG	VARCHAR(100)	COLLATE 'en-cs', 
	owg_bez_CZ	VARCHAR(100)	COLLATE 'en-cs', 
	owg_bez	VARCHAR(100)	COLLATE 'en-cs', 
	owg_bez_PL	VARCHAR(100)	COLLATE 'en-cs', 
	owg_bez_RO	VARCHAR(100)	COLLATE 'en-cs', 
	owg_bez_HR	VARCHAR(100)	COLLATE 'en-cs', 
	owg_bez_SK	VARCHAR(100)	COLLATE 'en-cs', 
	posten_fg	BYTEINT, 
	posten_fg_desc	VARCHAR(30), 
	saison_id	CHAR(4), 
	mandant_id1	BYTEINT, 
	saison_bez_BG	VARCHAR(30)	COLLATE 'en-cs', 
	saison_bez_CZ	VARCHAR(30)	COLLATE 'en-cs', 
	saison_bez	VARCHAR(30)	COLLATE 'en-cs', 
	saison_bez_PL	VARCHAR(30)	COLLATE 'en-cs', 
	saison_bez_RO	VARCHAR(30)	COLLATE 'en-cs', 
	saison_bez_HR	VARCHAR(30)	COLLATE 'en-cs', 
	saison_bez_SK	VARCHAR(30)	COLLATE 'en-cs', 
	wg_id	SMALLINT, 
	wg_bez_BG	VARCHAR(100)	COLLATE 'en-cs', 
	wg_bez_CZ	VARCHAR(100)	COLLATE 'en-cs', 
	wg_bez	VARCHAR(100)	COLLATE 'en-cs', 
	wg_bez_PL	VARCHAR(100)	COLLATE 'en-cs', 
	wg_bez_RO	VARCHAR(100)	COLLATE 'en-cs', 
	wg_bez_HR	VARCHAR(100)	COLLATE 'en-cs', 
	wg_bez_SK	VARCHAR(100)	COLLATE 'en-cs', 
	sort_id1	INTEGER)
;

create or replace volatile table _p1 as (
select *
from dbp_msi_view_vis.mv_art_wg_zu
where (mandant_id,art_id) in (select mandant_id,art_id from ZZMD08_avq)
);

create or replace volatile table _p2 as (
select *
from dbp_msi_view_vis.mv_art_mutter_wb
where (mandant_id,art_id) in (select mandant_id,art_id from ZZMD08_avq)  and
       art_mutter_wb_nr <> '-00000000'
);

create or replace volatile table _p3 as (
select *
from dbp_msi_view_vis.mv_art_spr_zu
where (mandant_id,art_id) in (select mandant_id,art_id from ZZMD08_avq)
);

create or replace volatile table _p4 as (
select *
from dbp_msi_view_vis.mv_art
where (mandant_id,art_id) in (select mandant_id,art_id from ZZMD08_avq)
);

INSERT INTO ZZMD09_avq 
SELECT	a15.abt_id  abt_id,
	MAX(a115.sort_id)  sort_id,
	MAX(a116.abt_bez_BG)  abt_bez_BG,
	MAX(a116.abt_bez_CZ)  abt_bez_CZ,
	MAX(a116.abt_bez)  abt_bez,
	MAX(a116.abt_bez_PL)  abt_bez_PL,
	MAX(a116.abt_bez_RO)  abt_bez_RO,
	MAX(a116.abt_bez_HR)  abt_bez_HR,
	MAX(a116.abt_bez_SK)  abt_bez_SK,
	pa11.art_id  art_id,
	pa11.mandant_id  mandant_id,
	MAX(a18.art_bez_BG)  art_bez_BG,
	MAX(a18.art_bez_CZ)  art_bez_CZ,
	MAX(a18.art_bez)  art_bez,
	MAX(a18.art_bez_PL)  art_bez_PL,
	MAX(a18.art_bez_RO)  art_bez_RO,
	MAX(a18.art_bez_HR)  art_bez_HR,
	MAX(a18.art_bez_SK)  art_bez_SK,
	MAX(a19.kl_art_nr)  kl_art_nr,
	a16.art_mutter_wb_id  art_mutter_wb_id,
	a16.mandant_id  mandant_id0,
	MAX(a16.art_mutter_wb_bez)  art_mutter_wb_bez,
	MAX(a16.art_mutter_wb_fg)  art_mutter_wb_fg,
	MAX(a16.art_mutter_wb_nr)  art_mutter_wb_nr,
	a17.art_mutter_bezugsweg_id  art_mutter_bezugsweg_id,
	MAX(a113.bezugsweg_bez)  bezugsweg_bez,
	a16.art_mutter_display_id  art_display_id,
	a13.owg_id  owg_id,
	MAX(a114.owg_bez_BG)  owg_bez_BG,
	MAX(a114.owg_bez_CZ)  owg_bez_CZ,
	MAX(a114.owg_bez)  owg_bez,
	MAX(a114.owg_bez_PL)  owg_bez_PL,
	MAX(a114.owg_bez_RO)  owg_bez_RO,
	MAX(a114.owg_bez_HR)  owg_bez_HR,
	MAX(a114.owg_bez_SK)  owg_bez_SK,
	a16.posten_fg  posten_fg,
	MAX(CASE WHEN a16.posten_fg=1 THEN 'Posten & Promotion' WHEN a16.posten_fg=0 THEN 'Sortiment' end)  posten_fg_desc,
	a16.art_mutter_saison_id  saison_id,
	a110.mandant_id  mandant_id1,
	MAX(a111.saison_bez_BG)  saison_bez_BG,
	MAX(a111.saison_bez_CZ)  saison_bez_CZ,
	MAX(a111.saison_bez)  saison_bez,
	MAX(a111.saison_bez_PL)  saison_bez_PL,
	MAX(a111.saison_bez_RO)  saison_bez_RO,
	MAX(a111.saison_bez_HR)  saison_bez_HR,
	MAX(a111.saison_bez_SK)  saison_bez_SK,
	a12.wg_id  wg_id,
	MAX(a112.wg_bez_BG)  wg_bez_BG,
	MAX(a112.wg_bez_CZ)  wg_bez_CZ,
	MAX(a112.wg_bez)  wg_bez,
	MAX(a112.wg_bez_PL)  wg_bez_PL,
	MAX(a112.wg_bez_RO)  wg_bez_RO,
	MAX(a112.wg_bez_HR)  wg_bez_HR,
	MAX(a112.wg_bez_SK)  wg_bez_SK,
	MAX(a13.sort_id)  sort_id1
FROM	ZZMD08_avq	pa11
	JOIN	_p1 a12
	  ON 	(pa11.art_id = a12.art_id AND 
	pa11.mandant_id = a12.mandant_id)
	JOIN	dbp_msi_view_vis.mv_wg_int	a13
	  ON 	(a12.wg_id = a13.wg_id)
	JOIN	dbp_msi_view_vis.mv_owg_int	a14
	  ON 	(a13.owg_id = a14.owg_id)
	JOIN	dbp_msi_view_vis.mv_hwg_int	a15
	  ON 	(a14.hwg_id = a15.hwg_id)
	JOIN	_p2 a16
	  ON 	(pa11.art_id = a16.art_id AND 
	pa11.mandant_id = a16.mandant_id)
	JOIN	dbp_msi_view_vis.mv_art_mutter_bezugsweg_wup	a17
	  ON 	(a12.mandant_id = a17.mandant_id AND 
	a16.art_mutter_wb_id = a17.art_mutter_wb_id AND 
	a16.mandant_id = a17.mandant_id)
	JOIN	_p3 a18
	  ON 	(a12.mandant_id = a18.mandant_id AND 
	pa11.art_id = a18.art_id AND 
	pa11.mandant_id = a18.mandant_id)
	JOIN	_p4 a19
	  ON 	(a12.mandant_id = a19.mandant_id AND 
	pa11.art_id = a19.art_id AND 
	pa11.mandant_id = a19.mandant_id)
	JOIN	dbp_msi_view_vis.mv_l_saison	a110
	  ON 	(a12.mandant_id = a110.mandant_id AND 
	a16.art_mutter_saison_id = a110.saison_id)
	JOIN	dbp_msi_view_vis.mv_saison_spr_zu	a111
	  ON 	(a110.mandant_id = a111.mandant_id AND 
	a16.art_mutter_saison_id = a111.saison_id)
	JOIN	dbp_msi_view_vis.mv_wg_int_spr_zu	a112
	  ON 	(a12.wg_id = a112.wg_id)
	JOIN	dbp_msi_view_vis.mv_bezugsweg_spr_zu	a113
	  ON 	(a17.art_mutter_bezugsweg_id = a113.bezugsweg_id)
	JOIN	dbp_msi_view_vis.mv_owg_int_spr_zu	a114
	  ON 	(a13.owg_id = a114.owg_id)
	JOIN	dbp_msi_view_vis.mv_abt_int	a115
	  ON 	(a15.abt_id = a115.abt_id)
	JOIN	dbp_msi_view_vis.mv_abt_int_spr_zu	a116
	  ON 	(a15.abt_id = a116.abt_id)
GROUP BY	a15.abt_id,
	pa11.art_id,
	pa11.mandant_id,
	a16.art_mutter_wb_id,
	a16.mandant_id,
	a17.art_mutter_bezugsweg_id,
	a16.art_mutter_display_id,
	a13.owg_id,
	a16.posten_fg,
	a16.art_mutter_saison_id,
	a110.mandant_id,
	a12.wg_id
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0A_avq  (
	wup_id	INTEGER, 
	mandant_id	BYTEINT)
;

INSERT INTO ZZMD0A_avq 
SELECT	pa11.wup_id  wup_id,
	pa11.mandant_id0  mandant_id
FROM	ZZMD07_avq	pa11
GROUP BY	pa11.wup_id,
	pa11.mandant_id0

;

CREATE OR REPLACE VOLATILE TABLE ZZMD0B_avq  (
	wup_id	INTEGER, 
	mandant_id	BYTEINT, 
	wup_standort	VARCHAR(40)	COLLATE 'en-cs', 
	gf_id	INTEGER, 
	mandant_id0	BYTEINT, 
	gf_name_BG	VARCHAR(40)	COLLATE 'en-cs', 
	gf_name_CZ	VARCHAR(40)	COLLATE 'en-cs', 
	gf_name	VARCHAR(40)	COLLATE 'en-cs', 
	gf_name_PL	VARCHAR(40)	COLLATE 'en-cs', 
	gf_name_RO	VARCHAR(40)	COLLATE 'en-cs', 
	gf_name_HR	VARCHAR(40)	COLLATE 'en-cs', 
	gf_name_SK	VARCHAR(40)	COLLATE 'en-cs', 
	mandant_id1	BYTEINT, 
	mandant_bez	VARCHAR(40), 
	mandant_sort_id	BYTEINT, 
	vs_id	BYTEINT, 
	mandant_id2	BYTEINT, 
	vs_bez	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_id	INTEGER, 
	mandant_id3	BYTEINT, 
	vkl_name_BG	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_name_CZ	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_name	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_name_PL	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_name_RO	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_name_HR	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_name_SK	VARCHAR(40)	COLLATE 'en-cs', 
	vkl_sort	VARCHAR(40)	COLLATE 'en-cs')
;

INSERT INTO ZZMD0B_avq 
SELECT	pa11.wup_id  wup_id,
	pa11.mandant_id  mandant_id,
	MAX(a12.wup_standort)  wup_standort,
	a12.gf_id  gf_id,
	a12.mandant_id  mandant_id0,
	MAX(TRIM(a13.ma_name_BG) || ' ' || TRIM(a13.ma_vorname_BG))  gf_name_BG,
	MAX(TRIM(a13.ma_name_CZ) || ' ' || TRIM(a13.ma_vorname_CZ))  gf_name_CZ,
	MAX(TRIM(a13.ma_name) || ' ' || TRIM(a13.ma_vorname))  gf_name,
	MAX(TRIM(a13.ma_name_PL) || ' ' || TRIM(a13.ma_vorname_PL))  gf_name_PL,
	MAX(TRIM(a13.ma_name_RO) || ' ' || TRIM(a13.ma_vorname_RO))  gf_name_RO,
	MAX(TRIM(a13.ma_name_HR) || ' ' || TRIM(a13.ma_vorname_HR))  gf_name_HR,
	MAX(TRIM(a13.ma_name_SK) || ' ' || TRIM(a13.ma_vorname_SK))  gf_name_SK,
	a12.mandant_id  mandant_id1,
	MAX(a16.mandant_bez)  mandant_bez,
	MAX(a16.mandant_sort_id)  mandant_sort_id,
	CASE WHEN a12.mandant_id=1 AND a12.vs_id=7 THEN 11 WHEN a12.mandant_id=1 AND a12.vs_id=2 THEN 12 WHEN a12.mandant_id=1 AND a12.vs_id=3 THEN 13 WHEN a12.mandant_id=1 AND a12.vs_id=1 THEN 14 WHEN a12.mandant_id=1 AND a12.vs_id=8 THEN 15 WHEN a12.mandant_id=1 AND a12.vs_id=6 THEN 16 WHEN a12.mandant_id=2 AND a12.vs_id=1 THEN 21 WHEN a12.mandant_id=2 AND a12.vs_id=2 THEN 22 ELSE a12.mandant_id*10+9 END  vs_id,
	a12.mandant_id  mandant_id2,
	MAX(a14.vsvt_bez)  vs_bez,
	a12.vkl_id  vkl_id,
	a12.mandant_id  mandant_id3,
	MAX(TRIM(a15.ma_name_BG) || ' ' || TRIM(a15.ma_vorname_BG))  vkl_name_BG,
	MAX(TRIM(a15.ma_name_CZ) || ' ' || TRIM(a15.ma_vorname_CZ))  vkl_name_CZ,
	MAX(TRIM(a15.ma_name) || ' ' || TRIM(a15.ma_vorname))  vkl_name,
	MAX(TRIM(a15.ma_name_PL) || ' ' || TRIM(a15.ma_vorname_PL))  vkl_name_PL,
	MAX(TRIM(a15.ma_name_RO) || ' ' || TRIM(a15.ma_vorname_RO))  vkl_name_RO,
	MAX(TRIM(a15.ma_name_HR) || ' ' || TRIM(a15.ma_vorname_HR))  vkl_name_HR,
	MAX(TRIM(a15.ma_name_SK) || ' ' || TRIM(a15.ma_vorname_SK))  vkl_name_SK,
	MAX(CASE WHEN a15.vkl_id < 0 THEN 'ZZZ' || a15.vkl_id ELSE a15.ma_name END)  vkl_sort
FROM	ZZMD0A_avq	pa11
	JOIN	dbp_msi_view_vis.mv_wup	a12
	  ON 	(pa11.mandant_id = a12.mandant_id AND 
	pa11.wup_id = a12.wup_id)
	JOIN	dbp_msi_view_vis.mv_gf	a13
	  ON 	(a12.gf_id = a13.gf_id AND 
	a12.mandant_id = a13.mandant_id)
	JOIN	dbp_msi_view_vis.mv_vs	a14
	  ON 	(CASE WHEN a12.mandant_id=1 AND a12.vs_id=7 THEN 11 WHEN a12.mandant_id=1 AND a12.vs_id=2 THEN 12 WHEN a12.mandant_id=1 AND a12.vs_id=3 THEN 13 WHEN a12.mandant_id=1 AND a12.vs_id=1 THEN 14 WHEN a12.mandant_id=1 AND a12.vs_id=8 THEN 15 WHEN a12.mandant_id=1 AND a12.vs_id=6 THEN 16 WHEN a12.mandant_id=2 AND a12.vs_id=1 THEN 21 WHEN a12.mandant_id=2 AND a12.vs_id=2 THEN 22 ELSE a12.mandant_id*10+9 END = CASE WHEN a14.mandant_id=1 AND a14.vs_id=7 THEN 11 WHEN a14.mandant_id=1 AND a14.vs_id=2 THEN 12 WHEN a14.mandant_id=1 AND a14.vs_id=3 THEN 13 WHEN a14.mandant_id=1 AND a14.vs_id=1 THEN 14 WHEN a14.mandant_id=1 AND a14.vs_id=8 THEN 15 WHEN a14.mandant_id=1 AND a14.vs_id=6 THEN 16 WHEN a14.mandant_id=2 AND a14.vs_id=1 THEN 21 WHEN a14.mandant_id=2 AND a14.vs_id=2 THEN 22 ELSE a14.mandant_id*10+9 END AND 
	a12.mandant_id = a14.mandant_id)
	JOIN	dbp_msi_view_vis.mv_vkl	a15
	  ON 	(a12.mandant_id = a15.mandant_id AND 
	a12.vkl_id = a15.vkl_id)
	JOIN	dbp_msi_view_vis.mv_mandant	a16
	  ON 	(a12.mandant_id = a16.mandant_id)
GROUP BY	pa11.wup_id,
	pa11.mandant_id,
	a12.gf_id,
	a12.mandant_id,
	a12.mandant_id,
	CASE WHEN a12.mandant_id=1 AND a12.vs_id=7 THEN 11 WHEN a12.mandant_id=1 AND a12.vs_id=2 THEN 12 WHEN a12.mandant_id=1 AND a12.vs_id=3 THEN 13 WHEN a12.mandant_id=1 AND a12.vs_id=1 THEN 14 WHEN a12.mandant_id=1 AND a12.vs_id=8 THEN 15 WHEN a12.mandant_id=1 AND a12.vs_id=6 THEN 16 WHEN a12.mandant_id=2 AND a12.vs_id=1 THEN 21 WHEN a12.mandant_id=2 AND a12.vs_id=2 THEN 22 ELSE a12.mandant_id*10+9 END,
	a12.mandant_id,
	a12.vkl_id,
	a12.mandant_id

;

CREATE OR REPLACE VOLATILE TABLE ZZMD0C_avq  (
	werbe_typ_id	BYTEINT)
;

INSERT INTO ZZMD0C_avq 
SELECT	pa11.werbe_typ_id  werbe_typ_id
FROM	ZZMD07_avq	pa11
GROUP BY	pa11.werbe_typ_id

;

CREATE OR REPLACE VOLATILE TABLE ZZMD0D_avq  (
	kjwo	INTEGER)
;

INSERT INTO ZZMD0D_avq 
SELECT	pa11.kjwo  kjwo
FROM	ZZMD07_avq	pa11
GROUP BY	pa11.kjwo

;

CREATE OR REPLACE VOLATILE TABLE ZZMD0E_avq  (
	ww_von_bis	VARCHAR(35)	COLLATE 'en-cs')
;

INSERT INTO ZZMD0E_avq 
SELECT	pa11.ww_von_bis  ww_von_bis
FROM	ZZMD07_avq	pa11
GROUP BY	pa11.ww_von_bis

;

CREATE OR REPLACE VOLATILE TABLE _avq AS (
SELECT	pa11.art_id  art_id,
	pa11.mandant_id  mandant_id,
	pa11.kl_art_nr  kl_art_nr,
	pa11.wup_id  wup_id,
	pa11.mandant_id0  mandant_id0,
	pa11.mandant_id1  mandant_id1,
	pa11.mandant_sort_id  mandant_sort_id,
	pa11.vs_id  vs_id,
	pa11.mandant_id2  mandant_id2,
	pa11.werbe_typ_id  werbe_typ_id,
	pa11.sort_id  sort_id,
	pa11.ww_von_bis  ww_von_bis,
	pa11.kjwo  kjwo,
	pa11.wo_von_bis  wo_von_bis,
	pa11.kjwo_bez  kjwo_bez,
	pa11.akt_wo  akt_wo,
	pa11.wo_kj  wo_kj,
	pa11.abt_id  abt_id,
	pa11.sort_id0  sort_id0,
	pa11.posten_fg  posten_fg,
	pa11.art_mutter_wb_id  art_mutter_wb_id,
	pa11.mandant_id3  mandant_id3,
	pa11.wg_id  wg_id,
	pa11.sort_id1  sort_id1,
	pa11.vkl_id  vkl_id,
	pa11.mandant_id4  mandant_id4,
	pa11.vkl_sort  vkl_sort,
	pa11.ROTEMARKIERUNGBEIAVQX  WJXBFS1,
	pa11.ABVERKAUFTEMENGEPERANZAHLTAGEH  WJXBFS2,
	pa11.ANZARTIKELXFILIALENXTAGEHILFSM  WJXBFS3,
	pa11.FILTERWARENEINGANGZLBESTANDSTA  WJXBFS4,
	pa11.MINSICHERHEITSBESTAND  WJXBFS5,
	pa11.ANZAHLFILIALENHILFSMETRIK  WJXBFS6,
	pa11.EINHEITWB  WJXBFS7,
	pa11.BESTANDAKTIONSSTART  WJXBFS8,
	pa11.VERPACKUNGWB  WJXBFS9,
	pa11.ABVERKAUFTEMENGEWEBESTANDWERBU  WJXBFSa,
	pa11.UMSATZNETTOWERBUNG  WJXBFSb,
	pa11.ABVERKAUFTEMENGEWERBUNG  WJXBFSc,
	pa11.ABVERKAUFTEMENGE6WO  WJXBFSd,
	pa11.ENDBESTAND  WJXBFSe,
	pa11.ANZAHLNULLBESTNDE  WJXBFSf,
	pa11.ANZAHLTAGEDERAKTION  WJXBFS10,
	pa11.MARKTRESTLAUFZEIT  WJXBFS11,
	pa11.BERBESTAND  WJXBFS12,
	pa11.WARENEINGANGZLINAKTION  WJXBFS13,
	pa11.WEZLAKTIONBESTANDSTART  WJXBFS14,
	pa11.WARENEINGANGZLVORAKTION  WJXBFS15,
	pa11.ABVERKAUFTEMENGEWEBESTAND01  WJXBFS16,
	pa11.ABVERKAUFTEMENGEWEBESTAND0103  WJXBFS17,
	pa11.ABVERKAUFTEMENGE01  WJXBFS18,
	pa11.ABVERKAUFTEMENGE0103  WJXBFS19,
	pa11.ANZAHLARTIKELWERBUNG  WJXBFS1a,
	pa11.ANZAHLFILIALENWERBUNG  WJXBFS1b,
	pa11.LFDNRMENGE  WJXBFS1c,
	pa11.WARENEINGANGZL  WJXBFS1d,
	pa11.AKTUALISIERUNGSDATUM  WJXBFS1e,
	pa11.UPDATETIMESTAMP  WJXBFS1f,
	pa11.ABVERKAUFTEMENGEWEBESTAND04  WJXBFS20,
	pa11.SOLLBESTAND  WJXBFS21,
	pa11.ABVERKAUFTEMENGEWEBESTAND07  WJXBFS22,
	pa11.NULLBESTNDE01TAG  WJXBFS23,
	pa11.ABVERKAUFTEMENGEWEBESTAND03  WJXBFS24,
	pa11.ABVERKAUFTEMENGEWEBESTAND05  WJXBFS25,
	pa11.ABVERKAUFTEMENGEWEBESTAND02  WJXBFS26,
	pa11.ABVERKAUFTEMENGEWEBESTAND06  WJXBFS27,
	pa11.NULLBESTNDE0103TAG  WJXBFS28
FROM	ZZMD07_avq	pa11
);

CREATE OR REPLACE VOLATILE TABLE _avq_snap AS (
SELECT mandant_id,
       kjwo,
       art_mutter_wb_id,
       SUM(WJXBFS16) / (SUM(WJXBFS1d))*100 AS avq_1,
       SUM(WJXBFS17) / (SUM(WJXBFS1d))*100 AS avq_3,
       SUM(WJXBFS27+WJXBFS26+WJXBFS25+WJXBFS24+WJXBFS22+WJXBFS20+WJXBFS16) / (SUM(WJXBFS1d))*100 AS avq,
       SUM(WJXBFS1d) AS wareneingang_zl,
       SUM(WJXBFSa) AS abverkaufte_menge_bestand,
       SUM(WJXBFSc) AS abverkaufte_menge,
       SUM(WJXBFSc)/NULLIFZERO(COUNT(DISTINCT wup_id)) AS durchschnitt_menge_pro_filiale,
       MAX(WJXBFS7) AS einheit_wb,
       SUM(WJXBFSb) AS umsatz_netto,
       SUM(WJXBFSb)/NULLIFZERO(COUNT(DISTINCT wup_id)) AS durchschnitt_umsatz_pro_artikel_pro_filiale,
       SUM(0) AS anz_nullbestand,
       CAST(SUM(0) AS DECIMAL(18,4)) AS nullbestandsquote,
       SUM(WJXBFSe) AS endbestand,
       SUM(WJXBFSe)/NULLIFZERO(SUM(WJXBFSd)) AS umschlagsquote,
       COUNT(DISTINCT art_id) AS anz_artikel,
       COUNT(DISTINCT wup_id) AS anz_filialen
FROM _avq
WHERE (kjwo = $akt_woche OR
       kjwo = $vor_woche OR
      (kjwo = $flg_woche AND
       werbe_typ_id = 3)) AND
       mandant_id = 1
GROUP BY 1,2,3
having SUM(WJXBFS1d) <> 0
);

insert into _avq_snap
SELECT mandant_id,
       kjwo,
       art_mutter_wb_id,
       SUM(WJXBFS16) AS avq_1,
       SUM(WJXBFS17) AS avq_3,
       SUM(WJXBFS27+WJXBFS26+WJXBFS25+WJXBFS24+WJXBFS22+WJXBFS20+WJXBFS16) AS avq,
       SUM(WJXBFS1d) AS wareneingang_zl,
       SUM(WJXBFSa) AS abverkaufte_menge_bestand,
       SUM(WJXBFSc) AS abverkaufte_menge,
       SUM(WJXBFSc)/NULLIFZERO(COUNT(DISTINCT wup_id)) AS durchschnitt_menge_pro_filiale,
       MAX(WJXBFS7) AS einheit_wb,
       SUM(WJXBFSb) AS umsatz_netto,
       SUM(WJXBFSb)/NULLIFZERO(COUNT(DISTINCT wup_id)) AS durchschnitt_umsatz_pro_artikel_pro_filiale,
       SUM(0) AS anz_nullbestand,
       CAST(SUM(0) AS DECIMAL(18,4)) AS nullbestandsquote,
       SUM(WJXBFSe) AS endbestand,
       SUM(WJXBFSe)/NULLIFZERO(SUM(WJXBFSd)) AS umschlagsquote,
       COUNT(DISTINCT art_id) AS anz_artikel,
       COUNT(DISTINCT wup_id) AS anz_filialen
FROM _avq
WHERE (kjwo = $akt_woche OR
       kjwo = $vor_woche OR
      (kjwo = $flg_woche AND
       werbe_typ_id = 3)) AND
       mandant_id = 1
GROUP BY 1,2,3
having SUM(WJXBFS1d) = 0
;

CREATE OR REPLACE VOLATILE TABLE _avq_nb AS (
SELECT mandant_id,
       kjwo,
       mutter_wb_id,
       CAST(SUM(anzahl_nullbestand) AS DECIMAL(18,4)) AS anzahl_nullbestand,
       CAST(SUM(anzahl_nullbestand*1.0000)/NULLIFZERO(((COUNT(DISTINCT wup_id) * MAX(anzahl_tage_aktion)) * COUNT(DISTINCT art_id))*1.0000)*100.0000 AS DECIMAL(18,4)) AS nullbestandsquote
FROM dbp_data.werbung_kennzahlen_woche
WHERE ((mandant_id = 1 AND (menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7) <> 0) OR 
       (mandant_id = 1 AND we_menge_zentral <> 0)) AND
      (kjwo = $akt_woche OR
       kjwo = $vor_woche OR
      (kjwo = $flg_woche AND
       werbe_typ_id = 3))
GROUP BY 1,2,3
);

update _avq_snap 
set nullbestandsquote = b.nullbestandsquote,
    anz_nullbestand = b.anzahl_nullbestand

from (select *
      from _avq_nb) b
      
where _avq_snap.mandant_id = b.mandant_id and
      _avq_snap.art_mutter_wb_id = b.mutter_wb_id and
      _avq_snap.kjwo = b.kjwo
;

create or replace volatile table _avq_snap2 as (
select a.mandant_id,
       case when a.kjwo = $flg_woche then $akt_woche else a.kjwo end as kjwo_,
       a.art_mutter_wb_id,
       a.avq_1,
       a.avq_3,
       a.avq,
       a.wareneingang_zl,
       a.abverkaufte_menge_bestand,
       a.abverkaufte_menge,
       a.durchschnitt_menge_pro_filiale,
       a.einheit_wb,
       a.umsatz_netto,
       a.durchschnitt_umsatz_pro_artikel_pro_filiale,
       a.anz_nullbestand,
       a.nullbestandsquote,
       a.endbestand,
       a.umschlagsquote,
       a.anz_artikel,
       a.anz_filialen
from _avq_snap a
qualify row_number() over (partition by a.mandant_id,kjwo_,a.art_mutter_wb_id order by a.avq desc) = 1
);

create or replace volatile table _artbew_avq as (
select a.*,
       b.avq_1,
       b.avq_3,
       b.avq,
       b.wareneingang_zl,
       b.abverkaufte_menge_bestand,
       b.abverkaufte_menge,
       b.durchschnitt_menge_pro_filiale,
       b.einheit_wb,
       b.umsatz_netto,
       b.durchschnitt_umsatz_pro_artikel_pro_filiale,
       b.anz_nullbestand,
       b.nullbestandsquote,
       b.endbestand,
       b.umschlagsquote,
       b.anz_artikel,
       b.anz_filialen
from _artbew4 a
left join _avq_snap2 b
  on a.mandant_id = b.mandant_id and
     a.mutter_art_id = b.art_mutter_wb_id and
     a.kjwo = b.kjwo_
);

create or replace volatile table _shopper1 as (
select mandant_id,
       art_id_werbung,
       sum(anz_kaeufer_af)  anz_kaeufer_af,
       sum(ums_netto_baseline_af)  ums_netto_baseline_af,
       sum(ertrag_baseline_af)  ertrag_baseline_af,
       sum(menge_baseline_af)  menge_baseline_af,
       sum(menge_sa)  menge_sa,
       sum(anz_bon_aktion)  anz_bon_aktion,
       sum(anz_tage_baseline_af)  anz_tage_baseline_af,
       sum(ertrag_sa)  ertrag_sa,
       sum(anz_tage_sa)  anz_tage_sa,
       sum(anz_bon_sa)  anz_bon_sa,
       sum(anz_bon_af)  anz_bon_af,
       sum(ums_netto_sa)  ums_netto_sa,
       sum(anz_cp_kaeufer) anz_cp_kaeufer,
       sum(anz_cp_kaeufer_70_prozent) anz_cp_kaeufer_70_prozent,
       sum(ums_gesamt_af_mit_wv) ums_gesamt_af_mit_wv,
       sum(ums_gesamt_ausser_artikel) ums_gesamt_ausser_artikel,
       sum(anz_markt_sa) anz_markt_sa
from dbp_data.shopper
where kjwo_werbe_ende = $akt_woche and
       mandant_id = 1 and
       baseline = 1
group by 1,2
);

create or replace volatile table _shopper_snap as (
select mandant_id,
       art_id_werbung,
       sum(ums_netto_baseline_af)/nullifzero(sum(anz_tage_baseline_af)) as umsatz_baseline,
       sum(ums_netto_sa)/nullifzero(sum(anz_tage_sa)) as umsatz_werbewoche,
       umsatz_werbewoche-umsatz_baseline as umsatz_uplift,
       sum(menge_baseline_af)/nullifzero(sum(anz_tage_baseline_af)) as absatz_baseline,
       sum(menge_sa)/nullifzero(sum(anz_tage_sa)) as absatz_werbewoche,
       absatz_werbewoche-absatz_baseline as absatz_uplift,
       sum(ertrag_baseline_af)/nullifzero(sum(anz_tage_baseline_af)) as ertrag_baseline,
       sum(ertrag_sa)/nullifzero(sum(anz_tage_sa)) as ertrag_werbewoche,
       ertrag_werbewoche-ertrag_baseline as ertrag_uplift,
       round((sum(anz_kaeufer_af)/nullifzero(sum(anz_tage_baseline_af)))+0.5,0) as kaeufer_baseline,
       round((sum(anz_bon_sa)/nullifzero(sum(anz_tage_sa)))+0.5,0) as kaeufer_werbewoche,
       kaeufer_werbewoche-kaeufer_baseline as kaeufer_uplift,
       cast(sum(anz_kaeufer_af*1.0000)/nullifzero(sum(anz_bon_af*1.0000))*100.00 as decimal(9,2)) as kaeufer_reichweite_baseline,
       cast(sum(anz_bon_sa*1.0000)/nullifzero(sum(anz_bon_aktion*1.0000))*100.00 as decimal(9,2)) as kaeufer_reichweite_werbewoche,
       kaeufer_reichweite_werbewoche-kaeufer_reichweite_baseline as kaeufer_reichweite_uplift,
       cast(sum(anz_cp_kaeufer_70_prozent*1.0000)/nullifzero(sum(anz_cp_kaeufer*1.0000))*100.00 as decimal(9,2)) as cherrypicker_pp,
       sum(ums_gesamt_af_mit_wv)/nullifzero(sum(anz_cp_kaeufer)) as restbon_normalware,
       sum(ums_gesamt_ausser_artikel)/nullifzero(sum(anz_cp_kaeufer)) as restbon_gesamt,
       restbon_gesamt-restbon_normalware as restbon_tip,
       sum(ums_gesamt_af_mit_wv)/nullifzero(sum(anz_tage_sa)) as ums_aktivierter_normalpreis,
       sum(anz_tage_sa) as anz_tage_sa,
       sum(anz_markt_sa) as anz_markt_sa,
       52 as baseline_wochen
from _shopper1
group by 1,2
);

create or replace volatile table _artbew_avq_shopper as (
select a.*,
       b.umsatz_baseline,
       b.umsatz_werbewoche,
       b.umsatz_uplift,
       b.absatz_baseline,
       b.absatz_werbewoche,
       b.absatz_uplift,
       b.ertrag_baseline,
       b.ertrag_werbewoche,
       b.ertrag_uplift,
       b.kaeufer_baseline,
       b.kaeufer_werbewoche,
       b.kaeufer_uplift,
       b.kaeufer_reichweite_baseline,
       b.kaeufer_reichweite_werbewoche,
       b.kaeufer_reichweite_uplift,
       b.cherrypicker_pp,
       b.restbon_normalware,
       b.restbon_gesamt,
       b.restbon_tip,
       b.ums_aktivierter_normalpreis,
       b.anz_tage_sa,
       b.anz_markt_sa,
       b.baseline_wochen
from _artbew_avq a
left join _shopper_snap b
  on a.mandant_id = b.mandant_id and
     a.mutter_art_id = b.art_id_werbung
);

delete from dbp_data.aktionsmanagement
where kjwo_ww = $akt_woche
;

insert into dbp_data.aktionsmanagement (mandant_id
                                        ,kjwo_ww
                                        ,kjwo
                                        ,mutter_wb_id
                                        ,konkat_kind_art_id
                                        ,konkat_aktion_thema_gruppe_id
                                        ,konkat_werbe_kat_id
                                        ,gp_id
                                        ,aktionsart_id_liste_txt
                                        ,aktionsart_bez_liste_txt
                                        ,aktion_typ_id_liste_txt
                                        ,aktion_typ_bez_liste_txt
                                        ,konkat_wg_id
                                        ,umsatz_netto_sa_west
                                        ,absatz_sa_west
                                        ,ek_mep_sa_west
                                        ,rohertrag_ek_mep_olk_sa_west
                                        ,spanne_ek_mep_olk_sa_west
                                        ,preisvorteil_west
                                        ,umsatz_netto_sa_ost
                                        ,absatz_sa_ost
                                        ,ek_mep_sa_ost
                                        ,rohertrag_ek_mep_olk_sa_ost
                                        ,spanne_ek_mep_olk_sa_ost
                                        ,preisvorteil_ost
                                        ,umsatz_netto_sa_sued
                                        ,absatz_sa_sued
                                        ,ek_mep_sa_sued
                                        ,rohertrag_ek_mep_olk_sa_sued
                                        ,spanne_ek_mep_olk_sa_sued
                                        ,preisvorteil_sued
                                        ,umsatz_netto_sa
                                        ,absatz_sa
                                        ,ek_mep_sa
                                        ,rohertrag_sa
                                        ,spanne_sa
                                        ,preisvorteil
                                        ,avq_1
                                        ,avq_3
                                        ,avq
                                        ,wareneingang_zl
                                        ,abverkaufte_menge_bestand
                                        ,abverkaufte_menge
                                        ,durchschnitt_menge_pro_filiale
                                        ,einheit_wb
                                        ,umsatz_netto
                                        ,durchschnitt_umsatz_pro_artike
                                        ,anz_nullbestand
                                        ,nullbestandsquote
                                        ,endbestand
                                        ,umschlagsquote
                                        ,anz_artikel
                                        ,anz_filialen
                                        ,umsatz_baseline
                                        ,umsatz_werbewoche
                                        ,umsatz_uplift
                                        ,umsatz_aktivierter_normalpreis
                                        ,absatz_baseline
                                        ,absatz_werbewoche
                                        ,absatz_uplift
                                        ,ertrag_baseline
                                        ,ertrag_werbewoche
                                        ,ertrag_uplift
                                        ,kaeufer_baseline
                                        ,kaeufer_werbewoche
                                        ,kaeufer_uplift
                                        ,kaeufer_reichweite_baseline
                                        ,kaeufer_reichweite_werbewoche
                                        ,kaeufer_reichweite_uplift
                                        ,cherrypicker_pp
                                        ,restbon_normalware
                                        ,restbon_gesamt
                                        ,restbon_tip
                                        ,anz_tage_sa
                                        ,anz_markt_sa
                                        ,baseline_wochen
                                        --- neu ---
                                        ,wa_kalk_nach_pv_sa
                                        ,wa_kalk_nach_pv_sa_sued
                                        ,wa_kalk_nach_pv_sa_ost
                                        ,wa_kalk_nach_pv_sa_west
                                        ,spanne_wa_kalk_nach_pv_sa
                                        ,spanne_wa_kalk_nach_pv_sa_sued
                                        ,spanne_wa_kalk_nach_pv_sa_ost
                                        ,spanne_wa_kalk_nach_pv_sa_west
                                        ,wa_kalk_nach_pv_sa_loy
                                        ,wa_kalk_nach_pv_sa_aktion_loy
                                        ,wa_kalk_nach_pv_sa_bby_loy
                                        ,wa_kalk_nach_pv_sa_kdn_bby_loy
                                        ,wa_kalk_nach_pv_sa_kdp_bby_loy
                                        ,wa_kalk_nach_pv_sa_non_loy
                                        ,wa_kalk_nach_pv_sa_aktion_non_loy
                                        ,wa_kalk_nach_pv_sa_bby_non_loy
                                        ,spanne_wa_kalk_nach_pv_sa_loy
                                        ,spanne_wa_kalk_nach_pv_sa_aktion_loy
                                        ,spanne_wa_kalk_nach_pv_sa_bby_loy
                                        ,spanne_wa_kalk_nach_pv_sa_kdn_bby_loy
                                        ,spanne_wa_kalk_nach_pv_sa_kdp_bby_loy
                                        ,spanne_wa_kalk_nach_pv_sa_non_loy
                                        ,spanne_wa_kalk_nach_pv_sa_aktion_non_loy
                                        ,spanne_wa_kalk_nach_pv_sa_bby_non_loy
                                        ,umsatz_netto_sa_aktion_non_loy
                                        ,umsatz_netto_sa_bby_non_loy
                                        ,umsatz_netto_sa_aktion_loy
                                        ,umsatz_netto_sa_bby_loy
                                        ,umsatz_netto_sa_kdn_bby_loy
                                        ,umsatz_netto_sa_kdp_bby_loy
                                        ,menge_sa_aktion_non_loy
                                        ,menge_sa_bby_non_loy
                                        ,menge_sa_aktion_loy
                                        ,menge_sa_bby_loy
                                        ,menge_sa_kdn_bby_loy
                                        ,menge_sa_kdp_bby_loy
                                        ,pv_aktion_loy
                                        ,pv_bby_loy
                                        ,pv_kdn_bby
                                        ,pv_kdp_bby
                                        ,pv_aktion_non_loy
                                        ,pv_bby_non_loy)
select mandant_id
      ,kjwo_ww
      ,kjwo
      ,mutter_art_id
      ,substr(kl_art_id,1,500)
      ,aktion_thema_gruppe_id
      ,werbe_kat_id
      ,gp_id
      ,aktionsart_id_liste_txt
      ,aktionsart_bez_liste_txt
      ,aktion_typ_id_liste_txt
      ,aktion_typ_bez_liste_txt
      ,wg_id
      ,umsatz_netto_sa_west_
      ,absatz_sa_west_
      ,ek_mep_sa_west_
      ,rohertrag_sa_west_
      ,spanne_sa_west_
      ,preisvorteil_west
      ,umsatz_netto_sa_ost_
      ,absatz_sa_ost_
      ,ek_mep_sa_ost_
      ,rohertrag_sa_ost_
      ,spanne_sa_ost_
      ,preisvorteil_ost
      ,umsatz_netto_sa_sued_
      ,absatz_sa_sued_
      ,ek_mep_sa_sued_
      ,rohertrag_sa_sued_
      ,spanne_sa_sued_
      ,preisvorteil_sued
      ,umsatz_netto_sa_
      ,absatz_sa_
      ,ek_mep_sa_
      ,rohertrag_sa_
      ,spanne_sa_
      ,preisvorteil
      ,avq_1
      ,avq_3
      ,avq
      ,wareneingang_zl
      ,abverkaufte_menge_bestand
      ,abverkaufte_menge
      ,durchschnitt_menge_pro_filiale
      ,einheit_wb
      ,umsatz_netto
      ,durchschnitt_umsatz_pro_artikel_pro_filiale
      ,anz_nullbestand
      ,nullbestandsquote
      ,endbestand
      ,umschlagsquote
      ,anz_artikel
      ,anz_filialen
      ,umsatz_baseline
      ,umsatz_werbewoche
      ,umsatz_uplift
      ,ums_aktivierter_normalpreis
      ,absatz_baseline
      ,absatz_werbewoche
      ,absatz_uplift
      ,ertrag_baseline
      ,ertrag_werbewoche
      ,ertrag_uplift
      ,kaeufer_baseline
      ,kaeufer_werbewoche
      ,kaeufer_uplift
      ,kaeufer_reichweite_baseline
      ,kaeufer_reichweite_werbewoche
      ,kaeufer_reichweite_uplift
      ,cherrypicker_pp
      ,restbon_normalware
      ,restbon_gesamt
      ,restbon_tip
      ,anz_tage_sa
      ,anz_markt_sa
      ,baseline_wochen
      --- neu ---
      ,wa_kalk_nach_pv_sa_
      ,wa_kalk_nach_pv_sa_sued_
      ,wa_kalk_nach_pv_sa_ost_
      ,wa_kalk_nach_pv_sa_west_
      ,spanne_wa_kalk_nach_pv_sa_
      ,spanne_wa_kalk_nach_pv_sa_sued_
      ,spanne_wa_kalk_nach_pv_sa_ost_
      ,spanne_wa_kalk_nach_pv_sa_west_
      ,wa_kalk_nach_pv_sa_loyalty_
      ,wa_kalk_nach_pv_sa_aktion_loyalty_
      ,wa_kalk_nach_pv_sa_bby_loyalty_
      ,wa_kalk_nach_pv_sa_kdn_bby_loyalty_
      ,wa_kalk_nach_pv_sa_kdp_bby_loyalty_
      ,wa_kalk_nach_pv_sa_non_loyalty_
      ,wa_kalk_nach_pv_sa_aktion_non_loyalty_
      ,wa_kalk_nach_pv_sa_bby_non_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_aktion_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_bby_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_non_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty_
      ,spanne_wa_kalk_nach_pv_sa_bby_non_loyalty_
      ,umsatz_netto_sa_aktion_non_loyalty_
      ,umsatz_netto_sa_bby_non_loyalty_      
      ,umsatz_netto_sa_aktion_loyalty_
      ,umsatz_netto_sa_bby_loyalty_      
      ,umsatz_netto_sa_kdn_bby_loyalty_
      ,umsatz_netto_sa_kdp_bby_loyalty_
      ,absatz_sa_aktion_non_loyalty_
      ,absatz_sa_bby_non_loyalty_
      ,absatz_sa_aktion_loyalty_
      ,absatz_sa_bby_loyalty_
      ,absatz_sa_kdn_bby_loyalty_
      ,absatz_sa_kdp_bby_loyalty_
      ,pv_aktion_loy
      ,pv_bby_loy
      ,pv_kdn_bby
      ,pv_kdp_bby
      ,pv_aktion_non_loy
      ,pv_bby_non_loy
from _artbew_avq_shopper
;

--update dbp_data.aktionsmanagement set konkat_aktion_thema_gruppe_id = '';
--update dbp_data.aktionsmanagement from (select a.mandant_id
--                                              ,c.art_id
--                                              ,b.kjwo_ww
--                                              ,max(a.aktion_thema_id) as aktion_thema_id
--                                        from dbp_etl_process.bon_aktion_thema_group a
--                                        join dbp_data.werbewoche_kl b
--                                          on a.bon_dat = b.dat
--                                        join dbp_data.art c
--                                          on a.mandant_id = c.mandant_id and
--                                             a.kl_art_id = c.kl_art_id and
--                                             c.dat_bis = '9999-12-31'
--                                        group by 1,2,3) b
--                              
--set konkat_aktion_thema_gruppe_id = b.aktion_thema_id
--
--where dbp_data.aktionsmanagement.mandant_id = b.mandant_id and
--      dbp_data.aktionsmanagement.mutter_wb_id = b.art_id and
--      dbp_data.aktionsmanagement.kjwo_ww = b.kjwo_ww
--;

update dbp_data.aktionsmanagement set konkat_werbeteam_cd = coalesce(konkat_werbeteam_cd,'-1'),
                                      konkat_werbeteam_bez = coalesce(konkat_werbeteam_bez,'-1'),
                                      werbebereich_cd = coalesce(werbebereich_cd,'-1')
;
