-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

CREATE OR REPLACE VIEW dbp_msi_view_shr_materialized.mv_user_hr_objekt_id1_pflege (user_id, mandant_id, mandant_kbez,
hr_objekt_ebene1_id, pflege_fg) AS -- Haken im FE dann gesetzt, wenn User einen Eintrag hat

-- Einträge, zum Auffüllen der Pflegeansicht
 -- DE

-- INTEGER OR (mandant_id = 2 AND hr_objekt_ebene1_id = 15000149)  -- CZ
 -- SK
 -- MD
 -- PL
 -- HR
 -- RO
 -- BG

-- da in Tabelle auch LIN-User, explizite Filterung auf die SHR User und Sicherstellung, dass nur die für SHR relevanten ebene1_ids angezeigt werden

-- DE
 -- INTEGER OR (mandant_id = 2 AND hr_objekt_ebene1_id = 15000149)  -- CZ
 -- SK
 -- MD
 -- PL
 -- HR
 -- RO

-- BG
 SELECT LOWER(sub.user_id) AS user_id,
 sub.mandant_id,
 v1.mandant_kbez,
 sub.hr_objekt_ebene1_id,
 MAX(sub.pflege_fg) AS pflege_fg
FROM (SELECT v1.user_id,
    v2.mandant_id,
    v2.hr_objekt_ebene1_id,
    '0' AS pflege_fg
   FROM kfl_production_dbp_security.l_msi_user AS v1
    INNER JOIN (SELECT DISTINCT mandant_id,
      hr_objekt_ebene1_id
     FROM kfl_production_dbp_view.v_org_einheit_hierarchie
     WHERE mandant_id = 1 AND hr_objekt_ebene1_id = 50526439
      OR mandant_id = 1 AND hr_objekt_ebene1_id = 51539142
      OR mandant_id = 5 AND hr_objekt_ebene1_id = 25000068
      OR mandant_id = 4 AND hr_objekt_ebene1_id = 35084871
      OR mandant_id = 3 AND hr_objekt_ebene1_id = 20000000
      OR mandant_id = 6 AND hr_objekt_ebene1_id = 30000666
      OR mandant_id = 7 AND hr_objekt_ebene1_id = 35000075
      OR mandant_id = 8 AND hr_objekt_ebene1_id = 50028917) AS v2 ON TRUE
   WHERE v1.msi_produkt_bez LIKE 'SHR'
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
             mandant_id = 5 AND hr_objekt_ebene1_id = 25000068 OR mandant_id = 4 AND hr_objekt_ebene1_id = 35084871 OR
           mandant_id = 3 AND hr_objekt_ebene1_id = 20000000 OR mandant_id = 6 AND hr_objekt_ebene1_id = 30000666 OR
         mandant_id = 7 AND hr_objekt_ebene1_id = 35000075 OR mandant_id = 8 AND hr_objekt_ebene1_id = 50028917)) AS sub
 
 INNER JOIN kfl_production_dbp_view.v_mandant AS v1 ON sub.mandant_id = v1.mandant_id
GROUP BY sub.user_id,
 sub.mandant_id,
 v1.mandant_kbez,
 sub.hr_objekt_ebene1_id;