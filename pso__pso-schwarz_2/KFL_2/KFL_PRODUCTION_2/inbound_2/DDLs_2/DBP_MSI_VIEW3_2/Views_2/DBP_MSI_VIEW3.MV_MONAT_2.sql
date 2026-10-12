CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_MONAT_2
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
,kjqu, akt_kjqu
,akt_kjqu_komplett
,gj
,akt_gj
,akt_gj_komplett
,kj
,akt_kj
,akt_kj_komplett
,kjmo_vm
,max_dat
)
AS SELECT
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
,gj
,akt_gj
,akt_gj_komplett
,kj
,akt_kj
,akt_kj_komplett
,to_number(to_char(add_months(to_date(to_char(KJMO),'YYYYMM'),+1),'YYYYMM'))
,max_dat
FROM dbp_view.v_monat_2
WHERE kjmo>=200312;