update dbp_data.baustein_per_2 from (select *
                                   from dbp_etl.wsot_2) b
                                   
set baustein_bez = b.vtext

where dbp_data.baustein_per.mandant_id = 1 and
      dbp_data.baustein_per.baustein_id = b.skopf
;
