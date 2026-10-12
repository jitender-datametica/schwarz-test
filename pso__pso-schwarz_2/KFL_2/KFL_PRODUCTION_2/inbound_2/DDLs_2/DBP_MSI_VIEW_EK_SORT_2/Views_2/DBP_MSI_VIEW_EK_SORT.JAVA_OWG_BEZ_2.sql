CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_owg_bez_2
AS
SELECT
spr_id,
owg_id,
Max(owg_bez) owg_bez
FROM dbp_view.v_owg_spr_zu_2
GROUP BY 1,2;