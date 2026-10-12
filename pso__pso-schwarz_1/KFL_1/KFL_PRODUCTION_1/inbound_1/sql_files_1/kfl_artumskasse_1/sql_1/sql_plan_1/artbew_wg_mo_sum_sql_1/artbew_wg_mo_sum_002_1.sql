delete from dbp_data.artbew_wg_mo_sum_1 
where (mandant_id,kjmo) in (select mandant_id,kjmo
                            from (select mandant_id,
                                         cast(to_varchar(max(dat), 'yyyymm') as integer) as max_kjmo,
                                         cast(to_varchar(min(dat), 'yyyymm') as integer) as min_kjmo
                                  from dbp_data.artbew_agg_wt_1
                                  group by mandant_id) a
	                          join dbp_data.tag_1 t
	                            on t.kjmo between a.min_kjmo and a.max_kjmo
	                          group by 1,2)
;

insert into dbp_data.artbew_wg_mo_sum_1 (arthiertyp_id
                                      ,bewart_id 
                                      ,wg_id 
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
                                      ,pv_bonrabatt_bby_konz)
select arthiertyp_id 
      ,bewart_id 
      ,wg_id 
      ,wup_id 
      ,posten_id 
      ,mandant_id 
      ,nb_id 
      ,cast(to_varchar(dat, 'yyyymm') as integer) as kjmo
      ,wrg_id
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
      ,sum(einstandspreis) 
      ,sum(diff_einstandspreis_konz) 
      ,sum(logkostenzuschlag) 
      ,sum(diff_logkostenzuschlag_konz) 
      ,sum(ek_netto_bnk) 
      ,sum(diff_ek_netto_bnk_konz) 
      ,sum(ek_netto_bnk_sachk) 
      ,sum(diff_ek_netto_bnk_sachk_konz) 
      ,bewart_det_id
      ,max(umrechnungskurs_hist)
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
      ,sum(pv_aktion_konz)
      ,sum(pv_bby_konz)
      ,sum(pv_kdn_bby_konz)
      ,sum(pv_kdp_bby_konz)
      ,sum(pv_aktion_bby_konz)
      ,sum(pv_aktion_kdn_bby_konz)
      ,sum(pv_aktion_kdp_bby_konz)
      ,sum(pv_bonrabatt_bby_konz)
from dbp_data.artbew_wg_tp2_sum_1 
where (mandant_id,dat) in (select mandant_id,dat
                           from (select mandant_id,  
                                        cast(to_varchar(min(dat), 'yyyy-mm_1' || '-01') as date) as dat_von,
                                        add_months(cast(to_varchar(max(dat), 'yyyy-mm_1' || '-01') as date),1)-1 as dat_bis
                                 from dbp_data.artbew_agg_wt_1 
                                 group by 1) a                             
                           join dbp_data.tag_1 t                                                     
                             on t.dat between dat_von and dat_bis
                           group by 1,2) and 
       arthiertyp_id = 2  
group by bewart_id,bewart_det_id,arthiertyp_id,wg_id,wup_id,posten_id,mandant_id,nb_id,kjmo,wrg_id
;
