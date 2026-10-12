-- 14.08.2025, -dba-
--
-- Taegliches Update fuer loyalty_berechtigt_fg.

update dbp_ods.ods_bon_kopf_2 set loyalty_berechtigt_fg = 0
where bon_dat >= '2025-03-01' and
      loyalty_berechtigt_fg is null
;

update dbp_ods.ods_bon_kopf_2 set loyalty_berechtigt_fg = 1
where bon_dat >= '2025-03-01' and
      kundenkarte_typ_id = 2 and 
     (kundenkarte_status_bez is null or
      kundenkarte_status_bez = '') and
     (kundenkarte_fehler_txt is null or
      kundenkarte_fehler_txt = '') and
     (loyalty_berechtigt_fg is null or
      loyalty_berechtigt_fg = 0)
;

update dbp_ods.ods_promotion_2 set betrag_promo_brutto = betrag_promo_brutto * -1
where betrag_promo_brutto < 0 and
      umsatz_promo_brutto > 0 and
      menge_promo > 0 and
      bon_dat between current_date-180 and current_date
;

delete from dbp_etl_process.wup_fg_2;
insert into dbp_etl_process.wup_fg_2 (mandant_id,
                                    wup_id,
                                    nb_id,
                                    dat,
                                    wup_bereinigt_fg)
select x.mandant_id,
       x.wup_id,
       x.nb_id,
       x.dat,
       x.wup_bereinigt_fg
from (select b.mandant_id
            ,b.wup_id
            ,b.nb_id
            ,a.dat
            ,coalesce(b.dat_eroeffnung_alt,'9999-12-31') as _dat_eroeffnung_alt
            ,coalesce(b.dat_eroeffnung,'9999-12-31') as _dat_eroeffnung
            ,case
               when (((_dat_eroeffnung_alt < a.kjwo_kl_dat_von-364 or
                       _dat_eroeffnung < a.kjwo_kl_dat_von-364) and
                       a.kjwo_kl_dat_bis < b.dat_bis) or b.umzugsfiliale_fg = 1)
               then 1
               else 0
             end as wup_bereinigt_fg
      from dbp_data.tag_2 a
      join dbp_data.wup_2 b
        on 1 = 1
      where a.dat <= current_date) x
;

create or replace table dbp_etl.artbew_wg_wechsel_tmp_2 (
  mandant_id byteint not null
 ,art_id integer not null
 ,arthiertyp_id byteint not null
 ,alt_neu_kz byteint not null
 ,wg_id smallint not null
 ,wg_art_fg byteint
 ,unique (mandant_id,art_id,arthiertyp_id,alt_neu_kz)
);
                                                                                                                                        
create table if not exists dbp_etl.vis_tag_bestand_wg_wechsel_log_2 (
  mandant_id byteint not null
 ,art_id integer not null
 ,arthiertyp_id byteint not null
 ,wg_id smallint not null
 ,unique (mandant_id,art_id)
);

create table if not exists dbp_etl.vis_monat_best_wg_wechsel_log_2 (
  mandant_id byteint not null
 ,art_id integer not null
 ,arthiertyp_id byteint not null
 ,wg_id smallint not null
 ,unique (mandant_id,art_id)
);

create or replace table dbp_etl.artbew_wg_wechsel_join_2 (
  mandant_id byteint not null
 ,art_id integer not null
 ,arthiertyp_id byteint not null
 ,dat date not null
 ,alt_neu_kz byteint not null
 ,wg_id smallint not null
 ,wg_art_fg byteint
);

create or replace table dbp_etl.artbew_wg_sum_tmp_2 (
  mandant_id byteint not null ,
  wup_id integer not null,
  nb_id smallint not null ,
  wg_id integer not null,
  arthiertyp_id smallint not null ,
  dat date,
  bewart_id smallint not null ,
  posten_id char(2) collate 'en-cs' not null default '  ' ,
  menge decimal(18,4),
  menge_ohne_wg_erf_art decimal(18,4),
  umsatz_netto decimal(18,4),
  diff_umsatz_netto_konz decimal(18,4) ,
  umsatz_mwst_betrag decimal(18,4),
  diff_umsatz_mwst_betrag_konz decimal(18,4) ,
  ek_brutto decimal(18,4),
  diff_ek_brutto_konz decimal(18,4) ,
  ek_netto decimal(18,4),
  diff_ek_netto_konz decimal(18,4) ,
  ek_nettonetto decimal(18,4),
  diff_ek_nettonetto_konz decimal(18,4) ,
  ek_kal_basis decimal(18,4),
  diff_ek_kal_basis_konz decimal(18,4) ,
  ek_mep decimal(18,4),
  diff_ek_mep_konz decimal(18,4) ,
  einstandspreis decimal(18,4),
  diff_einstandspreis_konz decimal(18,4) ,
  logkostenzuschlag decimal(18,4) ,
  diff_logkostenzuschlag_konz decimal(18,4) ,
  ek_netto_bnk decimal(18,4),
  diff_ek_netto_bnk_konz decimal(18,4) ,
  ek_netto_bnk_sachk decimal(18,4),
  diff_ek_netto_bnk_sachk_konz decimal(18,4)
);

insert into dbp_etl.artbew_wg_wechsel_tmp_2 (mandant_id,art_id,arthiertyp_id,alt_neu_kz,wg_id,wg_art_fg)
select mandant_id, art_id, arthiertyp_id, -1, wg_id, wg_art_fg
from dbp_etl_process.artbew_wg_wechsel_2
;

insert into dbp_etl.artbew_wg_wechsel_tmp_2 (mandant_id,art_id,arthiertyp_id,alt_neu_kz,wg_id,wg_art_fg)
select t01.mandant_id, t01.art_id, t01.arthiertyp_id, 1, t01.wg_id, t02.wg_art_fg
from dbp_data.art_wg_zu_per_2 t01
join dbp_data.art_2 t02
  on t01.mandant_id = t02.mandant_id
 and t01.art_id = t02.art_id
where t01.dat_bis = '9999-12-31'
;

insert into dbp_etl.artbew_wg_wechsel_join_2 (art_id
	                                   ,mandant_id
	                                   ,arthiertyp_id
	                                   ,dat
	                                   ,alt_neu_kz
	                                   ,wg_id
	                                   ,wg_art_fg)
select w1.art_id art_id
      ,w1.mandant_id mandant_id
      ,w1.arthiertyp_id arthiertyp_id
      ,t.dat dat
      ,w1.alt_neu_kz
      ,w1.wg_id
      ,w1.wg_art_fg
from dbp_etl.artbew_wg_wechsel_tmp_2 w1

join dbp_etl.artbew_wg_wechsel_tmp_2 w2
  on w1.mandant_id = w2.mandant_id and 
     w1.art_id = w2.art_id and 
     w1.arthiertyp_id = w2.arthiertyp_id and 
   ((w1.alt_neu_kz = 1 and w2.alt_neu_kz = -1) or
    (w1.alt_neu_kz = -1 and w2.alt_neu_kz = 1))

join dbp_data.tag_2 t
  on t.dat <= current_date and 
     t.dat >= '2000-01-01'

where (w1.wg_id <> w2.wg_id or w1.wg_art_fg <> w2.wg_art_fg)
;

insert into dbp_etl.vis_tag_bestand_wg_wechsel_log_2 (art_id
	                                           ,mandant_id
	                                           ,arthiertyp_id
	                                           ,wg_id)
select w1.art_id art_id
      ,w1.mandant_id mandant_id
      ,w1.arthiertyp_id arthiertyp_id
      ,w1.wg_id
from dbp_etl.artbew_wg_wechsel_tmp_2 w1

join dbp_etl.artbew_wg_wechsel_tmp_2 w2
  on w1.mandant_id = w2.mandant_id and 
     w1.art_id = w2.art_id and 
     w1.arthiertyp_id = w2.arthiertyp_id and 
    (w1.alt_neu_kz = -1 and w2.alt_neu_kz = 1)

where w1.wg_id <> w2.wg_id and 
      w1.arthiertyp_id = 2 and 
     (w1.mandant_id, w1.art_id) not in (select mandant_id, art_id from dbp_etl.vis_tag_bestand_wg_wechsel_log_2)
;

insert into dbp_etl.vis_monat_best_wg_wechsel_log_2 (art_id
	                                          ,mandant_id
	                                          ,arthiertyp_id
	                                          ,wg_id)
select w1.art_id art_id
      ,w1.mandant_id mandant_id
      ,w1.arthiertyp_id arthiertyp_id
      ,w1.wg_id
from dbp_etl.artbew_wg_wechsel_tmp_2 w1

join dbp_etl.artbew_wg_wechsel_tmp_2 w2
  on w1.mandant_id = w2.mandant_id and 
     w1.art_id = w2.art_id and 
     w1.arthiertyp_id = w2.arthiertyp_id and 
    (w1.alt_neu_kz = -1 and w2.alt_neu_kz = 1)

where w1.wg_id <> w2.wg_id and 
      w1.arthiertyp_id = 2 and 
     (w1.mandant_id, w1.art_id) not in (select mandant_id, art_id from dbp_etl.vis_monat_best_wg_wechsel_log_2)
;

create or replace volatile table _wg_change as (
select mandant_id,
       wg_id
from dbp_etl.artbew_wg_wechsel_join_2
group by 1,2
);

-- AIS

delete from dbp_data.artbew_wg_tp2_sum_2
where (mandant_id,wg_id) in (select mandant_id,wg_id from _wg_change)
;

insert into dbp_data.artbew_wg_tp2_sum_2 (mandant_id
                                       ,dat
                                       ,wg_id
                                       ,wup_id
                                       ,nb_id
                                       ,arthiertyp_id
                                       ,bewart_id
                                       ,posten_id
                                       ,menge
                                       ,menge_ohne_wg_erf_art
                                       ,umsatz_netto
                                       ,diff_umsatz_netto_konz
                                       ,umsatz_mwst_betrag
                                       ,diff_umsatz_mwst_betrag_konz
                                       ,ek_brutto
                                       ,diff_ek_brutto_konz
                                       ,ek_netto
                                       ,diff_ek_netto_konz
                                       ,ek_nettonetto
                                       ,diff_ek_nettonetto_konz
                                       ,ek_kal_basis
                                       ,diff_ek_kal_basis_konz
                                       ,ek_mep
                                       ,diff_ek_mep_konz
                                       ,einstandspreis
                                       ,diff_einstandspreis_konz
                                       ,logkostenzuschlag
                                       ,diff_logkostenzuschlag_konz
                                       ,ek_netto_bnk
                                       ,diff_ek_netto_bnk_konz
                                       ,ek_netto_bnk_sachk
                                       ,diff_ek_netto_bnk_sachk_konz
                                       ,diff_ek_gld_konz
                                       ,ek_gld
                                       ,bewart_det_id
                                       ,pv_aktion
                                       ,pv_bby
                                       ,pv_kdn_bby
                                       ,pv_kdp_bby
                                       ,pv_aktion_bby
                                       ,pv_aktion_kdn_bby
                                       ,pv_aktion_kdp_bby
                                       ,td_update
                                       ,td_insert
                                       ,wrg_id
                                       ,ek_mep_vor_fwu
                                       ,ek_mep_vor_fwu_konz
                                       ,bonusbasis
                                       ,bonusbasis_konz
                                       ,pv_bonrabatt_bby
                                       ,wup_bereinigt_fg
                                       ,pv_aktion_konz
                                       ,pv_bby_konz
                                       ,pv_kdn_bby_konz
                                       ,pv_kdp_bby_konz
                                       ,pv_aktion_bby_konz
                                       ,pv_aktion_kdn_bby_konz
                                       ,pv_aktion_kdp_bby_konz
                                       ,pv_bonrabatt_bby_konz
                                       ,umrechnungskurs_hist
                                       ,aktionsart_id_liste_txt
                                       ,aktionsart_bez_liste_txt
                                       ,aktion_typ_id_liste_txt
                                       ,aktion_typ_bez_liste_txt)
select ab.mandant_id
      ,ab.dat
      ,a.wg_id
      ,ab.wup_id
      ,ab.nb_id
      ,a.arthiertyp_id
      ,ab.bewart_id
      ,ab.posten_id
      ,sum(ab.menge)
      ,sum(case when art.wg_art_fg = 0 then ab.menge else 0 end)
      ,sum(ab.umsatz_netto)
      ,sum(ab.diff_umsatz_netto_konz)
      ,sum(ab.umsatz_mwst_betrag)
      ,sum(ab.diff_umsatz_mwst_betrag_konz)
      ,sum(ab.ek_brutto)
      ,sum(ab.diff_ek_brutto_konz)
      ,sum(ab.ek_netto)
      ,sum(ab.diff_ek_netto_konz)
      ,sum(ab.ek_nettonetto)
      ,sum(ab.diff_ek_nettonetto_konz)
      ,sum(ab.ek_kal_basis)
      ,sum(ab.diff_ek_kal_basis_konz)
      ,sum(ab.ek_mep)
      ,sum(ab.diff_ek_mep_konz)
      ,sum(ab.einstandspreis)
      ,sum(ab.diff_einstandspreis_konz)
      ,sum(ab.logkostenzuschlag)
      ,sum(ab.diff_logkostenzuschlag_konz)
      ,sum(ab.ek_netto_bnk)
      ,sum(ab.diff_ek_netto_bnk_konz)
      ,sum(ab.ek_netto_bnk_sachk)
      ,sum(ab.diff_ek_netto_bnk_sachk_konz)
      ,sum(ab.diff_ek_gld_konz)
      ,sum(ab.ek_gld)
      ,ab.bewart_det_id
      ,sum(ab.pv_aktion)
      ,sum(ab.pv_bby)
      ,sum(ab.pv_kdn_bby)
      ,sum(ab.pv_kdp_bby)
      ,sum(ab.pv_aktion_bby)
      ,sum(ab.pv_aktion_kdn_bby)
      ,sum(ab.pv_aktion_kdp_bby)
      ,current_timestamp
      ,current_timestamp
      ,ab.wrg_2
      ,sum(ab.ek_mep_vor_fwu)
      ,sum(ab.ek_mep_vor_fwu_konz)
      ,sum(ab.bonusbasis)
      ,sum(ab.bonusbasis_konz)
      ,sum(ab.pv_bonrabatt_bby)
      ,wup_bereinigt_fg
      ,sum(ab.pv_aktion_konz)
      ,sum(ab.pv_bby_konz)
      ,sum(ab.pv_kdn_bby_konz)
      ,sum(ab.pv_kdp_bby_konz)
      ,sum(ab.pv_aktion_bby_konz)
      ,sum(ab.pv_aktion_kdn_bby_konz)
      ,sum(ab.pv_aktion_kdp_bby_konz)
      ,sum(ab.pv_bonrabatt_bby_konz)
      ,max(ab.umrechnungskurs_hist)
      ,ab.aktionsart_id_liste_txt
      ,ab.aktionsart_bez_liste_txt
      ,ab.aktion_typ_id_liste_txt
      ,ab.aktion_typ_bez_liste_txt
from dbp_data.artbew_2 ab
join dbp_data.art_2 art_2
  on art.art_id = ab.art_id and
     art.mandant_id = ab.mandant_id
join dbp_data.art_wg_zu_per_2 a
  on a.art_id = ab.art_id and
     a.mandant_id = ab.mandant_id and
     a.dat_bis = '9999-12-31' and
     a.arthiertyp_id = 2
join dbp_data.kurs_2 k
  on ab.wrg_2 = k.von_wrg_id and
     ab.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
where (ab.mandant_id,a.wg_id) in (select mandant_id,wg_id from _wg_change)
group by all
;

delete from dbp_data.artbew_wg_mo_sum_2
where (mandant_id,wg_id) in (select mandant_id,wg_id from _wg_change)
;

insert into dbp_data.artbew_wg_mo_sum_2 (mandant_id
                                      ,wup_id
                                      ,nb_id
                                      ,kjmo
                                      ,bewart_id
                                      ,posten_id
                                      ,wg_id
                                      ,arthiertyp_id
                                      ,bewart_det_id
                                      ,wrg_id
                                      ,umrechnungskurs_hist
                                      ,menge
                                      ,umsatz_netto
                                      ,diff_umsatz_netto_konz
                                      ,umsatz_mwst_betrag
                                      ,diff_umsatz_mwst_betrag_konz
                                      ,ek_brutto
                                      ,diff_ek_brutto_konz
                                      ,ek_netto
                                      ,diff_ek_netto_konz
                                      ,ek_nettonetto
                                      ,diff_ek_nettonetto_konz
                                      ,ek_kal_basis
                                      ,diff_ek_kal_basis_konz
                                      ,ek_mep
                                      ,diff_ek_mep_konz
                                      ,ek_mep_vor_fwu
                                      ,ek_mep_vor_fwu_konz
                                      ,einstandspreis
                                      ,diff_einstandspreis_konz
                                      ,logkostenzuschlag
                                      ,diff_logkostenzuschlag_konz
                                      ,ek_netto_bnk
                                      ,diff_ek_netto_bnk_konz
                                      ,ek_netto_bnk_sachk
                                      ,diff_ek_netto_bnk_sachk_konz
                                      ,ek_gld
                                      ,diff_ek_gld_konz
                                      ,bonusbasis
                                      ,bonusbasis_konz
                                      ,pv_aktion
                                      ,pv_aktion_konz
                                      ,pv_bby
                                      ,pv_bby_konz
                                      ,pv_kdn_bby
                                      ,pv_kdn_bby_konz
                                      ,pv_kdp_bby
                                      ,pv_kdp_bby_konz
                                      ,pv_aktion_bby
                                      ,pv_aktion_bby_konz
                                      ,pv_aktion_kdn_bby
                                      ,pv_aktion_kdn_bby_konz
                                      ,pv_aktion_kdp_bby
                                      ,pv_aktion_kdp_bby_konz
                                      ,pv_bonrabatt_bby
                                      ,pv_bonrabatt_bby_konz
                                      ,td_update
                                      ,td_insert)
select mandant_id
      ,wup_id
      ,nb_id
      ,cast(to_varchar(dat,'yyyymm') as integer)
      ,bewart_id
      ,posten_id
      ,wg_id
      ,arthiertyp_id
      ,bewart_det_id
      ,wrg_id
      ,max(umrechnungskurs_hist)
      ,sum(menge)
      ,sum(umsatz_netto)
      ,sum(diff_umsatz_netto_konz)
      ,sum(umsatz_mwst_betrag)
      ,sum(diff_umsatz_mwst_betrag_konz)
      ,sum(ek_brutto)
      ,sum(diff_ek_brutto_konz)
      ,sum(ek_netto)
      ,sum(diff_ek_netto_konz)
      ,sum(ek_nettonetto)
      ,sum(diff_ek_nettonetto_konz)
      ,sum(ek_kal_basis)
      ,sum(diff_ek_kal_basis_konz)
      ,sum(ek_mep)
      ,sum(diff_ek_mep_konz)
      ,sum(ek_mep_vor_fwu)
      ,sum(ek_mep_vor_fwu_konz)
      ,sum(einstandspreis)
      ,sum(diff_einstandspreis_konz)
      ,sum(logkostenzuschlag)
      ,sum(diff_logkostenzuschlag_konz)
      ,sum(ek_netto_bnk)
      ,sum(diff_ek_netto_bnk_konz)
      ,sum(ek_netto_bnk_sachk)
      ,sum(diff_ek_netto_bnk_sachk_konz)
      ,sum(ek_gld)
      ,sum(diff_ek_gld_konz)
      ,sum(bonusbasis)
      ,sum(bonusbasis_konz)
      ,sum(pv_aktion)
      ,sum(pv_aktion_konz)
      ,sum(pv_bby)
      ,sum(pv_bby_konz)
      ,sum(pv_kdn_bby)
      ,sum(pv_kdn_bby_konz)
      ,sum(pv_kdp_bby)
      ,sum(pv_kdp_bby_konz)
      ,sum(pv_aktion_bby)
      ,sum(pv_aktion_bby_konz)
      ,sum(pv_aktion_kdn_bby)
      ,sum(pv_aktion_kdn_bby_konz)
      ,sum(pv_aktion_kdp_bby)
      ,sum(pv_aktion_kdp_bby_konz)
      ,sum(pv_bonrabatt_bby)
      ,sum(pv_bonrabatt_bby_konz)
      ,current_timestamp
      ,current_timestamp
from dbp_data.artbew_wg_tp2_sum_2
where (mandant_id,wg_id) in (select mandant_id,wg_id from _wg_change)
group by all
;

-- VIS

create or replace table dbp_etl.wpuums_build_tmp_2 (
      mandant_id byteint not null,
      wup_id integer not null,
      wg_id smallint not null,
      bewart_id smallint not null,
      dat date not null,
      nb_id smallint not null,
      arthiertyp_id byteint,
      umsatz_brutto decimal(18,4),
      umsatz_netto decimal(18,4),
      umsatz_wrg char(3) collate 'en-ci',
      umsatz_brutto_konz decimal(18,4),
      umsatz_netto_konz decimal(18,4),
      umsatz_mwst_betrag decimal(18,4),
      kjmo integer,
      menge decimal(18,3) default 0.000  ,
      quelle byteint default 0 
);

insert into dbp_etl.wpuums_build_tmp_2 (mandant_id
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
                                       ,umsatz_mwst_betrag
                                       ,kjmo
                                       ,menge
                                       ,quelle)
select a.mandant_id
      ,a.wup_id
      ,w.wg_id
      ,1001 as bewart_id
      ,a.dat
      ,a.nb_id
      ,2 as arthiertyp_id
      ,sum(a.umsatz_netto+a.umsatz_mwst_betrag) as umsatz_brutto
      ,sum(a.umsatz_netto)
      ,a.wrg_2
      ,0
      ,0
      ,sum(a.umsatz_mwst_betrag) as umsatz_mwst_betrag
      ,cast(to_varchar(a.dat,'yyyymm') as integer) as kjmo
      ,sum(a.menge) as menge
      ,1
from dbp_etl_process.artbew_archiv_2 a
join dbp_data.art_wg_zu_per_2 w
  on a.mandant_id = w.mandant_id and 
     a.art_id = w.art_id and 
     w.dat_bis = '9999-12-31' and 
     w.arthiertyp_id = 2
where case
        when a.mandant_id = 1 and a.dat >= '2017-03-01' and
             a.art_id in (590006700,590006900)
        then 0
        when a.mandant_id = 6 and
             a.art_id/10 in (9800130,9800131,9800132)
        then 0
        when a.mandant_id = 7 and
             a.dat >= '2019-03-01' and
             w.wg_id = 969 and
             w.wug_id = 6
        then 0
        else 1
      end = 1 and
     (w.mandant_id,w.wg_id) in (select mandant_id,wg_id from _wg_change)
group by 1,2,3,4,5,6,7,10,11,12,14,16
;

insert into dbp_etl.wpuums_build_tmp_2 (mandant_id
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
                                       ,umsatz_mwst_betrag
                                       ,kjmo
                                       ,menge
                                       ,quelle)
select a.mandant_id
      ,a.wup_id
      ,w.wg_id
      ,1001 as bewart_id
      ,a.dat
      ,a.nb_id
      ,2 as arthiertyp_id
      ,sum(a.umsatz_netto+a.umsatz_mwst_betrag) as umsatz_brutto
      ,sum(a.umsatz_netto)
      ,a.wrg_2
      ,0
      ,0
      ,sum(a.umsatz_mwst_betrag) as umsatz_mwst_betrag
      ,cast(to_varchar(a.dat,'yyyymm') as integer) as kjmo
      ,sum(a.menge) as menge
      ,1
from dbp_data.artbew_2 a
join dbp_data.art_wg_zu_per_2 w
  on a.mandant_id = w.mandant_id and 
     a.art_id = w.art_id and 
     w.dat_bis = '9999-12-31' and 
     w.arthiertyp_id = 2
where case
        when a.mandant_id = 1 and a.dat >= '2017-03-01' and
             a.art_id in (590006700,590006900)
        then 0
        when a.mandant_id = 6 and
             a.art_id/10 in (9800130,9800131,9800132)
        then 0
        when a.mandant_id = 7 and
             a.dat >= '2019-03-01' and
             w.wg_id = 969 and
             w.wug_id = 6
        then 0
        else 1
      end = 1 and
     (w.mandant_id,w.wg_id) in (select mandant_id,wg_id from _wg_change)
group by 1,2,3,4,5,6,7,10,11,12,14,16
;

update dbp_etl.wpuums_build_tmp_2
from dbp_data.kurs_2 k

set umsatz_brutto_konz = cast(umsatz_brutto * k.umrechnungskurs as decimal(18,4))
, umsatz_netto_konz = cast(umsatz_netto * k.umrechnungskurs as decimal(18,4))

where dbp_etl.wpuums_build_tmp.umsatz_wrg = k.von_wrg_id
and k.dat_bis = '9999-12-31'
and k.nach_wrg_id = 'EUR'
and k.kurstyp_id = 3
;

delete from dbp_data.artbew_wg_sum_2
where bewart_id = 1001
  and quelle = 1
  and (mandant_id,wg_id) in (select mandant_id,wg_id from _wg_change)
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
from dbp_etl.wpuums_build_tmp_2 a
join dbp_data.kurs_2 k
  on a.umsatz_wrg = k.von_wrg_id and
     a.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
;

DROP TABLE IF EXISTS DBP_ETL.maabs_build_tmp_2;
CREATE TABLE DBP_ETL.maabs_build_tmp_2  (
      mandant_id BYTEINT NOT NULL ,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      abschriftart_id SMALLINT NOT NULL ,
      wg_id SMALLINT NOT NULL,
      arthiertyp_id BYTEINT NOT NULL ,
      dat DATE NOT NULL,
      abschriftbetrag_netto DECIMAL(18,2) NOT NULL,
      abschriftbetrag_brutto DECIMAL(18,2) NOT NULL,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL )
;

INSERT INTO DBP_ETL.maabs_build_tmp_2
(
wup_id
,nb_id
,dat
,mandant_id
,wg_id
,abschriftart_ID
,wrg_id
,arthiertyp_id
,abschriftbetrag_netto
,abschriftbetrag_brutto
)
SELECT
t1.wup_id
,t1.nb_id
,t1.dat_umbew
,t1.mandant_id
,t2.wg_id
,t1.preis_aend_grund_id
,t1.wrg_id
,t2.arthiertyp_id
,SUM(t1.diff_wert_bestand_netto*t2.alt_neu_kz)
,SUM(t1.diff_wert_bestand_brutto*t2.alt_neu_kz)

FROM  dbp_data.art_umbewertung_2 t1_2

JOIN DBP_ETL.artbew_wg_wechsel_join_2 t2
ON t1.mandant_id = t2.mandant_id
AND t1.art_id = t2.art_id
AND t1.dat_umbew = t2.dat

INNER JOIN dbp_data.abschriftart_abschriftgrp_zu_2 t3
ON  t3.mandant_id      = t1.mandant_id
AND t3.abschriftart_id = t1.preis_aend_grund_id
AND t3.abschriftgruppe_id = 400

GROUP BY 1,2,3,4,5,6,7,8
;

INSERT INTO DBP_ETL.maabs_build_tmp_2
(        wup_id
        ,nb_id
        ,dat
        ,mandant_id
        ,wg_id
        ,abschriftart_ID
        ,wrg_id
        ,arthiertyp_id
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
)
SELECT   t1.wup_id
        ,t1.nb_id
        ,t1.dat
        ,t1.mandant_id
        ,t2.wg_id
        ,t1.abschriftart_ID
        ,t1.wrg_id
        ,t2.arthiertyp_id
        ,SUM(t1.abschriftbetrag_netto*t2.alt_neu_kz)
        ,SUM(t1.abschriftbetrag_brutto*t2.alt_neu_kz)
FROM dbp_data.marktabschriften_2 t1_2

JOIN DBP_ETL.artbew_wg_wechsel_join_2 t2
ON t1.mandant_id = t2.mandant_id
AND t1.art_id = t2.art_id
AND t1.dat = t2.dat

GROUP BY 1,2,3,4,5,6,7,8
;

UPDATE DBP_DATA.marktabschriften_wg_sum_2 mws
SET abschriftbetrag_netto = mws.abschriftbetrag_netto + b.abschriftbetrag_netto,
    abschriftbetrag_brutto = mws.abschriftbetrag_brutto + b.abschriftbetrag_brutto

FROM (SELECT wup_id
                                                     ,nb_id
                                                     ,dat
                                                     ,mandant_id
                                                     ,wg_id
                                                     ,abschriftart_ID
                                                     ,wrg_id
                                                     ,arthiertyp_id
                                                     ,abschriftbetrag_netto
                                                     ,abschriftbetrag_brutto
                                              FROM DBP_ETL.maabs_build_tmp_2) b
                                               WHERE mws.wup_id = b.wup_id AND
      mws.nb_id = b.nb_id AND
      mws.dat = b.dat AND
      mws.mandant_id = b.mandant_id AND
      mws.wg_id = b.wg_id AND
      mws.abschriftart_ID = b.abschriftart_ID AND
      mws.wrg_id = b.wrg_id AND
      mws.arthiertyp_id = b.arthiertyp_id
;

INSERT INTO DBP_DATA.marktabschriften_wg_sum_2 (wup_id
                                              ,nb_id
                                              ,dat
                                              ,mandant_id
                                              ,wg_id
                                              ,abschriftart_ID
                                              ,wrg_id
                                              ,arthiertyp_id
                                              ,abschriftbetrag_netto
                                              ,abschriftbetrag_brutto)
SELECT a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.mandant_id
      ,a.wg_id
      ,a.abschriftart_ID
      ,a.wrg_id
      ,a.arthiertyp_id
      ,a.abschriftbetrag_netto
      ,a.abschriftbetrag_brutto
FROM (SELECT wup_id
            ,nb_id
            ,dat
            ,mandant_id
            ,wg_id
            ,abschriftart_ID
            ,wrg_id
            ,arthiertyp_id
            ,SUM(abschriftbetrag_netto) AS abschriftbetrag_netto
            ,SUM(abschriftbetrag_brutto) AS abschriftbetrag_brutto
      FROM DBP_ETL.maabs_build_tmp_2
      GROUP BY 1,2,3,4,5,6,7,8) a
LEFT JOIN DBP_DATA.marktabschriften_wg_sum_2 b
  ON a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.mandant_id = b.mandant_id AND
     a.wg_id = b.wg_id AND
     a.abschriftart_ID = b.abschriftart_ID AND
     a.wrg_id = b.wrg_id AND
     a.arthiertyp_id = b.arthiertyp_id
WHERE b.mandant_id IS NULL
;

/*2021-09-22 mfialkiewicz adding missing delete statement*/
DELETE FROM DBP_ETL_PROCESS.artbew_wg_wechsel_2;

INSERT INTO DBP_ETL_PROCESS.artbew_wg_wechsel_2 (mandant_id, art_id, arthiertyp_id, wg_id, wg_art_fg)
SELECT mandant_id, art_id, arthiertyp_id, wg_id, wg_art_fg
FROM DBP_ETL.artbew_wg_wechsel_tmp_2
WHERE alt_neu_kz = 1
;

DELETE FROM DBP_DATA.artbew_wg_mo_sum_2 awms using DBP_ETL.artbew_wg_sum_tmp_2 awst
WHERE
awms.wg_id = awst.wg_id AND
awms.wup_id = awst.wup_id AND
awms.nb_id = awst.nb_id AND
awms.arthiertyp_id = awst.arthiertyp_id AND
awms.bewart_id = awst.bewart_id AND
awms.posten_id = awst.posten_id AND
awms.mandant_id = awst.mandant_id AND
awms.menge                         = 0 AND
awms.umsatz_netto                  = 0 AND
awms.diff_umsatz_netto_konz        = 0 AND
awms.umsatz_mwst_betrag            = 0 AND
awms.diff_umsatz_mwst_betrag_konz  = 0 AND
awms.ek_brutto                     = 0 AND
awms.diff_ek_brutto_konz           = 0 AND
awms.ek_netto                      = 0 AND
awms.diff_ek_netto_konz            = 0 AND
awms.ek_nettonetto                 = 0 AND
awms.diff_ek_nettonetto_konz       = 0 AND
awms.ek_kal_basis                  = 0 AND
awms.diff_ek_kal_basis_konz        = 0 AND
awms.ek_mep                        = 0 AND
awms.diff_ek_mep_konz              = 0 AND
awms.einstandspreis                = 0 AND
awms.diff_einstandspreis_konz      = 0 AND
awms.logkostenzuschlag             = 0 AND
awms.diff_logkostenzuschlag_konz   = 0 AND
awms.ek_netto_bnk                  = 0 AND
awms.diff_ek_netto_bnk_konz        = 0 AND
awms.ek_netto_bnk_sachk            = 0 AND
awms.diff_ek_netto_bnk_sachk_konz  = 0 
;

DELETE FROM DBP_DATA.artbew_wg_tp2_sum_2 awts using DBP_ETL.artbew_wg_sum_tmp_2 abwstmp
WHERE
  awts.menge                         = 0 AND
  awts.menge_ohne_wg_erf_art         = 0 AND
  awts.umsatz_netto                  = 0 AND
  awts.diff_umsatz_netto_konz        = 0 AND
  awts.umsatz_mwst_betrag            = 0 AND
  awts.diff_umsatz_mwst_betrag_konz  = 0 AND
  awts.ek_brutto                     = 0 AND
  awts.diff_ek_brutto_konz           = 0 AND
  awts.ek_netto                      = 0 AND
  awts.diff_ek_netto_konz            = 0 AND
  awts.ek_nettonetto                 = 0 AND
  awts.diff_ek_nettonetto_konz       = 0 AND
  awts.ek_kal_basis                  = 0 AND
  awts.diff_ek_kal_basis_konz        = 0 AND
  awts.ek_mep                        = 0 AND
  awts.diff_ek_mep_konz              = 0 AND
  awts.einstandspreis                = 0 AND
  awts.diff_einstandspreis_konz      = 0 AND
  awts.logkostenzuschlag             = 0 AND
  awts.diff_logkostenzuschlag_konz   = 0 AND
  awts.ek_netto_bnk                  = 0 AND
  awts.diff_ek_netto_bnk_konz        = 0 AND
  awts.ek_netto_bnk_sachk            = 0 AND
  awts.diff_ek_netto_bnk_sachk_konz  = 0 AND
  awts.wg_id = abwstmp.wg_id  AND
  awts.wup_id = abwstmp.wup_id AND
  awts.nb_id = abwstmp.nb_id  AND
  awts.arthiertyp_id = abwstmp.arthiertyp_id  AND
  awts.dat = abwstmp.dat  AND
  awts.bewart_id = abwstmp.bewart_id  AND
  awts.posten_id = collate(abwstmp.posten_id, 'en-ci')  AND
  awts.mandant_id = abwstmp.mandant_id 
;

DELETE FROM DBP_DATA.artbew_wg_sum_2 aws using DBP_ETL.wpuums_build_tmp_2 wbt
WHERE
aws.menge               = 0 AND
aws.umsatz_netto        = 0 AND
aws.umsatz_brutto       = 0 AND
aws.umsatz_brutto_konz  = 0 AND
aws.umsatz_netto_konz   = 0 AND
aws.wg_id = wbt.wg_id  AND
aws.wup_id = wbt.wup_id   AND
aws.nb_id = wbt.nb_id   AND
aws.arthiertyp_id = wbt.arthiertyp_id   AND
aws.bewart_id = wbt.bewart_id   AND
aws.mandant_id = wbt.mandant_id   AND
aws.dat = wbt.dat   AND
aws.umsatz_wrg = wbt.umsatz_wrg   AND
aws.quelle = wbt.quelle  
;

DELETE FROM DBP_DATA.marktabschriften_wg_sum_2 mws using DBP_ETL.maabs_build_tmp_2 mbt
WHERE
mws.abschriftbetrag_netto  = 0 AND
mws.abschriftbetrag_brutto = 0 AND
mws.wup_id = mbt.wup_id  AND
mws.nb_id = mbt.nb_id  AND
mws.dat = mbt.dat  AND
mws.mandant_id = mbt.mandant_id  AND
mws.wg_id = mbt.wg_id  AND
mws.abschriftart_ID = mbt.abschriftart_ID  AND
mws.wrg_id = mbt.wrg_id  AND
mws.arthiertyp_id = mbt.arthiertyp_id 
;

DROP TABLE IF EXISTS DBP_ETL.artbew_wg_wechsel_tmp_2;
DROP TABLE IF EXISTS DBP_ETL.artbew_wg_sum_tmp_2;
