CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_SECURITY_USER_2
(
MANDANT_ID,
USER_ID,
WG_ID
) 
AS
SELECT
a.mandant_id,
c.user_id,
a.wg_id
FROM dbp_view.v_art_wg_zu_per_2 a
JOIN dbp_view.v_art_2 b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
JOIN dbp_security.user_zek_zu_2 c
ON b.mandant_id = c.mandant_id
AND b.zek_id = c.zek_id
WHERE a.arthiertyp_id = 2
AND a.dat_bis = '9999-12-31'
AND b.loesch_id NOT IN ('L')
GROUP BY a.mandant_id,c.user_id,a.wg_id;