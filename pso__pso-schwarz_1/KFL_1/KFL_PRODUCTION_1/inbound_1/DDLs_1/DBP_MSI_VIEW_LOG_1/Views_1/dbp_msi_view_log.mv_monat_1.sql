CREATE OR REPLACE VIEW dbp_msi_view_log.mv_monat_1
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 gjmo
,gjmo_vj
,mo_gj
,kjmo
,kjmo_vj
,mo_kj
,akt_mo
,akt_mo_komplett
,gjqu
,akt_gjqu
,akt_gjqu_komplett
,kjqu
,akt_kjqu
,akt_kjqu_komplett
,gj, akt_gj
,akt_gj_komplett
,kj
,akt_kj
,akt_kj_komplett
,kjmo_vm
,max_dat
)
AS
SELECT
v01.gjmo,
v01.gjmo_vj,
v01.mo_gj,
v01.kjmo,
v01.kjmo_vj,
v01.mo_kj,
v01.akt_mo,
v01.akt_mo_komplett,
v01.gjqu,
v01.akt_gjqu,
v01.akt_gjqu_komplett,
v01.kjqu,
v01.akt_kjqu,
v01.akt_kjqu_komplett,
v01.gj,
v01.akt_gj,
v01.akt_gj_komplett,
v01.kj,
v01.akt_kj,
v01.akt_kj_komplett,
--Add_Months(Cast(v01.kjmo*100-19000000+1 AS DATE), -1)/100 + 190000,

to_number(to_char(add_months(to_date(to_char(V01.KJMO),'YYYYMM'),-1),'YYYYMM')),


v01.max_dat
FROM dbp_view.v_monat_1 v01
WHERE v01.kjmo >= 200312;