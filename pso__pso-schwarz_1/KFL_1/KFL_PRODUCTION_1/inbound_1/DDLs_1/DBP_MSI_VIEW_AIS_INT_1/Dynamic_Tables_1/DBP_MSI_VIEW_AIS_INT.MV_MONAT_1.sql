CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_MONAT_1
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
,gj
,akt_gj
,akt_gj_komplett
,kj
,akt_kj
,akt_kj_komplett
,kjmo_vm
,akt_mo_kalendarisch
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT V01.GJMO ,
       V01.GJMO_VJ ,
       V01.MO_GJ ,
       V01.KJMO ,
       V01.KJMO_VJ ,
       V01.MO_KJ ,
       V01.AKT_MO ,
       V01.AKT_MO_KOMPLETT ,
       V01.GJQU ,
       V01.AKT_GJQU ,
       V01.AKT_GJQU_KOMPLETT ,
       V01.KJQU ,
       V01.AKT_KJQU ,
       V01.AKT_KJQU_KOMPLETT ,
       V01.GJ ,
       V01.AKT_GJ ,
       V01.AKT_GJ_KOMPLETT ,
       V01.KJ ,
       V01.AKT_KJ ,
       V01.AKT_KJ_KOMPLETT ,
       TO_NUMBER(TO_CHAR(ADD_MONTHS(TO_DATE(TO_CHAR(KJMO),'YYYYMM'),-1),'YYYYMM')) AS kjmo_vm,
       (V01.KJ-EXTRACT(YEAR FROM CURRENT_DATE))*12+(MOD(V01.KJMO, 100))-EXTRACT(MONTH FROM CURRENT_DATE) AS AKT_MO_KALENDARISCH
FROM DBP_VIEW.V_MONAT_1 V01;