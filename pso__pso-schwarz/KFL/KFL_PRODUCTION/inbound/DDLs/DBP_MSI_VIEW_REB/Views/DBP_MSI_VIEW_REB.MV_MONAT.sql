CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_MONAT
(
gjmo
, gjmo_vj
, mo_gj
, kjmo
, kjmo_vj
, mo_kj
, akt_mo
, akt_mo_komplett
, gjqu
, akt_gjqu
, akt_gjqu_komplett
, kjqu
, akt_kjqu
, akt_kjqu_komplett
, gj
, akt_gj
, akt_gj_komplett
, kj
, akt_kj
, akt_kj_komplett
, kjmo_vm
, akt_mo_kalendarisch
)
AS
   SELECT
   gjmo,
   gjmo_vj,
   mo_gj,
   kjmo,
   kjmo_vj,
   mo_kj,
   akt_mo,
   akt_mo_komplett,
   gjqu,
   akt_gjqu,
   akt_gjqu_komplett,
   kjqu,
   akt_kjqu,
   akt_kjqu_komplett,
   gj,
   akt_gj,
   akt_gj_komplett,
   kj,
   akt_kj,
   akt_kj_komplett,  
   to_number(to_char(add_months(to_date(to_char(kjmo),'YYYYMM'),-1),'YYYYMM'),'FM000000'),
   (kj-EXTRACT(YEAR FROM CURRENT_DATE))*12+(MOD(kjmo, 100))-EXTRACT(MONTH FROM CURRENT_DATE)
   FROM dbp_view.v_monat
   ;