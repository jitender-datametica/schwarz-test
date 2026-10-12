CREATE OR REPLACE VIEW dbp_msi_view2.mv_artkz_posten_sap_2
AS
SELECT
mandant_id,
posten_kz_sap,
CASE
WHEN posten_kz_sap = '' THEN 'nicht gepflegt'
ELSE posten_bez_sap END posten_bez_sap
FROM dbp_view.v_posten_kz_sap_spr_zu_2
WHERE mandant_id = 1
AND spr_id = 22

UNION
SELECT
mandant_id,
posten_id as posten_kz_sap,
CASE
WHEN posten_id= '' THEN 'nicht gepflegt'
ELSE posten_bez END posten_bez_sap
FROM dbp_view.v_artkz_posten_2
WHERE mandant_id = 1
AND spr_id = 22;