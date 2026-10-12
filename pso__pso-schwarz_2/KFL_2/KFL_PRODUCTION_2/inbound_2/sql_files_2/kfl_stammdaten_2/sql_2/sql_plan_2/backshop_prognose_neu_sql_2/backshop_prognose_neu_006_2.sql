create or replace volatile table _update as (
select b.mandant_id,
       b.wup_id,
       b.nb_id,
       b.art_id,
       b.dat,
       max(a.aktion_id) as aktion_id_
from dbp_data.aktion_art_wup_zu_2 a
join (select a.*,
             b.kjwo
      from dbp_msi_data.backshop_prognose_neu_2 a
      join dbp_data.tag_2 b
        on a.dat = b.dat
      where b.kjwo in (select max(x.kjwo) from (select a.*,b.kjwo from dbp_msi_data.backshop_prognose_neu_2 a join dbp_data.tag_2 b on a.dat = b.dat) x)) b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id 
join dbp_data.aktion_2 c
  on a.mandant_id = c.mandant_id and
     a.aktion_id = c.aktion_id and
     b.dat between c.dat_von and c.dat_bis
where a.grund_sperrung is null and
      case
        when c.mandant_id = 1
        then c.preisaktiviert_fg
        when c.mandant_id > 1 and
             a.dat_preisaktiviert <> '1900-01-01' and
            (c.mandant_id,c.aktion_id) not in (select mandant_id,aktion_id
                                               from dbp_data.l_bonuskauf_2)
        then 1
        else 0
      end = 1
group by all
);

update dbp_msi_data.backshop_prognose_neu_2 from (select *
                                                from _update) b

set aktion_id = b.aktion_id_
						  
where dbp_msi_data.backshop_prognose_neu.mandant_id = b.mandant_id and
      dbp_msi_data.backshop_prognose_neu.wup_id = b.wup_id and
      dbp_msi_data.backshop_prognose_neu.nb_id = b.nb_id and
      dbp_msi_data.backshop_prognose_neu.art_id = b.art_id and
      dbp_msi_data.backshop_prognose_neu.dat = b.dat and
      dbp_msi_data.backshop_prognose_neu.aktion_id <> b.aktion_id_
;
