CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_SECURITY_USER_WG
(
MANDANT_ID,
USER_ID,
WG_ID
) 
AS
-- AP0190313/SPEC0236565 Anpassung View im Zuge der UserBereinigung im AIS - ssch1303 21.02.2024
SELECT 
su.mandant_id,
-- AP0190313/SPEC0242634 Entfernen der Whitespaces, falls User falsch angelegt wird / ssch1303 23.04.2024
TRIM (su.user_id),
o.wg_id
FROM dbp_security.sortiment_user_wg_zu su
JOIN dbp_view.v_wg_per o
ON su.mandant_id=o.mandant_id
WHERE su.wg_id = -999 AND (su.mandant_id, su.user_id) NOT IN
  (SELECT DISTINCT mandant_id, user_id FROM dbp_security.user_zek_zu)
  GROUP BY 1,2,3
  
UNION

SELECT
a.mandant_id,
-- AP0190313/SPEC0242634 Entfernen der Whitespaces, falls User falsch angelegt wird / ssch1303 23.04.2024
TRIM (a.user_id),
b.wg_id
FROM dbp_security.user_zek_zu a 
JOIN 
    (SELECT 
     b.mandant_id,
     b.zek_id,
     c.wg_id
    FROM dbp_view.v_art b
    JOIN dbp_view.v_art_wg_zu_per c
    ON b.mandant_id = c.mandant_id
    AND b.art_id = c.art_id 
    WHERE c.arthiertyp_id = 2
    AND c.dat_bis = '9999-12-31'
    AND b.loesch_id NOT IN ('L')
    AND b.zek_id <> ''
    GROUP BY 1,2,3) b
    
  ON a.mandant_id = b.mandant_id
  AND a.zek_id = b.zek_id
  GROUP BY 1,2,3
 ;