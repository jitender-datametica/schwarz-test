CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_ABWESENH_ZU_PER_1
(
  mandant_id
, abwesenheit_id
, abwesenheit_bez
, mitarbeiter_id
, dat_von
, dat_bis
, kjmo
, kjmo_von
, kjmo_bis
, dauer_tage
, abwesenheit_stunden
)
AS
   SELECT V01.MANDANT_ID ,
       V01.ABWESENHEIT_ID ,
       V03.ABWESENHEIT_BEZ ,
       V01.MITARBEITER_ID ,
       V01.DAT_VON ,
       V01.DAT_BIS ,
       V01.KJMO ,
       CAST(EXTRACT(YEAR FROM V01.DAT_VON) || CASE
                                             WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_VON)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                             ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                         END AS INTEGER) AS KJMO_VON,
       CASE
           WHEN V01.DAT_BIS < V02.MAX_DAT
                AND ((V01.MANDANT_ID = 1 AND V01.ABWESENHEIT_ID IN ('0601'))
                OR  (V01.MANDANT_ID = 2  AND V01.ABWESENHEIT_ID IN ('0530' ,'0540'))
                OR  (V01.MANDANT_ID = 3  AND V01.ABWESENHEIT_ID IN ('0600' ,'0601'))
                OR  (V01.MANDANT_ID = 4  AND V01.ABWESENHEIT_ID IN ('0100'))
                OR  (V01.MANDANT_ID = 5  AND V01.ABWESENHEIT_ID IN ('0530'))
                OR  (V01.MANDANT_ID = 5  AND V01.ABWESENHEIT_ID IN ('0530'))
                OR  (V01.MANDANT_ID = 6  AND V01.ABWESENHEIT_ID IN ('0251'))
                OR  (V01.MANDANT_ID = 7  AND V01.ABWESENHEIT_ID IN ('0530'))
                OR  (V01.MANDANT_ID = 8  AND V01.ABWESENHEIT_ID IN ('0515' , '0530' ,'0531')))
           THEN CAST(EXTRACT(YEAR FROM V01.DAT_BIS) || CASE WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                                            ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) 
                                                       END AS INTEGER) -1
           ELSE CAST(EXTRACT(YEAR FROM V01.DAT_BIS) || CASE
                                                         WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                                         ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                                       END AS INTEGER)
       END AS KJMO_BIS ,
       CASE
           WHEN V01.DAT_BIS <= V02.MAX_DAT-1 THEN 0
           WHEN V01.DAT_BIS >= V02.MAX_DAT THEN V02.MAX_DAT - V01.DAT_VON
           ELSE V01.DAT_BIS - V01.DAT_VON
       END AS DAUER_TAGE ,
       ABWESENHEIT_STUNDEN
FROM DBP_VIEW.V_MA_ABWESENH_ZU_PER_1 V01
JOIN DBP_VIEW.V_MONAT_1 V02 ON V02.KJMO 
    BETWEEN 
             CAST(EXTRACT(YEAR FROM V01.DAT_VON) || CASE
                                             WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_VON)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                             ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                         END AS INTEGER) 
         AND        
         CASE
           WHEN V01.DAT_BIS < V02.MAX_DAT
                AND ((V01.MANDANT_ID = 1 AND V01.ABWESENHEIT_ID IN ('0601'))
                OR  (V01.MANDANT_ID = 2  AND V01.ABWESENHEIT_ID IN ('0530' ,'0540'))
                OR  (V01.MANDANT_ID = 3  AND V01.ABWESENHEIT_ID IN ('0600' ,'0601'))
                OR  (V01.MANDANT_ID = 4  AND V01.ABWESENHEIT_ID IN ('0100'))
                OR  (V01.MANDANT_ID = 5  AND V01.ABWESENHEIT_ID IN ('0530'))
                OR  (V01.MANDANT_ID = 5  AND V01.ABWESENHEIT_ID IN ('0530'))
                OR  (V01.MANDANT_ID = 6  AND V01.ABWESENHEIT_ID IN ('0251'))
                OR  (V01.MANDANT_ID = 7  AND V01.ABWESENHEIT_ID IN ('0530'))
                OR  (V01.MANDANT_ID = 8  AND V01.ABWESENHEIT_ID IN ('0515' , '0530' ,'0531')))
           THEN CAST(EXTRACT(YEAR FROM V01.DAT_BIS) || CASE WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                                            ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) 
                                                       END AS INTEGER) -1
           ELSE CAST(EXTRACT(YEAR FROM V01.DAT_BIS) || CASE
                                                         WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                                         ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                                       END AS INTEGER)
       END
       AND V02.KJMO = V01.KJMO
LEFT JOIN DBP_VIEW.V_MITARBEITER_ABWESENH_SPR_ZU_1 V03 ON V03.ABWESENHEIT_ID = V01.ABWESENHEIT_ID AND V03.MANDANT_ID = V01.MANDANT_ID AND V03.SPR_ID = 22;