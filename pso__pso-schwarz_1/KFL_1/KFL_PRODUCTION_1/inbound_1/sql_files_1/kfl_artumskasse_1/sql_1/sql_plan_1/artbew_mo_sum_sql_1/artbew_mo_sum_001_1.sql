create or replace volatile table _artbew_agg_monat (
  dat date not null,
  mandant_id byteint not null,
  wup_id integer not null,
  nb_id smallint not null,
  kjmo integer not null
);

insert into _artbew_agg_monat (dat
                              ,mandant_id
                              ,wup_id
                              ,nb_id
                              ,kjmo)
select c.dat,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       c.kjmo
from dbp_data.artbew_agg_wt_1 a
join dbp_data.tag_1 b
  on a.dat = b.dat
join dbp_data.tag_1 c
  on b.kjmo = c.kjmo
group by 1,2,3,4,5
;

delete from dbp_data.artbew_mo_sum_1
where (mandant_id,wup_id,nb_id,kjmo) in (select mandant_id,wup_id,nb_id,kjmo from _artbew_agg_monat) and 
      (kjmo,mandant_id) in (select kjmo,mandant_id from _artbew_agg_monat)
;

insert into dbp_data.artbew_mo_sum_1 (art_id
                                   ,wup_id
                                   ,kjmo
                                   ,mandant_id
                                   ,bewart_id
                                   ,bewart_det_id
                                   ,ean_kasse
                                   ,nb_id
                                   ,gp_id
                                   ,posten_id
                                   ,wrg_id
                                   ,umrechnungskurs_hist
                                   ,herst_id
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
                                   ,pv_aktion
                                   ,pv_bby
                                   ,pv_kdn_bby
                                   ,pv_kdp_bby
                                   ,pv_aktion_bby
                                   ,pv_aktion_kdn_bby
                                   ,pv_aktion_kdp_bby
                                   ,ek_gld
                                   ,diff_ek_gld_konz
                                   ,ek_mep_vor_fwu
                                   ,ek_mep_vor_fwu_konz
                                   ,bonusbasis
                                   ,bonusbasis_konz
                                   ,pv_bonrabatt_bby
                                   ,pv_aktion_konz
                                   ,pv_bby_konz
                                   ,pv_kdn_bby_konz
                                   ,pv_kdp_bby_konz
                                   ,pv_aktion_bby_konz
                                   ,pv_aktion_kdn_bby_konz
                                   ,pv_aktion_kdp_bby_konz
                                   ,pv_bonrabatt_bby_konz
                                   ,aktionsart_id_liste_txt
                                   ,aktionsart_bez_liste_txt
                                   ,aktion_typ_id_liste_txt
                                   ,aktion_typ_bez_liste_txt)
select a.art_id
      ,a.wup_id
      ,b.kjmo
      ,a.mandant_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.ean_kasse
      ,a.nb_id
      ,a.gp_id
      ,a.posten_id
      ,a.wrg_1
      ,max(a.umrechnungskurs_hist)
      ,max(a.herst_id)
      ,sum(a.menge)
      ,sum(a.umsatz_netto)
      ,sum(a.diff_umsatz_netto_konz)
      ,sum(a.umsatz_mwst_betrag)
      ,sum(a.diff_umsatz_mwst_betrag_konz)
      ,sum(cast((a.ek_brutto) as decimal(18,4))) 
      ,sum(cast((a.diff_ek_brutto_konz) as decimal(18,4)))
      ,sum(cast((a.ek_netto) as decimal(18,4)))
      ,sum(cast((a.diff_ek_netto_konz) as decimal(18,4)))
      ,sum(cast((a.ek_nettonetto) as decimal(18,4))) 
      ,sum(cast((a.diff_ek_nettonetto_konz) as decimal(18,4))) 
      ,sum(cast((a.ek_kal_basis) as decimal(18,4))) 
      ,sum(cast((a.diff_ek_kal_basis_konz) as decimal(18,4))) 
      ,sum(cast((a.ek_mep) as decimal(18,4))) 
      ,sum(cast((a.diff_ek_mep_konz) as decimal(18,4))) 
      ,sum(cast((a.einstandspreis) as decimal(18,4))) 
      ,sum(cast((a.diff_einstandspreis_konz) as decimal(18,4)))
      ,sum(a.logkostenzuschlag) 
      ,sum(a.diff_logkostenzuschlag_konz)
      ,sum(cast((a.ek_netto_bnk) as decimal(18,4))) 
      ,sum(cast((a.diff_ek_netto_bnk_konz) as decimal(18,4))) 
      ,sum(cast((a.ek_netto_bnk_sachk) as decimal(18,4))) 
      ,sum(cast((a.diff_ek_netto_bnk_sachk_konz) as decimal(18,4)))
      ,sum(a.pv_aktion)
      ,sum(a.pv_bby)
      ,sum(a.pv_kdn_bby)
      ,sum(a.pv_kdp_bby)
      ,sum(a.pv_aktion_bby)
      ,sum(a.pv_aktion_kdn_bby)
      ,sum(a.pv_aktion_kdp_bby)
      ,sum(a.ek_gld)
      ,sum(a.diff_ek_gld_konz)
      ,sum(a.ek_mep_vor_fwu)
      ,sum(a.ek_mep_vor_fwu_konz)
      ,sum(a.bonusbasis)
      ,sum(a.bonusbasis_konz)
      ,sum(a.pv_bonrabatt_bby)
      ,sum(a.pv_aktion_konz)
      ,sum(a.pv_bby_konz)
      ,sum(a.pv_kdn_bby_konz)
      ,sum(a.pv_kdp_bby_konz)
      ,sum(a.pv_aktion_bby_konz)
      ,sum(a.pv_aktion_kdn_bby_konz)
      ,sum(a.pv_aktion_kdp_bby_konz)
      ,sum(a.pv_bonrabatt_bby_konz)
      ,a.aktionsart_id_liste_txt
      ,a.aktionsart_bez_liste_txt
      ,a.aktion_typ_id_liste_txt
      ,a.aktion_typ_bez_liste_txt
from dbp_data.artbew_1 a
join _artbew_agg_monat b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id and
     a.dat = b.dat
group by a.art_id,a.wup_id,a.nb_id,b.kjmo,a.mandant_id,a.bewart_id,a.bewart_det_id,a.gp_id,a.posten_id,a.wrg_1,a.ean_kasse,
         a.aktionsart_id_liste_txt,a.aktionsart_bez_liste_txt,a.aktion_typ_id_liste_txt,a.aktion_typ_bez_liste_txt
;
