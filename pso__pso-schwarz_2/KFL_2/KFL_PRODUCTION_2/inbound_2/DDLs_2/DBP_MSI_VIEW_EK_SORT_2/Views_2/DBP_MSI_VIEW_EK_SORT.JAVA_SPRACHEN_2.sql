CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_sprachen_2
AS
SELECT
spr_id,
spr_name,
spr_iso
FROM dbp_view.v_spr_2
WHERE dwh_spr = 1;