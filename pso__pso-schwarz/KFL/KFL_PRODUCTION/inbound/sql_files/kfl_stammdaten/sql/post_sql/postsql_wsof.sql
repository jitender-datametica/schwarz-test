delete from dbp_etl.wsof
where filiale in (3142,4112,4132,4182,4202,4252,4372,5400,6420,6912,6914,9002)
;

delete from dbp_etl.wsof
where skopf = 0
;

delete from dbp_data.baustein_wup_zu_per
where (mandant_id,baustein_id,wup_id,nb_id,dat_bis) in (select man.mandant_id
                                                              ,skopf
                                                              ,filiale
                                                              ,wup.nb_id
                                                              ,datub
                                                        from dbp_etl.wsof
                                                        join dbp_data.mandant as man
                                                          on man.mandant_sap_id = wsof.mandt
                                                        join dbp_data.wup as wup
                                                          on wup.mandant_id = man.mandant_id and 
                                                             wup.wup_id = wsof.filiale)
;

insert into dbp_data.baustein_wup_zu_per (mandant_id
                                         ,baustein_id
                                         ,wup_id
                                         ,nb_id
                                         ,dat_von
                                         ,dat_bis)
select mandant_id
      ,baustein_id
      ,wup_id
      ,nb_id
      ,dat_von
      ,max(dat_bis)
from (select man.mandant_id
            ,skopf as baustein_id
            ,filiale as wup_id
            ,wup.nb_id
            ,datuv as dat_von
            ,datub as dat_bis
      from dbp_etl.wsof
      join dbp_data.mandant as man
        on man.mandant_sap_id = wsof.mandt
      join dbp_data.wup as wup
        on wup.mandant_id = man.mandant_id and 
           wup.wup_id = wsof.filiale
      where lvorm <> 'X')
group by 1,2,3,4,5
;
