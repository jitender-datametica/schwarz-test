CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_MONAT_2 as
 -- ZEIT_2-Hierachie Monat_2
 -- 2009KW47: Review
 -- 2013KW04: Erweiterung 11 Jahre (historische Umsatzdaten)
 -- 2018.0822 : Erweiterung GJ-Halbjahr (ohne akt.)
 -- 2020.0121 : TEKU/JOIN hidden. GJ HJ (DELETED)

SELECT
  v01.kjmo
, v01.kjmo_vj
, v01.kj
, v01.mo_kj
, v01.gj
, v01.mo_gj
, v01.gjmo
, v01.gjmo_vj
, v01.kjqu
, v01.gjqu
  -- aktuell
, v01.akt_mo
, v01.akt_mo_komplett
, v01.akt_gj
, v01.akt_gj_komplett
, v01.akt_kj
, v01.akt_kj_komplett
, v01.akt_kjqu
, v01.akt_kjqu_komplett
, v01.akt_gjqu
, v01.akt_gjqu_komplett
, v01.min_dat AS mo_dat_von
, v01.max_dat AS mo_dat_bis
,to_number(to_varchar(add_months(to_date(to_char(kjmo),'YYYYMM'),-1),'YYYYMM')) as kjmo_vm
,to_number(to_varchar(add_months(to_date(to_char(kjmo),'YYYYMM'),-2),'YYYYMM')) as kjmo_vvm
--, Add_Months(Cast(v01.kjmo*100-19000000+1 AS DATE),-1)/100 + 190000   AS kjmo_vm
--, Add_Months(Cast(v01.kjmo*100-19000000+1 AS DATE),-2)/100 + 190000   AS kjmo_vvm

  -- Teku: akt. Monat_2 schaltet erst am 5. des Folgemonats um
, v01.akt_mo AS akt_mo_teku -- v01.akt_mo + v02.summand   AS akt_mo_teku

FROM dbp_view.v_monat_2  v01
/*CROSS JOIN (
  SELECT dat, CASE WHEN Extract (DAY From dat) <= 4 THEN 1 ELSE 0 END summand
  FROM dbp_view.v_tag_2
  WHERE akt_tag = 0
) v02*/
WHERE v01.akt_gj BETWEEN -11 AND 1;