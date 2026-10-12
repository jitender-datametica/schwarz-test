update dbp_data.werbewoche_kl_1 set angepasste_kjwo_ww = kjwo_ww
where mandant_id = 1
;

update dbp_data.werbewoche_kl_1 from (select *
                                    from dbp_etl_process.werbewoche_real_manuell_1) b
                                                
set angepasste_kjwo_ww = b.kjwo_ww

where dbp_data.werbewoche_kl.mandant_id = b.mandant_id and
      dbp_data.werbewoche_kl.dat = b.dat
;
