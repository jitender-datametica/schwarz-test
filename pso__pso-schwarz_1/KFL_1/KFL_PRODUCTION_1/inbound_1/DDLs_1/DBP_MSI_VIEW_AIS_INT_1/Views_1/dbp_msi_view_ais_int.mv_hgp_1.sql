CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_hgp_1
(
  hgp_id
, hgp_name
, mandant_id
, zek_id
)
AS
SELECT 
DISTINCT gp_id,
gp_name,
mandant_id,
zek_id

FROM dbp_view.v_gp_1
WHERE gp_id IN 
(SELECT hgp_id FROM dbp_view.v_gp_1);