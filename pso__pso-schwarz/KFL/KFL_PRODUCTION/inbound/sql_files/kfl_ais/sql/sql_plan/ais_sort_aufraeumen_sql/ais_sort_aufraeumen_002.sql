create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen where DAT_BIS='9999-12-31'
) ;

update dbp_etl.art_matching_nielsen_per from (select mandant_id,
                                                     max(kjwo_update) as max_kjwo
                                              from dbp_data.sortiment_leistung
                                              where mandant_id = 1
                                              group by 1) b

set kjwo_update = b.max_kjwo

where dbp_etl.art_matching_nielsen_per.mandant_id = b.mandant_id
;

-- 3rd check - dups on KLs inside SL?

create or replace volatile table _dup1 as (
select mandant_id,
       art_id,
       kjwo_update,
       count(distinct matching_id) as anz,
       max(matching_id) as max_match_id,
       min(matching_id) as min_match_id
from dbp_data.sortiment_leistung
where art_id is not null and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung)
group by 1,2,3
having anz > 1
);

delete from dbp_data.sortiment_leistung
where (mandant_id,art_id,kjwo_update) in (select mandant_id,art_id,kjwo_update from _dup1) and
      (mandant_id,art_id,matching_id) not in (select a.mandant_id,
                                                     a.art_id,
                                                     a.art_matching_id
                                              from dbp_etl.art_matching_nielsen_per a
                                              join _dup1 b
                                                on a.mandant_id = b.mandant_id and
                                                   a.art_id = b.art_id and
                                                   a.art_matching_id = b.max_match_id
                                              union
                                              select a.mandant_id,
                                                     a.art_id,
                                                     a.art_matching_id
                                              from dbp_etl.art_matching_nielsen_per a
                                              join _dup1 b
                                                on a.mandant_id = b.mandant_id and
                                                   a.art_id = b.art_id and
                                                   a.art_matching_id = b.min_match_id)
;

-- 4th check - SL without any dups, please!

create or replace volatile table _dup_free as (
select mandant_id
,kjmo
,matching_id
,kjwo_update
,max(kl_wg_id                                       )            kl_wg_id                      
,max(kl_owg_id                                      )            kl_owg_id                     
,max(kl_uwg_id                                      )            kl_uwg_id                     
,max(owg_id                                         )            owg_id                        
,max(wg_id                                          )            wg_id                         
,max(wug_id                                         )            wug_id                        
,max(rang_umsatz_wg                                 )            rang_umsatz_wg                
,max(rang_umsatz_uwg                                )            rang_umsatz_uwg               
,max(rang_absatz_uwg                                )            rang_absatz_uwg               
,max(art_id                                         )            art_id                        
,max(kl_art_id                                      )            kl_art_id                     
,max(art_bez                                        )            art_bez                       
,max(art_status                                     )            art_status                    
,max(gp_id                                          )            gp_id                         
,max(akt_lieferant                                  )            akt_lieferant                 
,max(disc_pe                                        )            disc_pe                       
,max(disc_marke                                     )            disc_marke                    
,max(lcf                                            )            lcf                           
,max(vegan                                          )            vegan                         
,max(gluten                                         )            gluten                        
,max(bio                                            )            bio                           
,max(eigenmarke                                     )            eigenmarke                    
,max(tierwohl                                       )            tierwohl                      
,max(posten_food                                    )            posten_food                   
,max(posten_nonfood                                 )            posten_nonfood                
,max(mwst                                           )            mwst                          
,max(listung_k_sst_mvke                             )            listung_k_sst_mvke            
,max(gewichtete_distribution                        )            gewichtete_distribution       
,max(index_af_id                                    )            index_af_id                   
,max(umsatz_af_pro_markt_woche                      )            umsatz_af_pro_markt_woche     
,max(absatz_af_pro_markt_woche                      )            absatz_af_pro_markt_woche     
,max(ertrag_af_pro_markt_woche                      )            ertrag_af_pro_markt_woche     
,max(bonreichweite_af                               )            bonreichweite_af              
,max(spanne_af                                      )            spanne_af                     
,max(index_sa_id                                    )            index_sa_id                   
,max(umsatz_sa_pro_markt_woche                      )            umsatz_sa_pro_markt_woche     
,max(absatz_sa_pro_markt_woche                      )            absatz_sa_pro_markt_woche     
,max(ertrag_sa_pro_markt_woche                      )            ertrag_sa_pro_markt_woche     
,max(bonreichweite_sa                               )            bonreichweite_sa              
,max(spanne_sa                                      )            spanne_sa                     
,max(aktionsanteil_absatz                           )            aktionsanteil_absatz          
,max(absatz_total                                   )            absatz_total                  
,max(schnelldreherquote                             )            schnelldreherquote            
,max(schnelldreherquote_wg                          )            schnelldreherquote_wg         
,max(schnelldreherquote_owg                         )            schnelldreherquote_owg        
,max(kolliabverkaufsquote                           )            kolliabverkaufsquote          
,max(kolliabverkaufsquote_wg                        )            kolliabverkaufsquote_wg       
,max(kolliabverkaufsquote_owg                       )            kolliabverkaufsquote_owg      
,max(abschriftsanteil                               )            abschriftsanteil              
,max(abschriftsanteil_wg                            )            abschriftsanteil_wg           
,max(abschriftsanteil_owg                           )            abschriftsanteil_owg          
,max(cherrypicker_quote                             )            cherrypicker_quote            
,max(cherrypicker_quote_wg                          )            cherrypicker_quote_wg         
,max(cherrypicker_quote_owg                         )            cherrypicker_quote_owg        
,max(restbon                                        )            restbon                       
,max(restbon_wg                                     )            restbon_wg                    
,max(restbon_owg                                    )            restbon_owg                   
,max(vk_preis                                       )            vk_preis                      
,max(durchschnittspreis                             )            durchschnittspreis            
,max(preislagenverteilung                           )            preislagenverteilung          
,max(marktanteilbewertung                           )            marktanteilbewertung          
,max(produktwissen_vp                               )            produktwissen_vp              
,max(lieferantenwissen_vp                           )            lieferantenwissen_vp          
,max(produktwissen_pflege                           )            produktwissen_pflege          
,max(lieferantenwissen_pflege                       )            lieferantenwissen_pflege      
,max(listung_sst_pflege                             )            listung_sst_pflege            
,max(ost_basis_pflege                               )            ost_basis_pflege              
,max(ost_gross_pflege                               )            ost_gross_pflege              
,max(sued_ost_pflege                                )            sued_ost_pflege               
,max(sued_west_pflege                               )            sued_west_pflege              
,max(west_pflege                                    )            west_pflege                   
,max(nord_pflege                                    )            nord_pflege                   
,max(vorschlag                                      )            vorschlag                     
,max(stk_re_pflege                                  )            stk_re_pflege                 
,max(umsatz_hr                                      )            umsatz_hr                     
,max(absatz_hr                                      )            absatz_hr                     
,max(rohertrag_hr                                   )            rohertrag_hr                  
,max(nielsen_art_bez                                )            nielsen_art_bez               
,max(gtin                                           )            gtin                          
,max(distr_gew                                      )            distr_gew                     
,max(umsatz_anteil_uwg                              )            umsatz_anteil_uwg             
,max(umsatz_anteil_uwg_kumuliert                    )            umsatz_anteil_uwg_kumuliert   
,max(durchschnitt_anz_maerkte                       )            durchschnitt_anz_maerkte      
,max(durchschnitt_preis                             )            durchschnitt_preis            
,max(kl_markt_anteil_owg                            )            kl_markt_anteil_owg           
,max(umsatz_artikel                                 )            umsatz_artikel                
,max(absatz_artikel                                 )            absatz_artikel                
,max(anz_monate                                     )            anz_monate                    
,max(anz_wochen                                     )            anz_wochen                    
,max(eigenmarke_fg                                  )            eigenmarke_fg                 
,max(listung_sst_mvke                               )            listung_sst_mvke              
,max(ost_basis                                      )            ost_basis                     
,max(ost_gross                                      )            ost_gross                     
,max(sued_ost                                       )            sued_ost                      
,max(sued_west                                      )            sued_west                     
,max(west                                           )            west                          
,max(nord                                           )            nord                          
,max(anz_maerkte_sst                                )            anz_maerkte_sst               
,max(anz_maerkte_baustein_sonstige                  )            anz_maerkte_baustein_sonstige 
,max(anz_maerkte_listung_einzel                     )            anz_maerkte_listung_einzel    
,max(anz_maerkte_listung_gesamt                     )            anz_maerkte_listung_gesamt    
,max(listungsaktion                                 )            listungsaktion                
,max(anz_maerkte_k_sst                              )            anz_maerkte_k_sst             
,max(listung_k_sst_pflege                           )            listung_k_sst_pflege          
,max(muki_wb_kz                                     )            muki_wb_kz                    
,max(muki_wb_kl_art_id_verkettung                   )            muki_wb_kl_art_id_verkettung  
,max(muki_vk_kz                                     )            muki_vk_kz                    
,max(muki_vk_kl_art_id_verkettung                   )            muki_vk_kl_art_id_verkettung  
,max(muki_ek_kz                                     )            muki_ek_kz                    
,max(muki_ek_kl_art_id_verkettung                   )            muki_ek_kl_art_id_verkettung  
,max(absatz_total_vj                                )            absatz_total_vj               
,max(max_anz_maerkte_sst                            )            max_anz_maerkte_sst           
,max(max_anz_maerkte_k_sst                          )            max_anz_maerkte_k_sst         
,max(kassenumsatz_kl_absolut_brutto                 )            kassenumsatz_kl_absolut_brutto
,max(kassenumsatz_kl_absolut_netto                  )            kassenumsatz_kl_absolut_netto 
,max(abschriften_wert_netto_absolut                 )            abschriften_wert_netto_absolut
,max(td_insert) td_insert
,max(td_update) td_update
,max(zek_id                                         )            zek_id                        
,max(wrg_id                                         )            wrg_id                        
from dbp_data.sortiment_leistung
where (mandant_id,kjwo_update,matching_id) in (select mandant_id,
                                                      kjwo_update,
                                                      matching_id
                                               from dbp_data.sortiment_leistung
                                               where kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung)
                                               group by 1,2,3
                                               having count(*) > 1)
group by 1,2,3,4
);

delete from dbp_data.sortiment_leistung
where (mandant_id,kjwo_update,matching_id) in (select mandant_id,kjwo_update,matching_id from _dup_free)
;

insert into dbp_data.sortiment_leistung
select *
from _dup_free
;

delete from dbp_etl_process.hadoop_art_matching_nielsen_per;
insert into dbp_etl_process.hadoop_art_matching_nielsen_per
select *
from dbp_etl.art_matching_nielsen_per
;

delete from dbp_etl_process.hadoop_art_matching_nielsen_per_kmo;
insert into dbp_etl_process.hadoop_art_matching_nielsen_per_kmo
select *
from dbp_etl.art_matching_nielsen_per_kmo
;
