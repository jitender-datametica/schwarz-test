CREATE OR REPLACE VIEW dbp_msi_view2.mv_artkz_eigenmarke_2
-- lsvi0303 INC3017226 - 'SPIRITUOSEN;BIER' description changed
(
eigenmarke_id,
eigenmarke_bez
)
AS
SELECT
eigenmarke_id,
CASE
WHEN eigenmarke_id = 'S' THEN 'SPIRITUOSEN;BIER'
ELSE eigenmarke_bez END AS eigenmarke_bez
FROM dbp_view.v_artkz_eigenmarke_2
WHERE mandant_id = 1;