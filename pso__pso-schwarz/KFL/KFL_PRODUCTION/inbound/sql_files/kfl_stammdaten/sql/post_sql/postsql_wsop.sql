delete from dbp_etl.wsop
where skopf = 0
;

update dbp_etl.wsop from (select stueckliste_id,
                                 art_id,
                                 dat_von,
                                 dat_bis
                          from dbp_data.stueckliste
                          where mandant_id = 1
                          group by 1,2,3,4) b
                          
set stcklst = b.stueckliste_id

where dbp_etl.wsop.sposi = floor(b.art_id/100) and
      dbp_etl.wsop.datuv between b.dat_von and b.dat_bis
;

update dbp_etl.wsop from (select *
                          from dbp_data.art
                          where mandant_id = 1 and
                                artikeltyp_id = 12) b
                          
set akz = 'D'

where dbp_etl.wsop.sposi = floor(b.art_id/100) and
      dbp_etl.wsop.stcklst <> 0
;

update dbp_etl.wsop set akz = 'K'
where stcklst <> 0 and
      akz <> 'D'
;

delete from dbp_data.baustein_art_zu_per
where (mandant_id,baustein_id,art_id,dat_bis) in (select man.mandant_id
                                                        ,skopf
                                                        ,art.art_id
                                                        ,datub
                                                  from dbp_etl.wsop
                                                  join dbp_data.mandant man
                                                    on man.mandant_sap_id = wsop.mandt
                                                  join (select kl_art_id,
                                                               mandant_id,
                                                               max(art_id) as art_id
                                                        from dbp_data.art
                                                        group by 1,2) art
                                                    on art.kl_art_id = wsop.sposi and
                                                       art.mandant_id = man.mandant_id)
;

insert into dbp_data.baustein_art_zu_per (mandant_id
                                         ,baustein_id
                                         ,art_id
                                         ,dat_von
                                         ,dat_bis
                                         ,stueckliste_id
                                         ,akz_id)
select mandant_id
      ,baustein_id
      ,art_id
      ,dat_von
      ,max(dat_bis)
      ,stueckliste_id
      ,akz_id
from (select man.mandant_id
            ,skopf as baustein_id
            ,art.art_id as art_id
            ,datuv as dat_von
            ,datub as dat_bis
            ,stcklst as stueckliste_id
            ,akz as akz_id
      from dbp_etl.wsop
      join dbp_data.mandant man
        on man.mandant_sap_id = wsop.mandt
      join (select kl_art_id,
                   mandant_id,
                   max(art_id) as art_id
            from dbp_data.art
            group by 1,2) art
        on art.kl_art_id = wsop.sposi and
           art.mandant_id = man.mandant_id
      where lvorm  <> 'X')
group by 1,2,3,4,6,7
;

