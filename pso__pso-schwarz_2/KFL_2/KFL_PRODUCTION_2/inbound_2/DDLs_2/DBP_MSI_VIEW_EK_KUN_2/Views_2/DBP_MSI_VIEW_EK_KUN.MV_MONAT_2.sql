CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_MONAT_2
AS
SELECT
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
,gjhj
FROM dbp_view.v_monat_2
;