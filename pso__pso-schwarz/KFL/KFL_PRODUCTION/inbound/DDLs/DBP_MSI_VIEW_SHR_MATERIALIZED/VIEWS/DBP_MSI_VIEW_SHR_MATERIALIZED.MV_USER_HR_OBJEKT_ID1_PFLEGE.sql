create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_USER_HR_OBJEKT_ID1_PFLEGE(
	USER_ID,
	MANDANT_ID,
	MANDANT_KBEZ,
	HR_OBJEKT_EBENE1_ID,
	PFLEGE_FG
) as
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT
     LOWER(sub.user_id) AS user_id
   , sub.mandant_id
   , v1.mandant_kbez
   , sub.hr_objekt_ebene1_id
   , MAX(sub.pflege_fg) AS pflege_fg -- Haken im FE dann gesetzt, wenn User einen Eintrag hat
   
   FROM
	
   --Einträge, zum Auffüllen der Pflegeansicht
   (SELECT 
     v1.user_id
   , v2.mandant_id
   , v2.hr_objekt_ebene1_id
   , '0' AS pflege_fg

   FROM dbp_security.l_msi_user v1
   CROSS JOIN (SELECT 
   DISTINCT mandant_id
   , hr_objekt_ebene1_id
   FROM dbp_view.v_org_einheit_hierarchie
   WHERE (
   (mandant_id = 1 AND hr_objekt_ebene1_id = 50526439)  -- DE
   OR (mandant_id = 1 AND hr_objekt_ebene1_id = 51539142)  -- INT
   OR (mandant_id = 2 AND hr_objekt_ebene1_id = 15000149)  -- CZ
   OR (mandant_id = 5 AND hr_objekt_ebene1_id = 25000068)  -- SK
   OR (mandant_id = 4 AND hr_objekt_ebene1_id = 35084871)  -- MD
   OR (mandant_id = 3 AND hr_objekt_ebene1_id = 20000000)  -- PL
   OR (mandant_id = 6 AND hr_objekt_ebene1_id = 30000666)  -- HR
   OR (mandant_id = 7 AND hr_objekt_ebene1_id = 35000075)  -- RO
   OR (mandant_id = 8 AND hr_objekt_ebene1_id = 50028917)  -- BG
   )
   ) v2
   WHERE v1.msi_produkt_bez LIKE 'SHR'

   UNION
   SELECT 
     user_id
   , mandant_id
   , hr_objekt_ebene1_id
   , '1' AS pflege_fg
   FROM dbp_security.user_hr_objekt_id_zu

   -- da in Tabelle auch LIN-User, explizite Filterung auf die SHR User und Sicherstellung, dass nur die für SHR relevanten ebene1_ids angezeigt werden
   WHERE user_id IN (SELECT user_id FROM dbp_security.l_msi_user WHERE msi_produkt_bez = 'SHR')
   AND (
   (mandant_id = 1 AND hr_objekt_ebene1_id = 50526439)  -- DE
   OR (mandant_id = 1 AND hr_objekt_ebene1_id = 51539142)  -- INT
   OR (mandant_id = 2 AND hr_objekt_ebene1_id = 15000149)  -- CZ
   OR (mandant_id = 5 AND hr_objekt_ebene1_id = 25000068)  -- SK
   OR (mandant_id = 4 AND hr_objekt_ebene1_id = 35084871)  -- MD
   OR (mandant_id = 3 AND hr_objekt_ebene1_id = 20000000)  -- PL
   OR (mandant_id = 6 AND hr_objekt_ebene1_id = 30000666)  -- HR
   OR (mandant_id = 7 AND hr_objekt_ebene1_id = 35000075)  -- RO
   OR (mandant_id = 8 AND hr_objekt_ebene1_id = 50028917)  -- BG
   )
   )  sub

   JOIN dbp_view.v_mandant v1
   ON sub.mandant_id = v1.mandant_id

   GROUP BY
     sub.user_id
   , sub.mandant_id
   , v1.mandant_kbez
   , sub.hr_objekt_ebene1_id;