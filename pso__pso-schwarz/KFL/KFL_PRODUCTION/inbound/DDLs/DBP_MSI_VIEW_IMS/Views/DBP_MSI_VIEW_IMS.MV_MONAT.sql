CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_MONAT
--23.05.2013 AL initial

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
   SELECT kjmo,
   kjmo_vj,
   gjmo,
   gjmo_vj,
   kjqu,
   gjqu,
   kj,
   gj,
   akt_mo,
   akt_mo_komplett,
   akt_gjqu,
   akt_gjqu_komplett,
   akt_kjqu,
   akt_kjqu_komplett,
   akt_gj,
   akt_gj_komplett,
   akt_kj,
   akt_kj_komplett,
   mo_gj,
   mo_kj,
   min_dat,
   max_dat,
   TO_NUMBER(TO_CHAR(DATEADD(MONTH,-1,TO_DATE(TO_CHAR(kjmo),'YYYYMM')),'YYYYMM'))
   FROM  dbp_view.v_monat;