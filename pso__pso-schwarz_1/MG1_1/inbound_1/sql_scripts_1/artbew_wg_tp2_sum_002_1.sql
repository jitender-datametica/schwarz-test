delete from dbp_data.artbew_wg_tp2_sum_1
where (mandant_id,wup_id,dat) in (select mandant_id,wup_id,t.dat
                                  from (select mandant_id
                                              ,wup_id
                                              ,max(dat) as dat_max
                                              ,min(dat) as dat_min
                                        from dbp_data.artbew_agg_wt_1
                                        group by 1,2) a
                                  join dbp_data.tag_1 t
                                    on t.dat between a.dat_min and a.dat_max)
;

insert into dbp_data.artbew_wg_tp2_sum_1 (mandant_id
                                       ,wup_id
                                       ,nb_id
                                       ,wg_id
                                       ,arthiertyp_id
                                       ,dat
                                       ,bewart_id
                                       ,posten_id
                                       ,wrg_id
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
                                       ,bewart_det_id
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
                                       ,wup_bereinigt_fg
                                       ,umrechnungskurs_hist
                                       ,pv_aktion_konz
                                       ,pv_bby_konz
                                       ,pv_kdn_bby_konz
                                       ,pv_kdp_bby_konz
                                       ,pv_aktion_bby_konz
                                       ,pv_aktion_kdn_bby_konz
                                       ,pv_aktion_kdp_bby_konz
                                       ,pv_bonrabatt_bby_konz)
select ab.mandant_id
      ,ab.wup_id
      ,ab.nb_id
      ,a.wg_id
      ,a.arthiertyp_id
      ,ab.dat
      ,ab.bewart_id
      ,ab.posten_id
      ,ab.wrg_1
      ,sum(menge)
      ,sum(case when art.wg_art_fg = 0 then menge else 0 end) as menge_ohne_wg_erf_art
      ,sum(umsatz_netto)
      ,sum(diff_umsatz_netto_konz)
      ,sum(umsatz_mwst_betrag)
      ,sum(diff_umsatz_mwst_betrag_konz)
      ,sum(cast(ek_brutto as decimal(18,4)))
      ,sum(cast(diff_ek_brutto_konz as decimal(18,4)))
      ,sum(cast(ek_netto as decimal(18,4)))
      ,sum(cast(diff_ek_netto_konz as decimal(18,4)))
      ,sum(cast(ek_nettonetto as decimal(18,4)))
      ,sum(cast(diff_ek_nettonetto_konz as decimal(18,4)))
      ,sum(cast(ek_kal_basis as decimal(18,4)))
      ,sum(cast(diff_ek_kal_basis_konz as decimal(18,4)))
      ,sum(cast(ek_mep as decimal(18,4)))
      ,sum(cast(diff_ek_mep_konz as decimal(18,4)))
      ,sum(cast(einstandspreis as decimal(18,4)))
      ,sum(cast(diff_einstandspreis_konz as decimal(18,4)))
      ,sum(logkostenzuschlag)
      ,sum(diff_logkostenzuschlag_konz)
      ,sum(cast(ek_netto_bnk as decimal(18,4)))
      ,sum(cast(diff_ek_netto_bnk_konz as decimal(18,4)))
      ,sum(cast(ek_netto_bnk_sachk as decimal(18,4)))
      ,sum(cast(diff_ek_netto_bnk_sachk_konz as decimal(18,4)))
      ,bewart_det_id
      ,sum(pv_aktion)
      ,sum(pv_bby)
      ,sum(pv_kdn_bby)
      ,sum(pv_kdp_bby)
      ,sum(pv_aktion_bby)
      ,sum(pv_aktion_kdn_bby) 
      ,sum(pv_aktion_kdp_bby)
      ,sum(ek_gld)
      ,sum(diff_ek_gld_konz)
      ,sum(ek_mep_vor_fwu)
      ,sum(ek_mep_vor_fwu_konz)
      ,sum(bonusbasis)
      ,sum(bonusbasis_konz)
      ,sum(pv_bonrabatt_bby)
      ,ab.wup_bereinigt_fg
      ,max(umrechnungskurs_hist)
      ,sum(pv_aktion_konz)
      ,sum(pv_bby_konz)
      ,sum(pv_kdn_bby_konz)
      ,sum(pv_kdp_bby_konz)
      ,sum(pv_aktion_bby_konz)
      ,sum(pv_aktion_kdn_bby_konz)
      ,sum(pv_aktion_kdp_bby_konz)
      ,sum(pv_bonrabatt_bby_konz)
from dbp_data.artbew_1 ab
join (select mandant_id,wup_id,t.dat
      from (select mandant_id
                  ,wup_id
                  ,max(dat) as dat_max
                  ,min(dat) as dat_min
            from dbp_data.artbew_agg_wt_1
            group by 1,2) a
      join dbp_data.tag_1 t
        on t.dat between a.dat_min and a.dat_max
      group by 1,2,3) x
  on ab.mandant_id = x.mandant_id and
     ab.wup_id = x.wup_id and
     ab.dat = x.dat
join dbp_data.art_1 art_1
  on art.art_id = ab.art_id and
     art.mandant_id = ab.mandant_id and
     case 
       when ab.mandant_id = 2 and 
            ab.art_id = 208124500
       then 0
       when ab.mandant_id = 3 and 
            ab.art_id = 208113690
       then 0
       when ab.mandant_id = 5 and
            ab.art_id = 206731500
       then 0
       when ab.mandant_id = 6 and
            ab.art_id = 208131570
       then 0
       when ab.mandant_id in (4,7) and
            ab.art_id = 208114740
       then 0
       when ab.mandant_id = 8 and
            ab.art_id = 208131640
       then 0
       else 1 
     end = 1
join dbp_data.art_wg_zu_per_1 a
  on a.art_id = ab.art_id and
     a.mandant_id = ab.mandant_id and
     a.dat_bis = '9999-12-31' and
     a.arthiertyp_id = 2
group by ab.mandant_id,ab.wup_id,ab.nb_id,a.wg_id,a.arthiertyp_id,ab.dat,bewart_id,ab.posten_id,ab.wrg_1,bewart_det_id,ab.wup_bereinigt_fg
;
