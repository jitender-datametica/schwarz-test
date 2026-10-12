CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_SORTIMENT_USER_WG_ZU_2
-- WG_ID entspricht KFL owg_id!
(
MANDANT_ID,
USER_ID,
WG_ID,
FL_SUPERUSER
) 
AS
-- Ermittlung der Superuser
SELECT 
su.mandant_id,
TRIM (su.user_id),
o.owg_id AS wg_id,
1 AS fl_superuser
FROM dbp_security.sortiment_user_wg_zu_2 su
JOIN dbp_view.v_owg_per_2 o
ON su.mandant_id = o.mandant_id
WHERE su.wg_id = -999 AND (su.mandant_id, su.user_id) NOT IN 
(SELECT DISTINCT mandant_id, user_id FROM dbp_security.user_zek_zu_2)
GROUP BY 1,2,3,4
  
UNION

-- Ermittlung der User mit Teilsortiment auf Basis Userpflege AIS_INT (user_zek_zu_2) und Ermittlung der anzuzeigenden Warengruppen
-- Eine_2 reine Usersecurity auf Artikelebene ist nicht möglich, da die Daten so granular nicht vorliegen
SELECT
a.mandant_id,
TRIM (a.user_id),
b.owg_id AS wg_id,
0 AS fl_superuser
FROM dbp_security.user_zek_zu_2 a 
JOIN 
    (SELECT 
     b.mandant_id,
     b.zek_id,
     c.wg_id,
     d.owg_id
    FROM dbp_view.v_art_2 b
    JOIN dbp_view.v_art_wg_zu_per_2 c
    ON b.mandant_id = c.mandant_id
    AND b.art_id = c.art_id 
    JOIN dbp_view.v_wg_per_2 d
    ON c.mandant_id = d.mandant_id
    AND c.wg_id = d.wg_id
    WHERE c.arthiertyp_id = 2
    AND c.dat_bis = '9999-12-31'
    AND b.loesch_id NOT IN ('L')
    AND b.zek_id <> ''
    AND d.dat_bis = '9999-12-31' 
    GROUP BY 1,2,3,4) b
    
ON a.mandant_id = b.mandant_id
AND a.zek_id = b.zek_id
GROUP BY 1,2,3;