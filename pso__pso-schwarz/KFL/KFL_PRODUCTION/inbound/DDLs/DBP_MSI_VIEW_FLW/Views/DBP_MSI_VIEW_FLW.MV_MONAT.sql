CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MONAT
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

)
AS
   SELECT kjmo, kjmo_vj, gjmo, gjmo_vj, kjqu, gjqu, kj, gj, akt_mo, akt_mo_komplett, akt_gjqu, akt_gjqu_komplett, akt_kjqu, akt_kjqu_komplett, akt_gj, akt_gj_komplett, akt_kj, akt_kj_komplett, mo_gj, mo_kj, min_dat, max_dat, 
   to_number(to_char(add_months(to_date(to_char(kjmo),'YYYYMM'),-1),'YYYYMM'),'FM000000')
   
   FROM dbp_view.v_monat;