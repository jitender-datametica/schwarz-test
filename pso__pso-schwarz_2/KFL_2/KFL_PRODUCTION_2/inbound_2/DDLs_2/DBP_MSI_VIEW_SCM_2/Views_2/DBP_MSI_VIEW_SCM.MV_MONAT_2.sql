CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_MONAT_2 as
SELECT V01.KJMO ,
       V01.KJMO_VJ ,
       V01.KJ ,
       V01.MO_KJ ,
       V01.GJ ,
       V01.MO_GJ ,
       V01.GJMO ,
       V01.GJMO_VJ ,
       V01.KJQU ,
       V01.GJQU ,
       V01.AKT_MO ,
       V01.AKT_MO_KOMPLETT ,
       V01.AKT_GJ ,
       V01.AKT_GJ_KOMPLETT ,
       V01.AKT_KJ ,
       V01.AKT_KJ_KOMPLETT ,
       V01.AKT_KJQU ,
       V01.AKT_KJQU_KOMPLETT ,
       V01.AKT_GJQU ,
       V01.AKT_GJQU_KOMPLETT ,
       V01.MIN_DAT AS MO_DAT_VON ,
       V01.MAX_DAT AS MO_DAT_BIS ,
       V01.AKT_MO + V02.SUMMAND AS AKT_MO_TEKU ,
       to_number(to_char(add_months(to_date(to_char(V01.KJMO),'YYYYMM'),-1),'YYYYMM')) AS KJMO_VM  ,
       to_number(to_char(add_months(to_date(to_char(V01.KJMO),'YYYYMM'),-2),'YYYYMM')) AS KJMO_VVM
FROM DBP_VIEW.V_MONAT_2 V01
CROSS JOIN
  (SELECT DAT ,
          CASE
              WHEN EXTRACT (DAY
                            FROM DAT) <= 4 THEN 1
              ELSE 0
          END SUMMAND
   FROM DBP_VIEW.V_TAG_2
   WHERE AKT_TAG = 0 ) V02
WHERE V01.AKT_GJ BETWEEN -11 AND 1;