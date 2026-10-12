CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_user_hr_objekt_id1_pflege (user_id, mandant_id, mandant_kbez,
hr_objekt_ebene1_id, pflege_fg) AS SELECT LOWER(sub.user_id) AS user_id,
 sub.mandant_id,
 V1.mandant_kbez,
 sub.hr_objekt_ebene1_id,
 MAX(sub.pflege_fg) AS pflege_fg
FROM (SELECT V1.user_id,
    v2.mandant_id,
    v2.hr_objekt_ebene1_id,
    '0' AS pflege_fg
   FROM kfl_production_dbp_security.l_msi_user AS V1
    INNER JOIN (SELECT DISTINCT mandant_id,
      hr_objekt_ebene1_id
     FROM kfl_production_dbp_view.v_org_einheit_hierarchie
     WHERE mandant_id = 1 AND hr_objekt_ebene1_id = 50526439
      OR mandant_id = 1 AND hr_objekt_ebene1_id = 51539142
      OR mandant_id = 2 AND hr_objekt_ebene1_id = 15000149
      OR mandant_id = 5 AND hr_objekt_ebene1_id = 25000068
      OR mandant_id = 4 AND hr_objekt_ebene1_id = 35084871
      OR mandant_id = 3 AND hr_objekt_ebene1_id = 20000000
      OR mandant_id = 6 AND hr_objekt_ebene1_id = 30000666
      OR mandant_id = 7 AND hr_objekt_ebene1_id = 35000075
      OR mandant_id = 8 AND hr_objekt_ebene1_id = 50028917) AS v2 ON TRUE
   WHERE V1.msi_produkt_bez LIKE 'SHR'
   UNION DISTINCT
   SELECT user_id,
    mandant_id,
    hr_objekt_ebene1_id,
    '1' AS pflege_fg
   FROM kfl_production_dbp_security.user_hr_objekt_id_zu
   WHERE user_id IN (SELECT user_id
      FROM kfl_production_dbp_security.l_msi_user
      WHERE msi_produkt_bez = 'SHR')
    AND (mandant_id = 1 AND hr_objekt_ebene1_id = 50526439 OR mandant_id = 1 AND hr_objekt_ebene1_id = 51539142 OR
              mandant_id = 2 AND hr_objekt_ebene1_id = 15000149 OR mandant_id = 5 AND hr_objekt_ebene1_id = 25000068 OR
            mandant_id = 4 AND hr_objekt_ebene1_id = 35084871 OR mandant_id = 3 AND hr_objekt_ebene1_id = 20000000 OR
          mandant_id = 6 AND hr_objekt_ebene1_id = 30000666 OR mandant_id = 7 AND hr_objekt_ebene1_id = 35000075 OR
        mandant_id = 8 AND hr_objekt_ebene1_id = 50028917)) AS sub
 INNER JOIN kfl_production_dbp_view.v_mandant AS V1 ON sub.mandant_id = V1.mandant_id
GROUP BY sub.user_id,
 sub.mandant_id,
 V1.mandant_kbez,
 sub.hr_objekt_ebene1_id;