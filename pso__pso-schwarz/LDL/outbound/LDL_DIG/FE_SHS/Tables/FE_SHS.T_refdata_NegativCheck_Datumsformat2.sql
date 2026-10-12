CREATE TABLE IF NOT EXISTS ldl_dig_fe_shs.t_refdata_negativcheck_datumsformat2 AS WITH REFDATA AS (SELECT ROUND(CAST(COLL.debitor AS BIGNUMERIC), 0) AS id,
    CASE
    WHEN KNA.name1 IS NOT NULL
    THEN IFNULL(SPLIT(KNA.name1, ' ')[SAFE_OFFSET(0)], '')
    ELSE NULL
    END AS firstname,
   RIGHT(KNA.name1, LENGTH(KNA.name1) - STRPOS(KNA.name1, ' ')) AS lastname,
   BUT.birthdt AS dateofbirth,
   ADRC.country,
   ADRC.postcode1 AS zipcode,
   ADRC.city1 AS city,
   ADRC.street AS streetname,
   ADRC.housenum1 AS streetnumber,
   ADRC.strsuppl2 AS addresssuffix,
   'RA' AS adresstyp
  FROM (SELECT DISTINCT gpart AS debitor
     FROM ldl_dig_etl.t_dfkkcoll
     WHERE gpart <> '1000940044'
      AND agdat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
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
   LEFT JOIN ldl_dig_etl.t_kna1 AS KNA ON COLL.debitor = KNA.kunnr
   LEFT JOIN ldl_dig_etl.t_but000 AS BUT ON KNA.kunnr = BUT.partner
   LEFT JOIN ldl_dig_etl.t_adrc AS ADRC ON KNA.adrnr = ADRC.addrnumber
  WHERE ADRC.country = 'DE') (SELECT *
  FROM REFDATA);