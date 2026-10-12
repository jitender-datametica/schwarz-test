create or replace volatile table _tage_art_gp_nm_zu_per as (
select dat
from dbp_data.tag_2
where dat between (select min(dat) from dbp_etl.zeitraum_fww_kmo_gld_2) and (select max(dat) from dbp_etl.zeitraum_fww_kmo_gld_2)
);

create or replace table dbp_etl.art_gp_nm_zu_per_fww_2 as (
select a.mandant_id,
       b.dat,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.gp_id
from (select *
      from dbp_data.art_gp_nm_zu_per_2
      where dat_bis >= (select min(dat) from dbp_etl.zeitraum_fww_kmo_gld_2)) a
join _tage_art_gp_nm_zu_per b
  on b.dat between a.dat_von and a.dat_bis
);
