DELETE FROM DBP_DATA.marktbestand_erp_delta_1
;


INSERT INTO DBP_DATA.marktbestand_erp_delta_1
(         mandant_id
         ,art_id
         ,wup_id
         ,nb_id
         ,dat
         ,menge_lgbest_erp_frei_bme
         ,menge_lgbest_erp_qual_bme
)
SELECT 
          mandant_id
         ,art_id
         ,wup_id
         ,nb_id
         ,(CURRENT_DATE-1) AS dat
         ,menge_lgbest_erp_frei_bme
         ,menge_lgbest_erp_qual_bme
FROM DBP_DATA.marktbestand_erp_1
WHERE (mandant_id,wup_id,art_id,dat) 
IN (     SELECT mandant_id,wup_id,art_id,MAX(dat) AS dat
         FROM DBP_DATA.marktbestand_erp_1
         WHERE dat BETWEEN CURRENT_DATE-10 AND CURRENT_DATE
         GROUP BY 1,2,3
)
;


DELETE FROM DBP_DATA.marktbestand_erp_delta_1
WHERE (   mandant_id
         ,art_id
         ,wup_id
)
IN    (  SELECT 
          mandant_id
         ,art_id
         ,wup_id
         FROM ${TEMP_TABLE}
         )
;


INSERT INTO DBP_DATA.marktbestand_erp_delta_1
(         mandant_id
         ,art_id
         ,wup_id
         ,nb_id
         ,dat
         ,menge_lgbest_erp_frei_bme
         ,menge_lgbest_erp_qual_bme
)

SELECT
          mandant_id
         ,art_id
         ,wup_id
         ,nb_id
         ,(CURRENT_DATE-1) AS dat
         ,menge_lgbest_erp_frei_bme
         ,menge_lgbest_erp_qual_bme
FROM ${TEMP_TABLE}
;

