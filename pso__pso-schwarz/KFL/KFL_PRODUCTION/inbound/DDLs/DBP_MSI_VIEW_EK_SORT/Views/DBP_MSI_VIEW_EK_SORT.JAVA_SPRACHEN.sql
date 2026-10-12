CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_sprachen
AS
SELECT
spr_id,
spr_name,
spr_iso
FROM dbp_view.v_spr
WHERE dwh_spr = 1;