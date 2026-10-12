create or replace volatile table _artbew_agg_zek (
  mandant_id byteint not null,
  wup_id integer not null,
  nb_id smallint not null,
  kjmo integer not null
);

insert into _artbew_agg_zek (mandant_id
                            ,wup_id
                            ,nb_id
                            ,kjmo)
select a.mandant_id,
       a.wup_id,
       a.nb_id,
       c.kjmo
from dbp_data.artbew_agg_wt_2 a
join dbp_data.tag_2 b
  on a.dat = b.dat
join dbp_data.tag_2 c
  on b.kjmo = c.kjmo
group by 1,2,3,4
;

delete from dbp_data.artbew_zek_mo_sum_2
where (mandant_id,wup_id,nb_id,kjmo) in (select mandant_id,wup_id,nb_id,kjmo from _artbew_agg_zek) and 
      (kjmo) in (select kjmo from _artbew_agg_zek)
;

insert into dbp_data.artbew_zek_mo_sum_2 (bewart_id
                                       ,zek_id
                                       ,wup_id
                                       ,posten_id
                                       ,mandant_id
                                       ,nb_id
                                       ,kjmo
                                       ,wrg_id
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
                                       ,bewart_det_id
                                       ,umrechnungskurs_hist      
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
select a.bewart_id
      ,b.zek_id
      ,a.wup_id
      ,a.posten_id
      ,a.mandant_id
      ,a.nb_id
      ,a.kjmo
      ,a.wrg_id
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
      ,a.bewart_det_id
      ,max(a.umrechnungskurs_hist)
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
from dbp_data.artbew_mo_sum_2 a
join dbp_data.art_2 b
  on a.art_id = b.art_id and 
     a.mandant_id = b.mandant_id and
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
join _artbew_agg_zek c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.nb_id = c.nb_id and
     a.kjmo = c.kjmo
group by all
;
