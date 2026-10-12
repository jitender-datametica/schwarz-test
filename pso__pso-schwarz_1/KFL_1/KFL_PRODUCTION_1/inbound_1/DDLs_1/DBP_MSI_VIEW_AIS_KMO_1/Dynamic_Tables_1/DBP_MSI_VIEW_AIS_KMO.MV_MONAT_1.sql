CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_MONAT_1
(
 kjmo
,gjmo
,gjmo_vj
, kjmo_vj
, mo_kj
, akt_mo
, akt_mo_komplett
, kjqu
,gjqu
, akt_kjqu
, akt_kjqu_komplett
, kj
, gj
, akt_kj
, akt_kj_komplett
,akt_gj
, kjmo_vm
, akt_mo_kalendarisch
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   kjmo,
   gjmo,
   gjmo_vj,
   kjmo_vj,
   mo_kj,
   akt_mo,
   akt_mo_komplett,
   kjqu,
   gjqu,
   akt_kjqu,
   akt_kjqu_komplett,
   kj,
   gj,
   akt_kj,
   akt_kj_komplett,
   akt_gj,
   TO_NUMBER(TO_CHAR(ADD_MONTHS(TO_DATE(TO_CHAR(KJMO),'YYYYMM'),+1),'YYYYMM')) AS kjmo_vm,
   
   
   (kj-EXTRACT(YEAR FROM CURRENT_DATE))*12+(MOD(kjmo, 100))-EXTRACT(MONTH FROM CURRENT_DATE) AS akt_mo_kalendarisch
   FROM dbp_view.v_monat_1;