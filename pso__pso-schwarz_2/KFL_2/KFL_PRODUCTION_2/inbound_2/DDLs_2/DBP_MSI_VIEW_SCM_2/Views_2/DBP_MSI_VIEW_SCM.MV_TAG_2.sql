CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TAG_2 AS
SELECT DAT ,
       WTAG_ID ,
       KJTAG_ID ,
       GJTAG_ID ,
       DAT_VJ ,
       DAT_VJ - 364 AS DAT_VVJ ,
       KJWO ,
       KJWO_VJ,
       WO_DAT_VON ,
       WO_DAT_BIS ,
       KJMO ,
       KJMO_VJ ,
       KJ ,
       MO_GJ ,
       MO_KJ ,
       GJMO ,
       GJMO_VJ ,
       GJQU ,
       GJ ,
       AKT_TAG ,
       AKT_WO * 10000 + AKT_TAG AS AKT ,
       AKT_WO_KOMPLETT * 10000 + AKT_TAG AS AKT_KOMPLETT ,
       AKT_WO ,
       AKT_WO_KOMPLETT ,
       AKT_MO ,
       AKT_MO_KOMPLETT ,
       AKT_GJ ,
       AKT_GJ_KOMPLETT ,
       AKT_KJ ,
       AKT_KJ_KOMPLETT ,
       AKT_GJQU ,
       AKT_GJQU_KOMPLETT ,
       TO_VARCHAR(MOD(KJWO, 100) ,'00') || ' (' || TO_CHAR(WO_DAT_VON , 'DD.MM.') || '-' || TO_CHAR(WO_DAT_BIS , 'DD.MM.') || ')'::VARCHAR(20) AS WO_VON_BIS ,
       CAST(SUBSTRING(CAST(DAT AS VARCHAR), 1, 8) ||'01' AS VARCHAR) AS KJMO_DAT ,
       AKT_MO / 3 AS AKT_QU ,
       CASE
           WHEN TO_DATE(TO_CHAR(KJ) || '-03-01','YYYY-MM_2-DD') BETWEEN WO_DAT_VON AND WO_DAT_BIS THEN KJ*100+1
           --WHEN CAST(((KJ-1900)*10000+301) AS DATE) BETWEEN WO_DAT_VON AND WO_DAT_BIS THEN KJ*100+1
           ELSE GJWO_KL
       END AS GJWO_NEU ,
       KJWO_KL ,
       EXTRACT (DAY
                FROM DAT) AS TAG_TAG ,
               EXTRACT (DAY
                        FROM CURRENT_DATE - 1) AS REFERENZ_TAG
FROM DBP_VIEW.V_TAG_2 V01
WHERE V01.AKT_GJ BETWEEN -11 AND 1;