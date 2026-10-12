WITH cte1 AS (SELECT DISTINCT matnr,
   matkl,
    CASE
    WHEN zeinr IS NOT NULL
    THEN IFNULL(SPLIT(zeinr, ' ')[SAFE_OFFSET(- 1)], '')
    ELSE NULL
    END AS zeinr
  FROM idq_production_zsm.mara_1), cte_country AS (SELECT id,
    CASE
    WHEN id = 5
    THEN 'D0'
    WHEN id = 8
    THEN 'F0'
    WHEN id = 18
    THEN 'NI'
    ELSE country_1
    END AS country_1
  FROM idq_production_idq_results.ref_country_1
  WHERE id = CASE
     WHEN ${COUNTRY_ID} = 17 /* MT */
     THEN 13 /* IT */
     WHEN ${COUNTRY_ID} = 18 /* NIE */
     THEN 12 /* IE */
     WHEN ${COUNTRY_ID} = 33 /* EE */
     THEN 34 /* LV */
     ELSE ${COUNTRY_ID}
     END), cte2 AS (SELECT DISTINCT c1.matnr,
   c1.maktx,
    CASE
    WHEN c1.spras = '늆'
    THEN 'BE'
    WHEN c1.spras = '늇'
    THEN 'AT'
    WHEN c1.spras = '뎧'
    THEN 'CH'
    WHEN c1.spras = '딥'
    THEN 'IE'
    WHEN c1.spras = 'W'
    THEN 'BG'
    WHEN c1.spras = 'C'
    THEN 'CZ'
    WHEN c1.spras = 'K'
    THEN 'DK'
    WHEN c1.spras = 'D'
    THEN 'D0'
    WHEN c1.spras = 'G'
    THEN 'GR'
    WHEN c1.spras = 'E'
    THEN 'GB'
    WHEN c1.spras = 'S'
    THEN 'ES'
    WHEN c1.spras = '9'
    THEN 'EE'
    WHEN c1.spras = 'U'
    THEN 'FI'
    WHEN c1.spras = 'F'
    THEN 'F0'
    WHEN c1.spras = '6'
    THEN 'HR'
    WHEN c1.spras = 'H'
    THEN 'HU'
    WHEN c1.spras = 'I'
    THEN 'IT'
    WHEN c1.spras = 'X'
    THEN 'LT'
    WHEN c1.spras = 'Y'
    THEN 'LV'
    WHEN c1.spras = '봔'
    THEN 'MT'
    WHEN c1.spras = 'N'
    THEN 'NL'
    WHEN c1.spras = 'L'
    THEN 'PL'
    WHEN c1.spras = 'P'
    THEN 'PT'
    WHEN c1.spras = '4'
    THEN 'RO'
    WHEN c1.spras = 'd'
    THEN 'RS_1'
    WHEN c1.spras = 'Q'
    THEN 'SK'
    WHEN c1.spras = '5'
    THEN 'SI'
    WHEN c1.spras = 'V'
    THEN 'SE'
    WHEN c1.spras = '('
    THEN 'CS'
    WHEN c1.spras = ')'
    THEN 'CY'
    WHEN c1.spras = ','
    THEN 'NI'
    ELSE NULL
    END AS ekorg
  FROM idq_production_zsm.makt_1 AS c1
   INNER JOIN cte_country AS C2 ON LEFT(CASE
      WHEN c1.spras = '늆'
      THEN 'BE'
      WHEN c1.spras = '늇'
      THEN 'AT'
      WHEN c1.spras = '뎧'
      THEN 'CH'
      WHEN c1.spras = '딥'
      THEN 'IE'
      WHEN c1.spras = 'W'
      THEN 'BG'
      WHEN c1.spras = 'C'
      THEN 'CZ'
      WHEN c1.spras = 'K'
      THEN 'DK'
      WHEN c1.spras = 'D'
      THEN 'D0'
      WHEN c1.spras = 'G'
      THEN 'GR'
      WHEN c1.spras = 'E'
      THEN 'GB'
      WHEN c1.spras = 'S'
      THEN 'ES'
      WHEN c1.spras = '9'
      THEN 'EE'
      WHEN c1.spras = 'U'
      THEN 'FI'
      WHEN c1.spras = 'F'
      THEN 'F0'
      WHEN c1.spras = '6'
      THEN 'HR'
      WHEN c1.spras = 'H'
      THEN 'HU'
      WHEN c1.spras = 'I'
      THEN 'IT'
      WHEN c1.spras = 'X'
      THEN 'LT'
      WHEN c1.spras = 'Y'
      THEN 'LV'
      WHEN c1.spras = '봔'
      THEN 'MT'
      WHEN c1.spras = 'N'
      THEN 'NL'
      WHEN c1.spras = 'L'
      THEN 'PL'
      WHEN c1.spras = 'P'
      THEN 'PT'
      WHEN c1.spras = '4'
      THEN 'RO'
      WHEN c1.spras = 'd'
      THEN 'RS_1'
      WHEN c1.spras = 'Q'
      THEN 'SK'
      WHEN c1.spras = '5'
      THEN 'SI'
      WHEN c1.spras = 'V'
      THEN 'SE'
      WHEN c1.spras = '('
      THEN 'CS'
      WHEN c1.spras = ')'
      THEN 'CY'
      WHEN c1.spras = ','
      THEN 'NI'
      ELSE NULL
      END, 2) = C2.country_1), cte3 AS (SELECT DISTINCT c10.matnr,
    CASE
    WHEN ${COUNTRY_ID} IN (17, 18, 33) AND c10.desc_long_mlm IS NOT NULL
    THEN c10.desc_long_mlm
    ELSE c10.longdesc
    END AS longdesc,
    CASE
    WHEN ${COUNTRY_ID} IN (17, 18, 33) AND c10.desc_short_mlm IS NOT NULL
    THEN c10.desc_short_mlm
    ELSE NULL
    END AS shortdesc,
   c10.desc1,
   c10.desc2,
    CASE
    WHEN CAST(c10.temp_mess AS FLOAT64) = 0
    THEN NULL
    ELSE c10.temp_mess
    END AS temp_mess,
    CASE
    WHEN c10.temp_min = - 273
    THEN NULL
    ELSE CAST(c10.temp_min AS NUMERIC)
    END AS temp_min,
    CASE
    WHEN c10.temp_max = 9999
    THEN NULL
    ELSE CAST(c10.temp_max AS NUMERIC)
    END AS temp_max,
    CASE
    WHEN c10.plu = 0
    THEN NULL
    ELSE c10.plu
    END AS plu,
   c10.ekorg,
    CASE
    WHEN c10.art_cat = '1'
    THEN 'Neulistung EM'
    WHEN c10.art_cat = '2'
    THEN 'Neulistung M'
    WHEN c10.art_cat = '3'
    THEN 'Normalsortiment EM'
    WHEN c10.art_cat = '4'
    THEN 'Normalsortiment M'
    WHEN c10.art_cat = '5'
    THEN 'Aktionsartikel EM'
    WHEN c10.art_cat = '6'
    THEN 'Aktionsartikel M'
    WHEN c10.art_cat = '7'
    THEN 'Testartikel EM'
    WHEN c10.art_cat = '8'
    THEN 'Testartikel M'
    WHEN c10.art_cat = '9'
    THEN 'Auslistung EM'
    WHEN c10.art_cat = '10'
    THEN 'Auslistung M'
    ELSE NULL
    END AS art_cat,
   c10.wstaw
  FROM idq_production_zsm.zsm_mm_obstgem_1 AS c10
   INNER JOIN cte_country AS C2 ON LEFT(c10.ekorg, 2) = C2.country_1), cte4 AS (SELECT DISTINCT A.matnr,
   B.item_family_id,
   B.node
  FROM (SELECT matnr,
     node
    FROM idq_production_zsm.wrf_matgrp_sku_1) AS A
   INNER JOIN (SELECT node,
     LTRIM(SUBSTR(REGEXP_EXTRACT(ltext, '\\.(\\d+)'), 2, 3), '0') AS item_family_id
    FROM idq_production_zsm.wrf_matgrp_strct_1) AS B ON A.node = B.node), cte5 AS (SELECT matnr,
   STRING_AGG(CAST(merkmale AS STRING), '|' ORDER BY merkmale IS NULL, merkmale) AS merkmale
  FROM (SELECT DISTINCT A.matnr,
      CASE
      WHEN B.atinn = 5 AND B.atwrt = 'JA'
      THEN 'INT_BIO'
      WHEN B.atinn = 28 AND B.atwrt = 'INT_FAIRTRADE'
      THEN 'INT_Fairtrade'
      ELSE NULL
      END AS merkmale
    FROM (SELECT objek AS matnr,
       cuobj AS objek
      FROM idq_production_zsm.inob_1) AS A
     INNER JOIN (SELECT LTRIM(objek, '0') AS objek,
       atinn,
       atwrt
      FROM idq_production_zsm.ausp_1
      WHERE atinn = 5 AND atwrt = 'JA'
       OR atinn = 28 AND atwrt = 'INT_FAIRTRADE') AS B ON A.objek = B.objek) AS C
  GROUP BY matnr), cte6 AS (SELECT c11.matnr,
   c11.ean11,
   c11.ekorg
  FROM idq_production_zsm.zsm_mm_mean_ven_1 AS c11
   INNER JOIN cte_country AS C2 ON LEFT(c11.ekorg, 2) = C2.country_1
  GROUP BY c11.matnr,
   c11.ean11,
   c11.ekorg) (-- EKORG FILTER
 SELECT DISTINCT LTRIM(A.matnr, '0') AS artikelnr,
    CASE
    WHEN C.shortdesc IS NOT NULL
    THEN C.shortdesc
    ELSE B.maktx
    END AS bez_kurz,
   C.longdesc AS bez_lang,
   C.desc1 AS bez_kurz2,
   C.desc2 AS bez_kurz3,
   A.zeinr AS pack_type,
   A.matkl AS artgrupnr,
   D.item_family_id AS itemfamily_id,
   E.merkmale,
   C.art_cat AS article_cat,
   C.temp_mess AS temp_type,
   C.temp_min,
   C.temp_max,
   C.plu,
   t25.ean11 AS eancode,
   C.wstaw AS intrastat
  FROM cte1 AS A
   LEFT JOIN cte2 AS B ON A.matnr = B.matnr
   LEFT JOIN cte3 AS C ON A.matnr = C.matnr
   LEFT JOIN cte4 AS D ON A.matnr = D.matnr
   LEFT JOIN cte5 AS E ON A.matnr = E.matnr
   LEFT JOIN (SELECT DISTINCT *
    FROM cte6 AS F) AS t25 ON A.matnr = t25.matnr -- ARTGRUPNR FILTER

  WHERE CAST(A.matkl AS INTEGER) IN (10, 11, 12, 13)
   AND (t25.matnr IS NOT NULL OR C.matnr IS NOT NULL)
  ORDER BY artikelnr NULLS LAST);