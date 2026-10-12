CREATE OR REPLACE VIEW dbp_msi_view2.mv_saison
(
  mandant_id
, saison_id
, saison_bez
)
AS
SELECT
v01.mandant_id,
v01.saison_id,
v01.saison_bez
FROM dbp_view.v_saison_spr_zu v01
WHERE mandant_id = 1
AND spr_id = 22;