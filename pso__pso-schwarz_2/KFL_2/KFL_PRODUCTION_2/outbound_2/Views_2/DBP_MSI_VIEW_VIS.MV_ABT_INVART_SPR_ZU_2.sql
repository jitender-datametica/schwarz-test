CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abt_invart_spr_zu_2 AS SELECT AIZ.abt_invart_id,
 MAX(CASE
   WHEN ABT.spr_id = 22
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' OWG'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez,
 MAX(CASE
   WHEN ABT.spr_id = 124
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' OWG'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez_cz,
 MAX(CASE
   WHEN ABT.spr_id = 108
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' OWG'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez_sk,
 MAX(CASE
   WHEN ABT.spr_id = 65
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' OWG'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez_hr,
 MAX(CASE
   WHEN ABT.spr_id = 90
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' NGT'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez_pl,
 MAX(CASE
   WHEN ABT.spr_id = 95
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' OWG'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez_ro,
 MAX(CASE
   WHEN ABT.spr_id = 18
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' OWG'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez_bg,
 MAX(CASE
   WHEN ABT.spr_id = 22
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez || ' (' || ABT.abt_bez || ')'
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN ABT.abt_bez || ' OWG'
    ELSE ABT.abt_bez || ' ' || INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS abt_invart_bez_de,
 MAX(CASE
   WHEN ABT.spr_id = 22
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez,
 MAX(CASE
   WHEN ABT.spr_id = 124
   THEN CASE
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez_cz,
 MAX(CASE
   WHEN ABT.spr_id = 108
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez_sk,
 MAX(CASE
   WHEN ABT.spr_id = 65
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez_hr,
 MAX(CASE
   WHEN ABT.spr_id = 90
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'NGT'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez_pl,
 MAX(CASE
   WHEN ABT.spr_id = 95
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez_ro,
 MAX(CASE
   WHEN ABT.spr_id = 18
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez_bg,
 MAX(CASE
   WHEN ABT.spr_id = 22
   THEN CASE
    WHEN AIZ.abt_invart_id BETWEEN 90 AND 99
    THEN INV.inventurart_int_bez
    WHEN AIZ.abt_invart_id = 50
    THEN ABT.abt_bez
    WHEN AIZ.abt_invart_id IN (43, 63, 73, 83)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS invart_bez_de
FROM kfl_production_dbp_msi_view_vis.mv_abt_inventurart_int_zu_2 AS AIZ
 INNER JOIN kfl_production_dbp_view.v_abt_spr_zu_2 AS ABT_2 ON AIZ.abt_id = ABT.abt_id
 INNER JOIN kfl_production_dbp_view.v_inventurart_int_spr_zu_2 AS INV ON AIZ.inventurart_int_id = INV.inventurart_int_id
  AND ABT.spr_id = INV.spr_id
GROUP BY AIZ.abt_invart_id;