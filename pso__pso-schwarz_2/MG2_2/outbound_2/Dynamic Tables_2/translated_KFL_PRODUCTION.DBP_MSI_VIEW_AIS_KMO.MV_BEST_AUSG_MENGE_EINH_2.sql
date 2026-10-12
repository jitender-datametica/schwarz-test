/* 08.04.2022 sschuecke / NSR2831167 Erweiterung um Join auf dbp_data.einh_spr_zu_2, um MSI Schema korrigieren zu können */
CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_best_ausg_menge_einh_2 
options (
  enable_refresh = true,
  refresh_interval_minutes = 90,
  max_staleness = interval "1:30:0" hour to second,
  allow_non_incremental_definition = true
) as
select v01.mandant_id,
 v01.art_id,
 substr(cast(case
    when v01.best_menge_einh_id is null or
    v01.best_menge_einh_id = ''
    then 'st'
    else v01.best_menge_einh_id
    end as string), 1, 3) as best_menge_einh_id,
 coalesce(case
   when v02.umrech_faktor = 0
   then null
   else v02.umrech_faktor
   end, 1) as best_umrech_faktor,
 round(cast(1 / coalesce(case
      when v02.umrech_faktor = 0
      then null
      else v02.umrech_faktor
      end, 1) as numeric), 0) as best_menge_einh_inhalt,
 substr(cast(case
    when v03.ausg_menge_einh_id is null or
    v03.ausg_menge_einh_id = ''
    then 'st'
    else v03.ausg_menge_einh_id
    end as string), 1, 3) as ausg_menge_einh_id,
 coalesce(case
   when v04.umrech_faktor = 0
   then null
   else v04.umrech_faktor
   end, 1) as ausg_umrech_faktor,
 round(cast(1 / coalesce(case
      when v04.umrech_faktor = 0
      then null
      else v04.umrech_faktor
      end, 1) as numeric), 0) as ausg_menge_einh_inhalt,
 v05.einh_bez_kaufm
from kfl_production_dbp_view.v_art_2 as v01
 left join kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 as v02 on v01.mandant_id = v02.mandant_id and v01.art_id
     = v02.art_id and v01.best_menge_einh_id = v02.altnv_menge_einh_id and v02.dat_bis = date '9999-12-31'
 left join kfl_production_dbp_view.v_art_vorschlagswert_per_2 as v03 on v01.mandant_id = v03.mandant_id and v01.art_id =
    v03.art_id and v03.dat_bis = date '9999-12-31'
 left join kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 as v04 on v03.mandant_id = v04.mandant_id and v03.art_id
     = v04.art_id and v03.ausg_menge_einh_id = v04.altnv_menge_einh_id and v04.dat_bis = date '9999-12-31'
 left join kfl_production_dbp_view.v_einh_spr_zu_2 as v05 on v01.best_menge_einh_id = v05.einh_id and v03.ausg_menge_einh_id
      = v05.einh_id and v01.mandant_id = v05.mandant_id and v05.spr_id = 22
where v01.mandant_id <> 1;