create or replace volatile table _artbew_agg_woche (
  dat date not null,
  mandant_id byteint not null,
  wup_id integer not null,
  nb_id smallint not null,
  kjwo_kl integer not null
);

insert into _artbew_agg_woche (dat
                              ,mandant_id
                              ,wup_id
                              ,nb_id
                              ,kjwo_kl)
select c.dat,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       c.kjwo_kl
from dbp_data.artbew_agg_wt_1 a
join dbp_data.tag_1 b
  on a.dat = b.dat
join dbp_data.tag_1 c
  on b.kjwo_kl = c.kjwo_kl
group by 1,2,3,4,5
;

delete from dbp_data.artbew_wo_sum_1
where (mandant_id,wup_id,nb_id,kjwo_kl) in (select mandant_id,wup_id,nb_id,kjwo_kl from _artbew_agg_woche) and 
      (kjwo_kl, mandant_id) in (select kjwo_kl,mandant_id from _artbew_agg_woche)
;

insert into dbp_data.artbew_wo_sum_1 (kjwo_kl
                                   ,mandant_id
                                   ,wup_id
                                   ,nb_id
                                   ,art_id
                                   ,bewart_id
                                   ,ean_kasse
                                   ,promo_fg
                                   ,herst_id
                                   ,gp_id
                                   ,aktion_id
                                   ,standard_aktion_id
                                   ,bezugsweg_id
                                   ,menge
                                   ,umsatz_netto
                                   ,diff_umsatz_netto_konz
                                   ,umsatz_mwst_betrag
                                   ,diff_umsatz_mwst_betrag_konz
                                   ,ek_nettonetto
                                   ,diff_ek_nettonetto_konz
                                   ,ek_mep
                                   ,einstandspreis
                                   ,diff_einstandspreis_konz
                                   ,wrg_id
                                   ,bewart_det_id     
                                   ,pv_aktion        
                                   ,pv_bby           
                                   ,pv_kdn_bby       
                                   ,pv_kdp_bby       
                                   ,pv_aktion_bby    
                                   ,pv_aktion_kdn_bby
                                   ,pv_aktion_kdp_bby
                                   ,diff_ek_brutto_konz
                                   ,diff_ek_gld_konz
                                   ,diff_ek_kal_basis_konz
                                   ,diff_ek_mep_konz
                                   ,diff_ek_netto_bnk_konz
                                   ,diff_ek_netto_bnk_sachk_konz
                                   ,diff_ek_netto_konz
                                   ,diff_logkostenzuschlag_konz
                                   ,ek_brutto
                                   ,ek_gld
                                   ,ek_kal_basis
                                   ,ek_netto
                                   ,ek_netto_bnk
                                   ,ek_netto_bnk_sachk
                                   ,logkostenzuschlag
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
select b.kjwo_kl,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_id,
       a.ean_kasse,
       a.promo_fg,
       max(a.herst_id) as herst_id,
       a.gp_id,
       a.aktion_id,
       a.standard_aktion_id,
       coalesce(a.bezugsweg_id, -1) as bezugsweg_id,
       sum(coalesce(a.menge,0)) as menge,
       sum(coalesce(a.umsatz_netto,0)) as umsatz_netto,
       sum(coalesce(a.diff_umsatz_netto_konz,0)) as diff_umsatz_netto_konz,
       sum(coalesce(a.umsatz_mwst_betrag,0)) as umsatz_mwst_betrag,
       sum(coalesce(a.diff_umsatz_mwst_betrag_konz,0)) as diff_umsatz_mwst_betrag_konz,
       sum(coalesce(cast( (a.ek_nettonetto             ) as decimal(18,4)),0)) as ek_nettonetto,
       sum(coalesce(cast( (a.diff_ek_nettonetto_konz   ) as decimal(18,4)),0)) as diff_ek_nettonetto_konz,
       sum(coalesce(cast( (a.ek_mep                    ) as decimal(18,4)),0)) as ek_mep,
       sum(coalesce(cast( (a.einstandspreis            ) as decimal(18,4)),0)) as einstandspreis,
       sum(coalesce(cast( (a.diff_einstandspreis_konz  ) as decimal(18,4)),0)) as diff_einstandspreis_konz,
       coalesce(a.wrg_1, c.default_wrg) as wrg_id,
       a.bewart_det_id,                                          
       sum(coalesce(a.pv_aktion,0)) as pv_aktion,                
       sum(coalesce(a.pv_bby,0)) as pv_bby,                      
       sum(coalesce(a.pv_kdn_bby,0)) as pv_kdn_bby,              
       sum(coalesce(a.pv_kdp_bby,0)) as pv_kdp_bby,              
       sum(coalesce(a.pv_aktion_bby,0)) as pv_aktion_bby,        
       sum(coalesce(a.pv_aktion_kdn_bby,0)) as pv_aktion_kdn_bby,
       sum(coalesce(a.pv_aktion_kdp_bby,0)) as pv_aktion_kdp_bby,
       sum(coalesce(a.diff_ek_brutto_konz,0)),
       sum(coalesce(a.diff_ek_gld_konz,0)),
       sum(coalesce(a.diff_ek_kal_basis_konz,0)),
       sum(coalesce(a.diff_ek_mep_konz,0)),
       sum(coalesce(a.diff_ek_netto_bnk_konz,0)),
       sum(coalesce(a.diff_ek_netto_bnk_sachk_konz,0)),
       sum(coalesce(a.diff_ek_netto_konz,0)),
       sum(coalesce(a.diff_logkostenzuschlag_konz,0)),
       sum(coalesce(a.ek_brutto,0)),
       sum(coalesce(a.ek_gld,0)),
       sum(coalesce(a.ek_kal_basis,0)),
       sum(coalesce(a.ek_netto,0)),
       sum(coalesce(a.ek_netto_bnk,0)),
       sum(coalesce(a.ek_netto_bnk_sachk,0)),
       sum(coalesce(a.logkostenzuschlag,0)),
       sum(coalesce(a.ek_mep_vor_fwu,0)),
       sum(coalesce(a.ek_mep_vor_fwu_konz,0)),
       sum(coalesce(a.bonusbasis,0)),
       sum(coalesce(a.bonusbasis_konz,0)),
       sum(coalesce(a.pv_bonrabatt_bby,0)),
       a.wup_bereinigt_fg,
       max(a.umrechnungskurs_hist),
       sum(coalesce(a.pv_aktion_konz,0)),
       sum(coalesce(a.pv_bby_konz,0)),
       sum(coalesce(a.pv_kdn_bby_konz,0)),
       sum(coalesce(a.pv_kdp_bby_konz,0)),
       sum(coalesce(a.pv_aktion_bby_konz,0)),
       sum(coalesce(a.pv_aktion_kdn_bby_konz,0)),
       sum(coalesce(a.pv_aktion_kdp_bby_konz,0)),
       sum(coalesce(a.pv_bonrabatt_bby_konz,0))
from dbp_data.artbew_1 a
join _artbew_agg_woche b
  on a.mandant_id = b.mandant_id and
     a.wup_id     = b.wup_id     and
     a.nb_id      = b.nb_id      and
     a.dat        = b.dat
left join dbp_data.mandant_1 c
  on a.mandant_id = c.mandant_id
group by 1,2,3,4,5,6,7,8,10,11,12,13,24,25,53
;

insert into dbp_etl_process.ekc_artbew_agg_wt_1 (mandant_id
                                              ,wup_id
                                              ,nb_id
                                              ,dat)
select mandant_id
      ,wup_id
      ,nb_id
      ,dat
from dbp_data.artbew_agg_wt_1
where (mandant_id,wup_id,nb_id,dat) not in (select mandant_id,wup_id,nb_id,dat from dbp_etl_process.ekc_artbew_agg_wt_1)
group by 1,2,3,4
;

delete from dbp_data.artbew_agg_wt_1
;
