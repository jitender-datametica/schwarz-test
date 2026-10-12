CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_LAND_BEZ
(
MANDANT_ID,
SPR_ID,
MANDANT_BEZ
) 
AS
SELECT
v01.mandant_id,
v01.spr_id,
v01.mandant_bez
FROM  (SELECT DISTINCT m.mandant_id,
spr_id,
land_bez AS mandant_bez
FROM dbp_view.v_land l
INNER JOIN
(SELECT
mandant_id,
CASE WHEN mandant_kbez = 'D'
THEN 'DE'
ELSE  mandant_kbez
END land_id
FROM dbp_view.v_mandant ) m
ON  l.land_id=m.land_id
INNER JOIN dbp_view.v_mandant_spr_zu msz
ON
l.mandant_id =msz.mandant_id) v01;