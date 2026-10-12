CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_artikelrolle_spr_zu
AS
SELECT
mandant_id,
artikelrolle_id,
spr_id,
artikelrolle_bez
FROM dbp_view.v_artikelrolle_spr_zu;