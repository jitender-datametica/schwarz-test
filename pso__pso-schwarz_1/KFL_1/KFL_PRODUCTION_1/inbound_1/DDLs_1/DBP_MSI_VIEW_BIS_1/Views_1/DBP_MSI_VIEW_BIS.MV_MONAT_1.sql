CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_MONAT_1
--11.01.2013 SHoger initial
--14.10.2015 twie: gjmo_vm ergänzt

(
kjmo
,kjmo_vj
,gjmo
,gjmo_vj
,kjqu
,gjqu
,kj
,gj
,akt_mo
,akt_mo_komplett
,akt_gjqu
,akt_gjqu_komplett
,akt_kjqu
,akt_kjqu_komplett
,akt_gj
,akt_gj_komplett
,akt_kj
,akt_kj_komplett
,mo_gj
,mo_kj
,min_dat
,max_dat
,kjmo_vm
,gjmo_vm
)

AS
SELECT kjmo
,kjmo_vj
,gjmo
,gjmo_vj
,kjqu
,gjqu
,kj
,gj
,akt_mo
,akt_mo_komplett
,akt_gjqu
,akt_gjqu_komplett
,akt_kjqu
,akt_kjqu_komplett
,akt_gj
,akt_gj_komplett
,akt_kj
,akt_kj_komplett
,mo_gj
,mo_kj
,min_dat
,max_dat
,to_number(to_varchar(add_months(to_date(to_char(kjmo),'YYYYMM'),-1),'YYYYMM')) as kjmo_vm
--,ADD_MONTHS(CAST(kjmo*100-19000000+1 AS DATE),-1)/100 + 190000 AS kjmo_vm
,to_number(to_varchar(add_months(to_date(to_char(gjmo),'YYYYMM'),-1),'YYYYMM')) as gjmo_vm
--,ADD_MONTHS(CAST(gjmo*100-19000000+1 AS DATE),-1)/100 + 190000 AS gjmo_vm 
FROM dbp_view.v_monat_1
;