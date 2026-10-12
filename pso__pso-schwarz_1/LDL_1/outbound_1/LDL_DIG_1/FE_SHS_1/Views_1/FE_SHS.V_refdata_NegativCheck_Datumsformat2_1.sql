CREATE OR REPLACE VIEW ldl_dig_fe_shs.v_refdata_negativcheck_datumsformat2_1 AS WITH REFDATA AS (SELECT ROUND(CAST(COLL.debitor AS BIGNUMERIC)
    , 0) AS id,
    CASE
    WHEN KNA.name1 IS NOT NULL
    THEN IFNULL(SPLIT(KNA.name1, ' ')[SAFE_OFFSET(0)], '')
    ELSE NULL
    END AS firstname,
   RIGHT(KNA.name1, LENGTH(KNA.name1) - STRPOS(KNA.name1, ' ')) AS lastname,
   BUT.birthdt AS dateofbirth,
   ADRC.country_1,
   ADRC.postcode1 AS zipcode,
   ADRC.city1 AS city,
   ADRC.street AS streetname,
   ADRC.housenum1 AS streetnumber,
   ADRC.strsuppl2 AS addresssuffix,
   'RA_1' AS adresstyp
  FROM (SELECT DISTINCT T1.gpart AS debitor
     FROM ldl_dig_etl.t_dfkkcoll_1 AS T1_1
      LEFT JOIN ldl_dig_etl.t_dfkkop_1 AS T2 ON T1.opbel = T2.opbel AND T1.inkps = T2.inkps
     WHERE T1.gpart <> '1000940044'
      AND T1.agdat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
      AND T2.augst = ''
     UNION ALL
     SELECT *
     FROM (SELECT '1040004469' AS debitor
        UNION ALL
        SELECT '1040002536' AS debitor
        UNION ALL
        SELECT '1040001484' AS debitor
        UNION ALL
        SELECT '1040004769' AS debitor
        UNION ALL
        SELECT '1040005216' AS debitor
        UNION ALL
        SELECT '1040002552' AS debitor
        UNION ALL
        SELECT '1040001801' AS debitor
        UNION ALL
        SELECT '1040003136' AS debitor
        UNION ALL
        SELECT '1040004260' AS debitor
        UNION ALL
        SELECT '1040003262' AS debitor
        UNION ALL
        SELECT '1040003000' AS debitor
        UNION ALL
        SELECT '1040004766' AS debitor
        UNION ALL
        SELECT '1040005019' AS debitor
        UNION ALL
        SELECT '1040003203' AS debitor
        UNION ALL
        SELECT '1040004248' AS debitor
        UNION ALL
        SELECT '1040001980' AS debitor
        UNION ALL
        SELECT '1040003594' AS debitor
        UNION ALL
        SELECT '1040002388' AS debitor
        UNION ALL
        SELECT '1040004528' AS debitor
        UNION ALL
        SELECT '1040004595' AS debitor
        UNION ALL
        SELECT '1040003208' AS debitor)) AS COLL
   LEFT JOIN ldl_dig_etl.t_kna1_1 AS KNA ON COLL.debitor = KNA.kunnr
   LEFT JOIN ldl_dig_etl.t_but000_1 AS BUT ON KNA.kunnr = BUT.partner
   LEFT JOIN ldl_dig_etl.t_adrc_1 AS ADRC_1 ON KNA.adrnr = ADRC.addrnumber
  WHERE ADRC.country_1 = 'DE') (SELECT *
  FROM REFDATA);