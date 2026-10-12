create or replace table dbp_etl.artbew_zek_wechsel_tmp (
  mandant_id       byteint not null
 ,art_id           integer not null
 ,alt_neu_kz       byteint not null
 ,zek_id           varchar(3) not null
 ,unique (mandant_id,art_id,alt_neu_kz)
);

create or replace table dbp_etl.artbew_zek_wechsel_join (
  mandant_id byteint not null
 ,art_id integer not null
 ,kjmo integer not null
 ,alt_neu_kz byteint not null
 ,zek_id varchar(3) not null
);

insert into dbp_etl.artbew_zek_wechsel_tmp (mandant_id,art_id,alt_neu_kz,zek_id)
select mandant_id,art_id,-1,zek_id
from dbp_process.artbew_zek_wechsel
;

insert into dbp_etl.artbew_zek_wechsel_tmp (mandant_id,art_id,alt_neu_kz,zek_id)
select mandant_id,art_id,1,zek_id
from dbp_data.art
;

insert into dbp_etl.artbew_zek_wechsel_join (art_id
                                            ,mandant_id
                                            ,kjmo
                                            ,alt_neu_kz
                                            ,zek_id)
select w1.art_id art_id
      ,w1.mandant_id mandant_id
      ,m.kjmo
      ,w1.alt_neu_kz
      ,w1.zek_id
from dbp_etl.artbew_zek_wechsel_tmp w1
join dbp_etl.artbew_zek_wechsel_tmp w2
  on w1.mandant_id = w2.mandant_id and 
     w1.art_id = w2.art_id and 
   ((w1.alt_neu_kz = 1 and w2.alt_neu_kz = -1) or
    (w1.alt_neu_kz = -1 and w2.alt_neu_kz = 1))
join dbp_data.monat m
  on m.akt_mo <= 0 and 
     m.kjmo >= 200001
where w1.zek_id <> w2.zek_id
;

create or replace volatile table _zek_change as (
select mandant_id,
       zek_id
from dbp_etl.artbew_zek_wechsel_join
group by 1,2
);

delete from dbp_data.artbew_zek_mo_sum
where (mandant_id,zek_id) in (select mandant_id,zek_id from _zek_change)
;

insert into dbp_data.artbew_zek_mo_sum (mandant_id
                                       ,kjmo
                                       ,bewart_id
                                       ,wup_id
                                       ,nb_id
                                       ,posten_id
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
                                       ,ek_mep_vor_fwu
                                       ,ek_mep_vor_fwu_konz
                                       ,bonusbasis
                                       ,bonusbasis_konz
                                       ,pv_bonrabatt_bby
                                       ,zek_id
                                       ,wrg_id
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
select a.mandant_id
      ,a.kjmo
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.posten_id
      ,sum(a.menge)
      ,sum(a.umsatz_netto)
      ,sum(a.diff_umsatz_netto_konz)
      ,sum(a.umsatz_mwst_betrag)
      ,sum(a.diff_umsatz_mwst_betrag_konz)
      ,sum(a.ek_brutto)
      ,sum(a.diff_ek_brutto_konz)
      ,sum(a.ek_netto)
      ,sum(a.diff_ek_netto_konz)
      ,sum(a.ek_nettonetto)
      ,sum(a.diff_ek_nettonetto_konz)
      ,sum(a.ek_kal_basis)
      ,sum(a.diff_ek_kal_basis_konz)
      ,sum(a.ek_mep)
      ,sum(a.diff_ek_mep_konz)
      ,sum(a.einstandspreis)
      ,sum(a.diff_einstandspreis_konz)
      ,sum(a.logkostenzuschlag)
      ,sum(a.diff_logkostenzuschlag_konz)
      ,sum(a.ek_netto_bnk)
      ,sum(a.diff_ek_netto_bnk_konz)
      ,sum(a.ek_netto_bnk_sachk)
      ,sum(a.diff_ek_netto_bnk_sachk_konz)
      ,sum(a.diff_ek_gld_konz)
      ,sum(a.ek_gld)
      ,a.bewart_det_id
      ,sum(a.pv_aktion)
      ,sum(a.pv_bby)
      ,sum(a.pv_kdn_bby)
      ,sum(a.pv_kdp_bby)
      ,sum(a.pv_aktion_bby)
      ,sum(a.pv_aktion_kdn_bby)
      ,sum(a.pv_aktion_kdp_bby)
      ,current_timestamp
      ,current_timestamp
      ,sum(a.ek_mep_vor_fwu)
      ,sum(a.ek_mep_vor_fwu_konz)
      ,sum(a.bonusbasis)
      ,sum(a.bonusbasis_konz)
      ,sum(a.pv_bonrabatt_bby)
      ,b.zek_id
      ,a.wrg_id
      ,max(k.umrechnungskurs)
      ,sum(pv_aktion_konz)
      ,sum(pv_bby_konz)
      ,sum(pv_kdn_bby_konz)
      ,sum(pv_kdp_bby_konz)
      ,sum(pv_aktion_bby_konz)
      ,sum(pv_aktion_kdn_bby_konz)
      ,sum(pv_aktion_kdp_bby_konz)
      ,sum(pv_bonrabatt_bby_konz)
      ,aktionsart_id_liste_txt
      ,aktionsart_bez_liste_txt
      ,aktion_typ_id_liste_txt
      ,aktion_typ_bez_liste_txt
from dbp_data.artbew_mo_sum a
join dbp_data.art b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     case 
       when a.mandant_id = 2 and 
            a.art_id = 208124500
       then 0
       when a.mandant_id = 3 and 
            a.art_id = 208113690
       then 0
       when a.mandant_id = 5 and
            a.art_id = 206731500
       then 0
       when a.mandant_id = 6 and
            a.art_id = 208131570
       then 0
       when a.mandant_id in (4,7) and
            a.art_id = 208114740
       then 0
       when a.mandant_id = 8 and
            a.art_id = 208131640
       then 0
       else 1 
     end = 1
join dbp_data.monat x
  on a.kjmo = x.kjmo
join dbp_data.kurs k
  on a.wrg_id = k.von_wrg_id and
     x.min_dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
where (a.mandant_id,b.zek_id) in (select mandant_id,zek_id from _zek_change)
group by all
;

delete from dbp_process.artbew_zek_wechsel;
insert into dbp_process.artbew_zek_wechsel (mandant_id, art_id, zek_id)
select mandant_id, art_id, zek_id
from dbp_etl.artbew_zek_wechsel_tmp
where alt_neu_kz = 1
;

drop table if exists dbp_etl.artbew_zek_wechsel_tmp;
drop table if exists dbp_etl.artbew_zek_wechsel_join;
