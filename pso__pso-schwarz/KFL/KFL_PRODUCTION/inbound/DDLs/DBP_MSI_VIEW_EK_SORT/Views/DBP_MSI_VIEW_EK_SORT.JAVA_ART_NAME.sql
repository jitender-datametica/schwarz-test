CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_art_name
AS
SELECT
t1.mandant_id,
t1.kjwo_update as A500,
t1.matching_id,
t2.art_bez as A12,
t2.spr_id
FROM dbp_view.v_sortiment_leistung t1
JOIN dbp_view.v_art_spr_zu t2
ON t1.mandant_id=t2.mandant_id and t1.art_id=t2.art_id;