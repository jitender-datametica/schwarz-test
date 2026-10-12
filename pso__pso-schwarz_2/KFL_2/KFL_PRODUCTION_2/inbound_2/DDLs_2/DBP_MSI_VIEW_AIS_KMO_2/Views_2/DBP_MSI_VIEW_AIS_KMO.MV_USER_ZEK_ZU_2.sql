CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_USER_ZEK_ZU_2
(
  user_id
, zek_id
, mandant_id
)
AS

SELECT
-- AP0186337/SPEC0239014 Entfernen der Whitespaces, falls User falsch angelegt wird / ssch1303 23.02.2024
TRIM (v01.user_id),
v01.zek_id,
v01.mandant_id

FROM dbp_security.user_zek_zu_2 v01
WHERE v01.mandant_id <> 1
/* INC8922078 Einfügen GROUP BY, da temporär vor Neuaufbau der Tabelle durch Prozedur Vervielfältigungen entstehen könne
   sschuecke 25.06.2024 */

GROUP BY 1, 2, 3;