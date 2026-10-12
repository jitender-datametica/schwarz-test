CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_lieferant_spr_zu_1
 AS
 SELECT
 mandant_id,
 kjwo_update AS A500,
 akt_lieferant_id AS A16,
 spr_id,
 akt_lieferant_bez AS A418
 FROM dbp_view.v_sort_lieferant_spr_zu_1;