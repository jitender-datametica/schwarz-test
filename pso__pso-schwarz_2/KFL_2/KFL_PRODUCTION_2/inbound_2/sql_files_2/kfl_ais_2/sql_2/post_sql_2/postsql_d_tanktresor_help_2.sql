--[OK] statement is translated correctly (syntax and type checks are fine)

DELETE FROM DBP_ETL.d_tanktresor_help_kunden_2;

INSERT INTO DBP_ETL.d_tanktresor_help_kunden_2
(
  marktnummer
, wg_text
, schluessel2
, wert
, datum
)
select
  marktnummer
, wg_text
, schluessel2
, wert
, datum
   FROM DBP_ETL.d_tanktresor_help_2
WHERE SUBSTR(schluessel2,1,6) = 'KUNDEN'
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.d_tanktresor_help_2
WHERE SUBSTR(schluessel2,1,6) = 'KUNDEN'
;

DELETE FROM DBP_DATA.artbew_wg_sum_2
WHERE 
( 	  mandant_id
	, wup_id
	, nb_id
	, dat
)
IN (SELECT 
  	   1 AS mandant_id
	,  CAST(marktnummer AS INTEGER) AS wup_id        
	,  w.nb_id AS nb_id
	,  to_date(datum , 'DD-MM_2-YYYY') AS dat
     FROM       DBP_ETL.d_tanktresor_help_2 dth
     INNER JOIN DBP_DATA.wup_2 w
        ON  CAST(dth.marktnummer AS INTEGER) = w.wup_id
       AND w.mandant_id = 1
       AND w.nb_id = 7
 )
AND quelle = 2;

INSERT INTO DBP_DATA.artbew_wg_sum_2 (
  mandant_id
, wup_id
, wg_id        
, bewart_id    
, dat          
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto 
, umsatz_wrg   
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle         
)
SELECT   
          1 AS mandant_id 
        , CAST(marktnummer AS INTEGER) AS wup_id                     
        , -1 AS wg_id                 
        , 1001 AS bewart_id          
        , to_date(datum, 'DD-MM_2-YYYY') AS dat                
        , w.nb_id
        , 2 AS arthiertyp_id
        , sum(CAST(CASE WHEN schluessel2 = 'UMSBRU_GESAMT' THEN wert END AS DECIMAL(12,2))) AS umsatz_brutto
        , sum(CAST(CASE WHEN schluessel2 = 'UMSNET' THEN wert END AS DECIMAL(12,2))) AS umsatz_netto
        , 'EUR' AS umsatz_wrg 
        , sum(CAST(CASE WHEN schluessel2 = 'UMSBRU_GESAMT' THEN wert END AS DECIMAL(12,2))) AS umsatz_brutto_konz
        , sum(CAST(CASE WHEN schluessel2 = 'UMSNET' THEN wert END AS DECIMAL(12,2))) AS umsatz_netto_konz
        , cast(cast(replace(''||to_date(datum, 'DD-MM_2-YYYY'),'-','') as integer)/100 as integer) AS kjmo   --, to_date(datum, 'DD-MM_2-YYYY') / 100 + 190000 AS kjmo   
        , sum(CAST(CASE WHEN schluessel2 = 'LITER_GESAMT' THEN wert END AS DECIMAL(18,3))) AS menge
        ,1
FROM            DBP_ETL.d_tanktresor_help_2 dth
INNER JOIN      DBP_DATA.wup_2 w
   ON   CAST(dth.marktnummer AS INTEGER) = w.wup_id
  AND   w.mandant_id = 1
  AND   w.nb_id = 7

WHERE 
(	  1
	, CAST(marktnummer AS INTEGER)
	, -1
	, to_date(datum, 'DD-MM_2-YYYY')
	, w.nb_id
)
	NOT IN
    (SELECT 
             mandant_id 
           , wup_id
           , wg_id
           , dat
           , nb_id
        FROM DBP_DATA.artbew_wg_sum_2
     )
GROUP BY 1,2,3,4,5,6,7,13;
 
UPDATE  DBP_DATA.wupcal_2
   SET  datenlieferung_artbew_wg_sum = 1,
        td_update= CURRENT_TIMESTAMP
WHERE (
          mandant_id
	, wup_id
	, nb_id
	, dat
       )
  IN
    (   SELECT 
          1 as mandant_id
	,  CAST(marktnummer AS INTEGER) AS wup_id        
	,  7 AS nb_id
	,  to_date(datum, 'DD-MM_2-YYYY') AS dat
        FROM DBP_ETL.d_tanktresor_help_2
    )
;


INSERT INTO DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_2
(
	mandant_id
	,wup_id
	,nb_id
	,dat
	,calc_fg
	,dat_lief
)
SELECT 
  	1 as mandant_id
	, CAST(marktnummer AS INTEGER) AS wup_id
	, w.nb_id AS nb_id
	, to_date(datum , 'DD-MM_2-YYYY') AS dat
   	, 0 as calc_fg
   	, CURRENT_DATE as dat_lief

FROM 	   DBP_ETL.d_tanktresor_help_2 dth
INNER JOIN DBP_DATA.wup_2 w
ON  CAST(dth.marktnummer AS INTEGER) = w.wup_id
AND w.mandant_id = 1
AND w.nb_id = 7
GROUP BY  1,2,3,4,5,6
;



DELETE FROM DBP_DATA.vis_tag_tks_sorte_2
WHERE 
 (mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,tks_sorte_id
  ,tks_sorte_bez)
   IN
     ( SELECT
       mandant_id 
     , wup_id 
     , nb_id
     , dat
     , tks_sorte_id
     , tks_sorte_bez
     FROM
     (
     SELECT
       1 AS mandant_id
     , 7 AS nb_id
     ,CAST(v01.marktnummer AS INTEGER) AS wup_id
     ,to_date(v01.datum , 'DD-MM_2-YYYY') AS dat
     ,TRIM(v01.wg_text) AS txt
       -- betraege auf spalten verteilen
     , CASE   -- sorte_id generierenen
         WHEN txt LIKE '%.DIESEL.DIESEL%'     THEN 10 
         WHEN txt LIKE '%.DIESEL.BIODIESEL%'  THEN 11 
         WHEN txt LIKE '%.NORMAL%'            THEN 20            
         WHEN txt LIKE '%.SUPBL%'             THEN 30 
         WHEN txt LIKE '%.SUPPL%'             THEN 31         
         WHEN txt LIKE '%.SUPE10%'            THEN 32          
         WHEN txt LIKE '%.MIX%'               THEN 40 
         WHEN txt LIKE '%.SONDER.OEL%'        THEN 50         
         WHEN txt LIKE '%.SONDER.WASCHEN%'    THEN 60     
         ELSE -1 
       END /* (SMALLINT))*/ AS tks_sorte_id
     , CASE   -- sorte_bez generierenen
         WHEN txt LIKE '%.DIESEL.DIESEL%'     THEN 'Diesel' 
         WHEN txt LIKE '%.DIESEL.BIODIESEL%'  THEN 'Biodiesel' 
         WHEN txt LIKE '%.NORMAL%'            THEN 'Normal'            
         WHEN txt LIKE '%.SUPBL%'             THEN 'Super Bleifrei' 
         WHEN txt LIKE '%.SUPPL%'             THEN 'Super Plus'         
         WHEN txt LIKE '%.SUPE10%'            THEN 'Super E10'          
         WHEN txt LIKE '%.MIX%'               THEN 'Mix' 
         WHEN txt LIKE '%.SONDER.OEL%'        THEN 'Öl'         
         WHEN txt LIKE '%.SONDER.WASCHEN%'    THEN 'Waschen'     
         ELSE '-1' 
       END /* (VARCHAR(40))*/ AS tks_sorte_bez
     FROM DBP_ETL.d_tanktresor_help_2 v01
     ) sub
     WHERE tks_sorte_id > 0
     GROUP BY
       mandant_id
     , nb_id
     , wup_id
     , dat
     , tks_sorte_id
     , tks_sorte_bez)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------

INSERT INTO DBP_DATA.vis_tag_tks_sorte_2
(  mandant_id 
, wup_id 
, nb_id
, dat
, tks_sorte_id
, tks_sorte_bez
, ums_netto
, ums_brutto
, menge_liter
, anz_kunde
, wrg_id)

SELECT
    mandant_id AS mandant_id
  , wup_id AS wup_id
  , nb_id AS nb_id
  , dat AS dat
  , tks_sorte_id
  , tks_sorte_bez
  , SUM(tks_ums_netto)                      AS ums_netto
  , SUM(tks_ums_netto) + SUM(tks_ums_mwst)  AS ums_brutto
  , SUM(tks_liter)                          AS menge_liter
  , CAST(SUM(tks_kunden) as INTEGER)        AS anz_kunden
  , 'EUR' AS wrg_id
  FROM
  (
  SELECT
    1 AS mandant_id
  , 7 AS nb_id
  , CAST(v01.marktnummer AS INTEGER) AS wup_id
  , to_date(v01.datum , 'DD-MM_2-YYYY') AS dat
  , CAST(v01.wert as DECIMAL(8,2)) betrag
  , TRIM(v01.wg_text) AS txt
    -- betraege auf spalten verteilen
  , CASE WHEN SUBSTRING(txt, 1, 16) = 'UMSATZ_TKS_NETTO' THEN betrag ELSE 0 END tks_ums_netto
  , CASE WHEN SUBSTRING(txt, 1, 15) = 'UMSATZ_TKS_MWST'  THEN betrag ELSE 0 END tks_ums_mwst
  , CASE WHEN SUBSTRING(txt, 1, 16) = 'UMSATZ_TKS_LITER' THEN betrag ELSE 0 END tks_liter
  , CASE WHEN SUBSTRING(txt, 1, 10) = 'KUNDEN_TKS'       THEN betrag ELSE 0 END tks_kunden
  , CASE   -- sorte_id generierenen
      WHEN txt LIKE '%.DIESEL.DIESEL%'     THEN 10 
      WHEN txt LIKE '%.DIESEL.BIODIESEL%'  THEN 11 
      WHEN txt LIKE '%.NORMAL%'            THEN 20            
      WHEN txt LIKE '%.SUPBL%'             THEN 30 
      WHEN txt LIKE '%.SUPPL%'             THEN 31         
      WHEN txt LIKE '%.SUPE10%'            THEN 32          
      WHEN txt LIKE '%.MIX%'               THEN 40 
      WHEN txt LIKE '%.SONDER.OEL%'        THEN 50         
      WHEN txt LIKE '%.SONDER.WASCHEN%'    THEN 60     
      ELSE -1 
    END /*(SMALLINT)*/ AS tks_sorte_id
  , CASE   -- sorte_bez generierenen
      WHEN txt LIKE '%.DIESEL.DIESEL%'     THEN 'Diesel' 
      WHEN txt LIKE '%.DIESEL.BIODIESEL%'  THEN 'Biodiesel' 
      WHEN txt LIKE '%.NORMAL%'            THEN 'Normal'            
      WHEN txt LIKE '%.SUPBL%'             THEN 'Super Bleifrei' 
      WHEN txt LIKE '%.SUPPL%'             THEN 'Super Plus'         
      WHEN txt LIKE '%.SUPE10%'            THEN 'Super E10'          
      WHEN txt LIKE '%.MIX%'               THEN 'Mix' 
      WHEN txt LIKE '%.SONDER.OEL%'        THEN 'Öl'         
      WHEN txt LIKE '%.SONDER.WASCHEN%'    THEN 'Waschen'     
      ELSE '-1'
    END /*(VARCHAR(40))*/ AS tks_sorte_bez
  FROM DBP_ETL.d_tanktresor_help_2 v01
  ) sub
  WHERE tks_sorte_id > 0
  GROUP BY
    mandant_id
  , nb_id
  , wup_id
  , dat
  , tks_sorte_id
  , tks_sorte_bez
  ;


UPDATE DBP_DATA.wupcal_2

   SET  bonanzahl = _kundenzahl,
        datenlieferung_bonanzahl = 1,
        td_update= CURRENT_TIMESTAMP
 
FROM
(
  SELECT
     k.marktnummer AS _wup_id   
   , 7 AS _nb_id
   , to_date(datum , 'DD-MM_2-YYYY') AS _dat
   , SUM(CAST(wert * w.kundenfaktor AS INTEGER)) AS _kundenzahl
  FROM DBP_ETL.d_tanktresor_help_kunden_2 k
  INNER JOIN  DBP_DATA.wup_2 w
     ON  k.marktnummer = w.wup_id
    AND mandant_id = 1
    AND 7 = w.nb_id

  WHERE schluessel2 = 'KUNDEN_GESAMT'
  GROUP BY 1,2,3
 
)  ums_dt 
 WHERE wup_id    = _wup_id
  AND nb_id     = _nb_id
  AND dat       = _dat  
  AND mandant_id= 1
  AND bonanzahl <> _kundenzahl
;


