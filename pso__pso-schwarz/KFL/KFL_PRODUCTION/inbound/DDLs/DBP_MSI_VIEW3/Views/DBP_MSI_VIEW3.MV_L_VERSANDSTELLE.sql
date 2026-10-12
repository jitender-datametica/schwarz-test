CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_VERSANDSTELLE
(
mandant_id
, versandstelle_id
)
AS
   SELECT
   mandant_id, versandstelle_id
   FROM dbp_view.v_l_versandstelle;