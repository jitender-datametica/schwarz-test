CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_WUP_WE_CHECK_2 as
   SELECT V00.MANDANT_ID ,
       V00.WUP_ID ,
       V00.NB_ID ,
       V00.ART_ID ,
       MAX(CASE
               WHEN V03.MENGE_LAGERBEW_BME > 0 THEN 1
               ELSE 0
           END) AS WE_FG
FROM DBP_VIEW.V_ART_WUP_STATUS_PER_2 V00
LEFT OUTER JOIN
  (SELECT MANDANT_ID ,
          WUP_ID ,
          NB_ID ,
          ART_ID ,
          MENGE_LAGERBEW_BME
   FROM DBP_VIEW.V_LAGERBEW_DET_2
   WHERE NB_ID=-111
     AND DAT_BUCH BETWEEN current_date-365 AND current_date
     AND (MANDANT_ID=1
          AND LAGER_BEWART_ID IN ('101' ,
                                  '102' ,
                                  '901' ,
                                  '902' ,
                                  '905' ,
                                  '906' ,
                                  '913' ,
                                  '915')
          OR MANDANT_ID<>1
          AND LAGER_BEWART_ID IN ('101' ,
                                  '102' ,
                                  '901' ,
                                  '902')) ) V03 ON V00.MANDANT_ID=V03.MANDANT_ID
AND V00.WUP_ID=V03.WUP_ID
AND V00.ART_ID=V03.ART_ID
WHERE V00.DAT_BIS=to_date('9999-12-31')
  AND V00.NB_ID=-111
GROUP BY V00.MANDANT_ID ,
         V00.WUP_ID ,
         V00.NB_ID ,
         V00.ART_ID;