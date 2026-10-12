CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_lieferant_name_2
 AS
 SELECT
 t1.mandant_id,
 t1.kjwo_update AS A500,
 t1.matching_id,
 t1.akt_lieferant AS A418,
 t2.spr_id
 FROM dbp_view.v_sortiment_leistung_2 t1_2
 JOIN (SELECT
 mandant_id,
 spr_id
 FROM dbp_view.v_mandant_spr_zu_2
 UNION
 SELECT
 mandant_id,
 22 AS spr_id
 FROM dbp_view.v_mandant_spr_zu_2) t2
 ON t1.mandant_id=t2.mandant_id;