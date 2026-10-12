CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.JAVA_SECURITY_USER_ZEK
(
	MANDANT_ID,
	USER_ID,
	ZEK_ID
)
AS
-- AP0190313/SPEC0236565 Anpassung View im Zuge der UserBereinigung im AIS - ssch1303 21.02.2024
   SELECT 
  su.mandant_id,
-- AP0190313/SPEC0242634 Entfernen der Whitespaces, falls User falsch angelegt wird / ssch1303 23.04.2024
  TRIM (su.user_id),
  a.zek_id AS zek_id
  FROM dbp_security.sortiment_user_wg_zu su
  JOIN 
  (SELECT mandant_id, zek_id 
   FROM dbp_view.v_art 
   WHERE dat_bis = '9999-12-31' GROUP BY 1,2) a
   
  ON su.mandant_id=a.mandant_id
  
  WHERE su.wg_id = -999 AND a.zek_id <> '' AND a.zek_id IS NOT NULL AND (su.mandant_id,su.user_id) NOT IN 
  (SELECT DISTINCT mandant_id,user_id FROM dbp_security.user_zek_zu) 
  AND (a.zek_id, a.mandant_id) IN 
  (SELECT zek_id,mandant_id 
   FROM dbp_view.v_art WHERE dat_bis = '9999-12-31'
   )
  GROUP BY 1,2,3
  
UNION 

  SELECT
  mandant_id,
-- AP0190313/SPEC0242634 Entfernen der Whitespaces, falls User falsch angelegt wird / ssch1303 23.04.2024
  TRIM (user_id),
  zek_id 
  FROM dbp_security.user_zek_zu
  WHERE zek_id <> '' AND zek_id IS NOT NULL AND (zek_id,mandant_id) IN 
  (SELECT zek_id, mandant_id 
   FROM dbp_view.v_art WHERE dat_bis = '9999-12-31')
  GROUP BY 1,2,3 ;