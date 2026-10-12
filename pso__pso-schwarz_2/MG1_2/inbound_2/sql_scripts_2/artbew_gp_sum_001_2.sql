delete from dbp_data.artbew_gp_sum_2
where dat = '1900-01-01' or 
      dat in (select dat from dbp_data.artbew_agg_wt_2 where mandant_id = 1 group by 1)
;

insert into dbp_data.artbew_gp_sum_2 (mandant_id
                                   ,gp_id
                                   ,vw_id
                                   ,dat
                                   ,wrg_2
                                   ,umrechnungskurs_hist
                                   ,umsatz_netto
                                   ,ek_mep)
select t1.mandant_id
      ,t1.gp_id
      ,t2.vw_id
      ,t1.dat
      ,t1.wrg_2
      ,t1.umrechnungskurs_hist
      ,sum(t1.umsatz_netto)  as umsatz_netto
      ,coalesce(sum(cast((t1.ek_mep) as decimal(18,4))),0) as ek_mep
from dbp_data.artbew_2 t1_2
join dbp_data.wup_2 t2
  on t1.wup_id = t2.wup_id and 
     t1.mandant_id = t2.mandant_id
where t1.mandant_id = 1 and 
     (t1.dat = '1900-01-01' or 
      t1.dat in (select dat from dbp_data.artbew_agg_wt_2 where mandant_id = 1 group by 1)) 
group by 1,2,3,4,5,6
;
