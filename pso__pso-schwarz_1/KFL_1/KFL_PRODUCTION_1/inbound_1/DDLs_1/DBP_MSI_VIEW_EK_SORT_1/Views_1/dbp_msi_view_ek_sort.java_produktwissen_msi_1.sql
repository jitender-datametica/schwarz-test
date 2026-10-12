CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_produktwissen_msi_1
AS
SELECT
v1.mandant_id,
v1.matching_id,
v1.F49_produktwissen,
Max(v1.dat_pflege) AS dat_pflege
FROM dbp_msi_v_view.v_produktwissen_1 AS v1
GROUP BY 1,2,3;