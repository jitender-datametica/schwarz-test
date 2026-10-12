CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_LIEFERANT_NAME_1
(
MANDANT_ID,
A500,
MATCHING_ID,
A418,
SPR_ID
) 
AS
SELECT
t1.mandant_id,
t1.kjwo_update AS A500,
t1.matching_id,
t1.akt_lieferant AS A418,
t2.spr_id
FROM dbp_view.v_sortiment_leistung_1 t1_1
JOIN (SELECT
 mandant_id,
 spr_id
 FROM dbp_view.v_mandant_spr_zu_1
 UNION
 SELECT
 mandant_id,
 22 AS spr_id
 FROM dbp_view.v_mandant_spr_zu_1) t2
 ON t1.mandant_id=t2.mandant_id;