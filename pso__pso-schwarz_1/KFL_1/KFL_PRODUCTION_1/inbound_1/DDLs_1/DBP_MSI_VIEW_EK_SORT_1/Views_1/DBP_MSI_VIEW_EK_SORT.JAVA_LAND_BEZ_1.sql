CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_land_bez_1
AS
SELECT
v01.mandant_id,
v01.spr_id,
v01.mandant_bez
FROM  (SELECT  DISTINCT m.mandant_id,
spr_id,
land_bez AS mandant_bez
FROM dbp_view.v_land_1 l
INNER JOIN
(SELECT
mandant_id,
CASE WHEN mandant_kbez = 'D'
THEN 'DE'
ELSE  mandant_kbez
END land_id
FROM dbp_view.v_mandant_1 ) m
ON  l.land_id=m.land_id
INNER JOIN dbp_view.v_mandant_spr_zu_1 msz
ON
l.mandant_id =msz.mandant_id) v01;