CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_ART_NAME_2
(
MANDANT_ID,
A500,
MATCHING_ID,
A12,
SPR_ID
) 
AS
SELECT
t1.mandant_id,
t1.kjwo_update AS A500,
t1.matching_id,
t2.art_bez AS A12,
t2.spr_id
FROM dbp_view.v_sortiment_leistung_2 t1_2
JOIN dbp_view.v_art_spr_zu_2 t2
ON t1.mandant_id=t2.mandant_id AND t1.art_id=t2.art_id;