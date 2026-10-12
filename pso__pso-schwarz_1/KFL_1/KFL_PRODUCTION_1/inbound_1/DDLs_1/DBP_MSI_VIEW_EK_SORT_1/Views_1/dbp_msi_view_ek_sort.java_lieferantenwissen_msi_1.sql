CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_lieferantenwissen_msi_1
AS
SELECT
v1.mandant_id,
v1.lieferant,
v1.C410_lieferantenwissen,
Max(v1.dat_pflege) AS dat_pflege
FROM dbp_msi_v_view.v_lieferantenwissen_1 AS v1
GROUP BY 1,2,3;