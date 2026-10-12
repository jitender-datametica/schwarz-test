select mandant_id, von_wrg_id, wrg_id, dat_von, dat_bis, umrechnungskurs from dbp_data.mandant_wrg_zu_per group by 1,2,3,4,5,6 order by 1,4,5;
