WITH LAST_SALE_${COUNTRY} AS
(
SELECT 
la.kl_art_id,
la.mandant_id,
la.wup_id,
la.dat,
la.datzeit
FROM dbp_ods.ods_letzter_abverkauf la
INNER JOIN 
( SELECT DISTINCT 
  mandant_id
  ,wup_id
  ,dat
  ,MIN(bon_beginn) AS bon_beginn
  FROM dbp_etl.DAT_WUP_LAST_SALE_${COUNTRY}
  WHERE dat BETWEEN CURRENT_DATE - 2 AND CURRENT_DATE -1
  GROUP BY 1,2,3
) lb
ON lb.mandant_id = la.mandant_id
AND lb.wup_id = la.wup_id
AND lb.dat = la.dat
AND lb.bon_beginn < la.datzeit
)

SELECT a.kl_art_id AS article_no
,CASE
    WHEN a.mandant_id = 1 THEN 'DE'
    ELSE b.mandant_kbez
    END AS country
,a.wup_id AS store_no
,a.dat AS sale_date
,to_char(a.datzeit,'YYYY-MM-DD HH24:MI:SS') AS sales_time 
FROM LAST_SALE_${COUNTRY} a
INNER JOIN dbp_data.mandant b ON a.mandant_id = b.mandant_id
ORDER BY a.wup_id
 
