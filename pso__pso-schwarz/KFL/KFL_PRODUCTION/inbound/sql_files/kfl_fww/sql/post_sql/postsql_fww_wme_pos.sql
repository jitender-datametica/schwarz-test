--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.fww_wme_pos_tmp
(
mandant,
aktionsthema,
aktionsthema_bez,
SPRAS
)
SELECT 
1 AS mandant,
CASE WHEN aktionsthema = '' THEN 'XYZA' ELSE aktionsthema END ,
aktionsthema_bez,
'D' AS SPRAS
FROM  DBP_ETL.fww_wme_pos

GROUP BY 1,2,3,4
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.aktion_thema_spr_zu
--WHERE
--(mandant_id, aktion_thema_id) 
--IN
--(SELECT 1, aktionsthema
-- FROM DBX_LOAD.fww_wme_pos_tmp
-- )
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error: Incompatible collations: 'en\-cs' and 'en\-ci'
--translated statement
DELETE FROM DBP_DATA.aktion_thema_spr_zu
WHERE
(mandant_id, aktion_thema_id) 
IN
(SELECT 1, aktionsthema
 FROM DBP_ETL.fww_wme_pos_tmp
 )
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.l_aktion_thema
--(
--  mandant_id
--, aktion_thema_id
--)
--SELECT DISTINCT
--  1 AS MANDT
--, aktionsthema
--FROM DBX_LOAD.fww_wme_pos_tmp
--WHERE aktionsthema
--NOT IN
--( SELECT DISTINCT
--    aktion_thema_id
--  FROM DBX_DATA.l_aktion_thema
--  WHERE mandant_id = 1
--);
--
--Comment from validation checker
--MESSAGE: SQL compilation error: Incompatible collations: 'en\-ci' and 'en\-cs'
--translated statement
INSERT INTO DBP_DATA.l_aktion_thema
(
  mandant_id
, aktion_thema_id
)
SELECT DISTINCT
  1 AS MANDT
, aktionsthema
FROM DBP_ETL.fww_wme_pos_tmp
WHERE aktionsthema
NOT IN
( SELECT DISTINCT
    aktion_thema_id
  FROM DBP_DATA.l_aktion_thema
  WHERE mandant_id = 1
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.aktion_thema_spr_zu
--(
--  mandant_id
--, aktion_thema_id
--, spr_id
--, aktion_thema_bez
--)
--SELECT DISTINCT 
--  1 as mandant_id
--, a.aktion_thema_id
--, a.spr_id
--, a.aktion_thema_bez 
--FROM
--  (
--    SELECT
--      k.mandant_id as mandant_id
--    , k.spr_id
--    , k.aktion_thema_id
--    , CASE WHEN k.aktion_thema_id = 'XYZA' THEN 'kein Thema zugeordn' ELSE w.aktion_thema_bez END AS aktion_thema_bez
--    FROM
--    (
--      SELECT
--        1         AS mandant_id
--      , spr_id       AS spr_id
--      , aktionsthema AS aktion_thema_id
--      FROM
--        DBX_LOAD.fww_wme_pos_tmp src,
--        DBX_DATA.spr spr
--      WHERE
--        spr.dwh_spr = 1
--      GROUP BY 1,2,3
--    ) k
--    LEFT OUTER JOIN
--    (
--      SELECT
--        1             AS mandant_id
--      , dwhspr.spr_id    AS org_spr_id
--      , aktionsthema     AS aktion_thema_id
--      , aktionsthema_bez AS aktion_thema_bez
--      FROM
--        DBX_LOAD.fww_wme_pos_tmp dt1
--      INNER JOIN
--      ( SELECT
--          spr_id
--        , sap_spr_id
--        FROM DBX_DATA.sap_dwh_spr_zu
--        WHERE mandant_id = 1
--      ) dwhspr
--      ON dt1.SPRAS = 'D'
--    ) w
--      ON  k.mandant_id      = w.mandant_id
--      AND k.spr_id          = w.org_spr_id
--      AND k.aktion_thema_id = w.aktion_thema_id
--  ) a
--
--
--WHERE (1, a.aktion_thema_id, a.spr_id)
--NOT IN
--( SELECT
--    mandant_id, aktion_thema_id, spr_id
--  FROM DBX_DATA.aktion_thema_spr_zu
--  WHERE mandant_id = 1
--)
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error: Incompatible collations: 'en\-ci' and 'en\-cs'
--translated statement
INSERT INTO DBP_DATA.aktion_thema_spr_zu
(
  mandant_id
, aktion_thema_id
, spr_id
, aktion_thema_bez
)
SELECT DISTINCT 
  1 as mandant_id
, a.aktion_thema_id
, a.spr_id
, a.aktion_thema_bez 
FROM
  (
    SELECT
      k.mandant_id as mandant_id
    , k.spr_id
    , k.aktion_thema_id
    , CASE WHEN k.aktion_thema_id = 'XYZA' THEN 'kein Thema zugeordn' ELSE w.aktion_thema_bez END AS aktion_thema_bez
    FROM
    (
      SELECT
        1         AS mandant_id
      , spr_id       AS spr_id
      , aktionsthema AS aktion_thema_id
      FROM
        DBP_ETL.fww_wme_pos_tmp src,
        DBP_DATA.spr spr
      WHERE
        spr.dwh_spr = 1
      GROUP BY 1,2,3
    ) k
    LEFT OUTER JOIN
    (
      SELECT
        1             AS mandant_id
      , dwhspr.spr_id    AS org_spr_id
      , aktionsthema     AS aktion_thema_id
      , aktionsthema_bez AS aktion_thema_bez
      FROM
        DBP_ETL.fww_wme_pos_tmp dt1
      INNER JOIN
      ( SELECT
          spr_id
        , sap_spr_id
        FROM DBP_DATA.sap_dwh_spr_zu
        WHERE mandant_id = 1
      ) dwhspr
      ON dt1.SPRAS = 'D'
    ) w
      ON  k.mandant_id      = w.mandant_id
      AND k.spr_id          = w.org_spr_id
      AND k.aktion_thema_id = w.aktion_thema_id
  ) a


WHERE (1, a.aktion_thema_id, a.spr_id)
NOT IN
( SELECT
    mandant_id, aktion_thema_id, spr_id
  FROM DBP_DATA.aktion_thema_spr_zu
  WHERE mandant_id = 1
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.aktion_art_wup_zu_fdenorm  
--(  
--          mandant_id  
--        , aktion_id
--              , bewart_id
--              , art_id
--              , wup_id
--              , nb_id
--              , vk_aktion_brutto  
--              , bezugsweg_id  
--              , wrg_id
--              , grund_sperrung
--              , dat_sperrung
--              , aktion_thema_id
-- )
--SELECT 
--        1 
--       ,aktionsnummer
--       ,1002
--       ,artikelnr   
--       ,markt
--       ,wp.nb_id
--       ,CAST(aktionspreis AS DECIMAL (9,3) )   /  100 AS vk_aktion_brutto
--       ,COALESCE(bezugsquelle,-1)
--       ,COALESCE(waehrung_id ,'') AS waehrung_id 
--       ,CASE WHEN sperrkennzeichen IN (' ','', NULL) THEN NULL ELSE sperrkennzeichen END 
--       ,CASE WHEN sperrkennzeichen IN (' ','', NULL) THEN NULL
--             ELSE CAST(sperrdatum AS DATE FORMAT 'DD.MM.YYYY')
--            END AS dat_sperrung 
--       ,CASE WHEN aktionsthema IN (' ','', NULL) THEN ' ' ELSE aktionsthema END  AS aktion_thema_id
--            
--FROM  DBX_LOAD.fww_wme_pos  po
--
--  INNER JOIN
--    
--      (SELECT 
--          kl_art_id, 
--          mandant_id,
--          MAX(art_id) artikelnr
--      FROM          DBX_DATA.art   
--      GROUP BY  kl_art_id,  mandant_id
--      ) dt1
--
--    ON dt1.kl_art_id = CAST(po.artikelnummer     AS INTEGER) AND
--       dt1.mandant_id = 1
--
--  INNER JOIN
--       (SELECT
--           mandant_id   mand_id,
--           mandant_sap_id
--       FROM    DBX_DATA.mandant
--       ) ko
--    ON CAST (po.mandant AS INTEGER) = ko.mandant_sap_id
--        
--  INNER JOIN 
--        (SELECT 
--              mandant_id,
--              wup_id,
--              nb_id
--         FROM                DBX_DATA.wup
--        )wp
--    ON  po.markt      = wp.wup_id 
--    AND wp.mandant_id = 1
--    AND wp.nb_id      = 0
--
--GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
--;
--
--Comment from validation checker
--error line 28 at position 42 unexpected 'FORMAT'.
--             ELSE CAST(sperrdatum AS DATE  ^^^> FORMAT 'DD.MM.YYYY')
--syntax error line 28 at position 49 unexpected ''DD.MM.YYYY''.
--             ELSE CAST(sperrdatum AS DATE FORMAT  ^^^> 'DD.MM.YYYY')
--translated statement
INSERT INTO DBP_ETL.aktion_art_wup_zu_fdenorm  
(  
          mandant_id  
        , aktion_id
              , bewart_id
              , art_id
              , wup_id
              , nb_id
              , vk_aktion_brutto  
              , bezugsweg_id  
              , wrg_id
              , grund_sperrung
              , dat_sperrung
              , aktion_thema_id
 )
SELECT 
        1 
       ,aktionsnummer
       ,1002
       ,artikelnr   
       ,markt
       ,wp.nb_id
       ,CAST(aktionspreis AS DECIMAL (9,3) )   /  100 AS vk_aktion_brutto
       ,COALESCE(bezugsquelle,-1)
       ,COALESCE(waehrung_id ,'') AS waehrung_id 
       ,CASE WHEN sperrkennzeichen IN (' ','', NULL) THEN NULL ELSE sperrkennzeichen END 
       ,CASE WHEN sperrkennzeichen IN (' ','', NULL) THEN NULL
             ELSE CAST(sperrdatum AS DATE FORMAT 'DD.MM.YYYY')
            END AS dat_sperrung 
       ,CASE WHEN aktionsthema IN (' ','', NULL) THEN ' ' ELSE aktionsthema END  AS aktion_thema_id
            
FROM  DBP_ETL.fww_wme_pos  po

  INNER JOIN
    
      (SELECT 
          kl_art_id, 
          mandant_id,
          MAX(art_id) artikelnr
      FROM          DBP_DATA.art   
      GROUP BY  kl_art_id,  mandant_id
      ) dt1

    ON dt1.kl_art_id = CAST(po.artikelnummer     AS INTEGER) AND
       dt1.mandant_id = 1

  INNER JOIN
       (SELECT
           mandant_id   mand_id,
           mandant_sap_id
       FROM    DBP_DATA.mandant
       ) ko
    ON CAST (po.mandant AS INTEGER) = ko.mandant_sap_id
        
  INNER JOIN 
        (SELECT 
              mandant_id,
              wup_id,
              nb_id
         FROM                DBP_DATA.wup
        )wp
    ON  po.markt      = wp.wup_id 
    AND wp.mandant_id = 1
    AND wp.nb_id      = 0

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.aktion_art_wup_zu
WHERE (
       mandant_id, 
       aktion_id, 
       art_id,
       wup_id, 
       nb_id
       )
IN 
(
SELECT
       mandant_id, 
       aktion_id, 
       art_id,
       wup_id, 
       nb_id
FROM DBP_ETL.aktion_art_wup_zu_fdenorm
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.aktion_art_wup_zu
(  
    mandant_id  
  , aktion_id
  , bewart_id
  , art_id
  , wup_id
  , nb_id
  , vk_aktion_brutto  
  , bezugsweg_id  
  , wrg_id
  , grund_sperrung
  , dat_sperrung
  , aktion_thema_id
 )

SELECT
    mandant_id  
  , aktion_id
  , bewart_id
  , art_id
  , wup_id
  , nb_id
  , COALESCE(vk_aktion_brutto,0) 
  , bezugsweg_id  
  , wrg_id
  , grund_sperrung
  , dat_sperrung
  , aktion_thema_id

FROM  DBP_ETL.aktion_art_wup_zu_fdenorm
;

