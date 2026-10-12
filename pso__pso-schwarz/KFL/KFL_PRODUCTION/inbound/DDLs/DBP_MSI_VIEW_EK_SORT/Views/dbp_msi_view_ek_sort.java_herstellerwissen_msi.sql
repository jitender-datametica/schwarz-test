CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_herstellerwissen_msi
AS
SELECT
t1.mandant_id,
t1.gp_id,
h452_herstellerwissen AS H452,
Max(dat_pflege) AS dat_pflege
FROM dbp_msi_v_view.v_herstellerwissen t1
GROUP BY 1,2,3;