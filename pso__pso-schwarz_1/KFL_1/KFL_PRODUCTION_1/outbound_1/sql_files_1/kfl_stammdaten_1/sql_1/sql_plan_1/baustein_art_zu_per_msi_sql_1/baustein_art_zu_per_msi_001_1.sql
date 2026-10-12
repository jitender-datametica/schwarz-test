--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 ALL;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


TRUNCATE TABLE dbp_msi_data.baustein_art_zu_per_msi_1;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1
--(
--        mandant_id
--        ,baustein_id
--        ,art_id
--        ,dat_von
--        ,dat_bis
--)
--        SELECT
--        mandant_id
--        ,baustein_id
--        ,art_id
--        ,dat_von
--        ,dat_bis
--        FROM
--        DBX_DATA.baustein_art_zu_per_1
--        GROUP BY 1,2,3,4,5
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


INSERT INTO dbp_msi_data.baustein_art_zu_per_msi_1 (baustein_id, mandant_id, art_id, dat_von, dat_bis)
(SELECT baustein_id,
  mandant_id,
  art_id,
  dat_von,
  dat_bis
 FROM dbp_data.baustein_art_zu_per_1
 GROUP BY baustein_id,
  mandant_id,
  art_id,
  dat_bis,
  dat_von);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1
--WHERE
--(
--        baustein_id
--        ,mandant_id
--        ,art_id
--        ,dat_bis
--        ,dat_von
--)
--IN
--(
--        SELECT
--        t1.baustein_id
--        ,t1.mandant_id
--        ,t1.art_id
--        ,t1.dat_bis
--        ,t1.dat_von
--        from KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 t1_1
--        INNER JOIN KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 t2
--        ON  t1.baustein_id=t2.baustein_id
--        AND t1.mandant_id=t2.mandant_id
--        AND t1.art_id=t2.art_id
--        AND t1.dat_bis between t2.dat_von AND t2.dat_bis
--        AND t1.dat_von > t2.dat_von
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


DELETE FROM dbp_msi_data.baustein_art_zu_per_msi_1
WHERE (baustein_id, mandant_id, art_id, dat_bis, dat_von) IN (SELECT (T1.baustein_id, T1.mandant_id, T1.art_id, T1.dat_bis
    , T1.dat_von)
  FROM dbp_msi_data.baustein_art_zu_per_msi_1 AS T1_1
   INNER JOIN dbp_msi_data.baustein_art_zu_per_msi_1 AS T2 ON T1.baustein_id = T2.baustein_id AND T1.mandant_id
         = T2.mandant_id AND T1.art_id = T2.art_id AND T1.dat_bis BETWEEN T2.dat_von AND T2.dat_bis AND T1.dat_von > T2
     .dat_von);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1
--WHERE
--(
--        baustein_id
--        ,mandant_id
--        ,art_id
--        ,dat_bis
--        ,dat_von
--)
--IN
--(
--        SELECT
--        t1.baustein_id
--        ,t1.mandant_id
--        ,t1.art_id
--        ,t1.dat_bis
--        ,t1.dat_von
--        from KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 t1_1
--        INNER JOIN KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 t2
--        ON  t1.baustein_id=t2.baustein_id
--        AND t1.mandant_id=t2.mandant_id
--        AND t1.art_id=t2.art_id
--        AND t1.dat_von between t2.dat_von AND t2.dat_bis
--        AND t1.dat_bis < t2.dat_bis
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


DELETE FROM dbp_msi_data.baustein_art_zu_per_msi_1
WHERE (baustein_id, mandant_id, art_id, dat_bis, dat_von) IN (SELECT (T1.baustein_id, T1.mandant_id, T1.art_id, T1.dat_bis
    , T1.dat_von)
  FROM dbp_msi_data.baustein_art_zu_per_msi_1 AS T1_1
   INNER JOIN dbp_msi_data.baustein_art_zu_per_msi_1 AS T2 ON T1.baustein_id = T2.baustein_id AND T1.mandant_id
         = T2.mandant_id AND T1.art_id = T2.art_id AND T1.dat_von BETWEEN T2.dat_von AND T2.dat_bis AND T1.dat_bis < T2
     .dat_bis);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--original statement
--UPDATE KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1
--FROM
--(
--SELECT
--baustein_id baustein_id_
--,mandant_id mandant_id_
--,art_id art_id_
--,dat_von dat_von_
--,dat_bis dat_bis_
--,dat_bis_new
--        FROM
--        (
--        SELECT
--        t1.baustein_id
--        ,t1.mandant_id
--        ,t1.art_id
--        ,t1.dat_von
--        ,t1.dat_bis
--        , msum(CAST(t1.dat_von AS INTEGER), 2, t1.dat_von desc)-cast(t1.dat_von AS INTEGER) AS dat_diff_von
--        , msum(CAST(t1.dat_bis AS INTEGER), 2, t1.dat_von desc)-cast(t1.dat_bis AS INTEGER) AS dat_diff_bis
--        ,case when dat_diff_von <> 0 then cast(dat_diff_von as date) else NULL END as dat_diff_v
--        ,case when dat_diff_bis <> 0 then cast(dat_diff_bis as date) else NULL END as dat_diff_b
--        ,CASE WHEN dat_diff_v BETWEEN dat_von AND dat_bis THEN dat_diff_v-1 ELSE dat_bis END AS dat_bis_new
--        from KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 t1_1
--        GROUP BY
--        t1.baustein_id
--        ,t1.mandant_id
--        ,t1.art_id
--        )t1_1
--WHERE dat_bis_new <> dat_bis
--)dt1
--SET dat_bis = dat_bis_new
--WHERE baustein_id=baustein_id_
--  AND mandant_id=mandant_id_
--  AND art_id=art_id_
--  AND dat_von=dat_von_
--  AND dat_bis=dat_bis_
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement

/* ogas0311
UPDATE KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1
SET dat_bis = dat_bis_new
FROM
(
SELECT
baustein_id baustein_id_
,mandant_id mandant_id_
,art_id art_id_
,dat_von dat_von_
,dat_bis dat_bis_
,dat_bis_new
        FROM
        (
        SELECT
        t1.baustein_id
        ,t1.mandant_id
        ,t1.art_id
        ,t1.dat_von
        ,t1.dat_bis
        --mfialkiewicz
        --, msum(CAST(t1.dat_von AS INTEGER), 2, t1.dat_von desc)-cast(t1.dat_von AS INTEGER) AS dat_diff_von
        ,SUM(to_number(to_char(t1.dat_von,'YYYYMMDD'))) OVER (ORDER BY t1.dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(t1.dat_von,'YYYYMMDD')) AS dat_diff_von 
        --, msum(CAST(t1.dat_bis AS INTEGER), 2, t1.dat_von desc)-cast(t1.dat_bis AS INTEGER) AS dat_diff_bis
        ,SUM(to_number(to_char(t1.dat_bis,'YYYYMMDD'))) OVER (ORDER BY t1.dat_bis DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(t1.dat_bis,'YYYYMMDD')) AS dat_diff_bis
        ,case when dat_diff_von <> 0 then to_date(dat_diff_von, 'YYYYMMDD') else NULL END as dat_diff_v
        ,case when dat_diff_bis <> 0 then to_date(dat_diff_bis, 'YYYYMMDD') else NULL END as dat_diff_b
        ,CASE WHEN dat_diff_v BETWEEN dat_von AND dat_bis THEN dat_diff_v-1 ELSE dat_bis END AS dat_bis_new
        from KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 t1_1
        /*GROUP BY
        t1.baustein_id
        ,t1.mandant_id
        ,t1.art_id*/
 /*       )t1_1
WHERE dat_bis_new <> dat_bis
)dt1
WHERE baustein_id=baustein_id_
  AND mandant_id=mandant_id_
  AND art_id=art_id_
  AND dat_von=dat_von_
  AND dat_bis=dat_bis_


ogas0311*/

/* szymanskipi
CREATE OR REPLACE FUNCTION "TERADATA_NUMERIC_DATE_TO_DATE"(NUMERIC_DT NUMBER)
RETURNS DATE
LANGUAGE SQL
AS 'to_date(replace(to_char((NUMERIC_DT -  mod(NUMERIC_DT,10000))/10000 + 1900, ''0000') || '-'' || 
to_char((mod(NUMERIC_DT,10000) - mod(mod(NUMERIC_DT,10000),100))/100, ''00') || '-'' || 
to_char(mod(NUMERIC_DT,100), ''00''),'' ''),''YYYY-MM_1-DD'')'


UPDATE KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1
SET dat_bis = dat_bis_new
FROM
(SELECT
baustein_id baustein_id_,
mandant_id mandant_id_,
art_id art_id_,
dat_von dat_von_,
dat_bis dat_bis_,
dat_bis_new
FROM
(SELECT
t1.baustein_id,
t1.mandant_id,
t1.art_id,
t1.dat_von,
t1.dat_bis,
((date_part('year', dat_von)) - 1900) * 10000 + ((date_part('month', dat_von)) * 100) + (date_part('day', dat_von)) as teradata_von,
sum(teradata_von) OVER ( ORDER BY t1.DAT_VON desc rows 1 PRECEDING  ) - teradata_von as dat_diff_von,
((date_part('year', dat_bis)) - 1900) * 10000 + ((date_part('month', dat_bis)) * 100) + (date_part('day', dat_bis)) as teradata_bis,
 sum(teradata_bis) OVER ( ORDER BY t1.DAT_VON desc rows 1 PRECEDING  ) - teradata_bis as dat_diff_bis,  
CASE WHEN dat_diff_von <> 0 THEN TERADATA_NUMERIC_DATE_TO_DATE(teradata_von) else NULL END as dat_diff_v, 
CASE WHEN dat_diff_bis <> 0 THEN TERADATA_NUMERIC_DATE_TO_DATE(teradata_bis) else NULL END as dat_diff_b,
CASE WHEN dat_diff_v BETWEEN dat_von AND dat_bis THEN dateadd('days', - 1, dat_diff_v) ELSE dat_bis END AS dat_bis_new 
 
FROM KFL_PRODUCTION.DBP_MSI_DATA.baustein_art_zu_per_msi_1 t1_1
 
 GROUP BY
t1.baustein_id
,t1.mandant_id
,t1.art_id
,t1.dat_bis
,t1.dat_von
 )t1_1
WHERE dat_bis_new <> dat_bis
)dt1
WHERE baustein_id=baustein_id_
AND mandant_id=mandant_id_
AND art_id=art_id_
AND dat_von=dat_von_
AND dat_bis=dat_bis_

szymanskipi */


UPDATE dbp_msi_data.baustein_art_zu_per_msi_1 SET
 dat_bis = dt1.dat_bis_new FROM (SELECT baustein_id AS baustein_id_,
   mandant_id AS mandant_id_,
   art_id AS art_id_,
   dat_von AS dat_von_,
   dat_bis AS dat_bis_,
    CASE
    WHEN CASE
      WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id, mandant_id
            , art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
         , 0) <> 0
      THEN DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id,
             mandant_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
          , 0) AS STRING))
      ELSE NULL
      END BETWEEN dat_von AND dat_bis
    THEN DATE_SUB(CASE
      WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id, mandant_id
            , art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
         , 0) <> 0
      THEN DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id,
             mandant_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
          , 0) AS STRING))
      ELSE NULL
      END, INTERVAL 1 DAY)
    ELSE dat_bis
    END AS dat_bis_new
  FROM dbp_msi_data.baustein_art_zu_per_msi_1 AS T1_1
  QUALIFY CASE
     WHEN CASE
       WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id,
             mandant_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
          , 0) <> 0
       THEN DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id
              , mandant_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
           , 0) AS STRING))
       ELSE NULL
       END BETWEEN dat_von AND dat_bis
     THEN DATE_SUB(CASE
       WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id,
             mandant_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
          , 0) <> 0
       THEN DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY baustein_id
              , mandant_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
           , 0) AS STRING))
       ELSE NULL
       END, INTERVAL 1 DAY)
     ELSE dat_bis
     END <> dat_bis) AS dt1
WHERE baustein_art_zu_per_msi.baustein_id = dt1.baustein_id_ AND baustein_art_zu_per_msi.mandant_id = dt1.mandant_id_
   AND baustein_art_zu_per_msi.art_id = dt1.art_id_ AND baustein_art_zu_per_msi.dat_von = dt1.dat_von_ AND
  baustein_art_zu_per_msi.dat_bis = dt1.dat_bis_;