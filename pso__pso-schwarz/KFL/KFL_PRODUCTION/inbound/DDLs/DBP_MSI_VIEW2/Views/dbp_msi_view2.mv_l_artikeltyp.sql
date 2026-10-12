CREATE OR REPLACE VIEW dbp_msi_view2.mv_l_artikeltyp
(
artikeltyp_id
,artikeltyp_bez)
AS
SELECT
artikeltyp_id,
artikeltyp_bez
FROM dbp_view.v_artikeltyp_spr_zu
WHERE mandant_id = 1 and spr_id = 22;