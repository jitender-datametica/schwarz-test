CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_security_user_1
AS
SELECT
a.mandant_id,
c.user_id,
a.wg_id
FROM dbp_view.v_art_wg_zu_per_1 a
JOIN dbp_view.v_art_1 b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
JOIN dbp_security.user_zek_zu_1 c
ON b.mandant_id = c.mandant_id
AND b.zek_id = c.zek_id
WHERE a.arthiertyp_id = 2
AND a.dat_bis = '9999-12-31'
AND b.loesch_id NOT IN ('L')
GROUP BY a.mandant_id,c.user_id,a.wg_id;