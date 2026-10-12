CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_bestandartikel AS WITH LATESTBESTANDARTIKEL AS (SELECT client_id,
   wh_nr AS wh_id,
   artikelnr,
   menge,
   retail_price,
   datum,
   dwh_valid_from,
   dwh_valid_to,
   dwh_updated,
   deleted_fg,
    CASE
    WHEN menge > 0
    THEN 1
    WHEN menge < 0
    THEN 2
    ELSE 3
    END AS menge_type
  FROM ldl_logop_fe_mstr_logop.v_wawi_bestandartikel_act
  WHERE menge <> 0), MISSINGITEMS AS (SELECT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   itemnr,
   status,
   missing_until,
   wamas_reason,
   scn,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_missing_items
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND missing_until IS NULL
   AND status < 40
   AND NOT deleted_fg), ITEMSTATUSBEGRENZT AS (SELECT client_id,
    CASE
    WHEN client_id = 13 AND warehouseno = 600
    THEN 60
    WHEN client_id = 18 AND warehouseno = 20
    THEN 4
    WHEN client_id = 21 AND warehouseno = 20
    THEN 22
    ELSE warehouseno
    END AS wh_id,
   itemno,
   status,
   reason,
   scn,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_itemstatus
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND status IN (1, 2, 3, 4, 13, 14)
   AND NOT deleted_fg), LATESTBESTANDARTIKEL_SEARCHFUNCTION AS (SELECT client_id,
   wh_nr AS wh_id,
   artikelnr,
   menge,
   retail_price,
   datum,
   dwh_valid_from,
   dwh_valid_to,
   dwh_updated,
   deleted_fg
  FROM ldl_logop_fe_mstr_logop.v_wawi_bestandartikel_act), ITEMSTATUSFULL AS (SELECT client_id,
    CASE
    WHEN client_id = 13 AND warehouseno = 600
    THEN 60
    WHEN client_id = 18 AND warehouseno = 20
    THEN 4
    WHEN client_id = 21 AND warehouseno = 20
    THEN 22
    ELSE warehouseno
    END AS wh_id,
   itemno,
   status,
   reason,
   scn,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_itemstatus
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg) (SELECT *
  FROM (((SELECT client_id,
        wh_id,
        artikelnr,
        menge,
        retail_price,
        999 AS status,
        datum,
        CAST(NULL AS DATETIME) AS missing_until,
        999 AS wamas_reason,
        dwh_valid_from,
        dwh_valid_to,
        dwh_updated,
        deleted_fg,
        1 AS missing_fg
       FROM LATESTBESTANDARTIKEL
       WHERE menge_type = 2
       UNION DISTINCT
       SELECT a.client_id,
        a.wh_id,
        a.artikelnr,
        a.menge,
        a.retail_price,
        b.status,
        a.datum,
        b.missing_until,
        b.wamas_reason,
        a.dwh_valid_from,
        a.dwh_valid_to,
        a.dwh_updated,
        a.deleted_fg,
        2 AS missing_fg
       FROM LATESTBESTANDARTIKEL AS a
        INNER JOIN MISSINGITEMS AS b ON a.client_id = b.client_id AND a.wh_id = b.wh_id AND a.artikelnr = b.itemnr
       WHERE a.menge_type = 1)
      UNION DISTINCT
      SELECT e.client_id,
       e.wh_id,
       e.artikelnr,
       e.menge,
       e.retail_price,
       f.status,
       e.datum,
       CAST(NULL AS DATETIME) AS missing_until,
       ROUND(SAFE_CAST(f.reason AS BIGNUMERIC), 0) AS wamas_reason,
       e.dwh_valid_from,
       e.dwh_valid_to,
       e.dwh_updated,
       e.deleted_fg,
       3 AS missing_fg
      FROM LATESTBESTANDARTIKEL AS e
       INNER JOIN ITEMSTATUSBEGRENZT AS f ON e.client_id = f.client_id AND e.wh_id = f.wh_id AND e.artikelnr = f.itemno
     )
     UNION DISTINCT
     SELECT lbf.client_id,
      lbf.wh_id,
      lbf.artikelnr,
      lbf.menge,
      lbf.retail_price,
      isf.status,
      lbf.datum,
      CAST(NULL AS DATETIME) AS missing_until,
      996 AS wamas_reason,
      lbf.dwh_valid_from,
      lbf.dwh_valid_to,
      lbf.dwh_updated,
      lbf.deleted_fg,
      4 AS missing_fg
     FROM LATESTBESTANDARTIKEL_SEARCHFUNCTION AS lbf
      LEFT JOIN ITEMSTATUSFULL AS isf ON lbf.client_id = isf.client_id AND lbf.wh_id = isf.wh_id AND lbf.artikelnr = isf
        .itemno));