CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_WG_VERKETTUNG
(
mandant_id ,
wg_verkett_id
)
AS
   SELECT
   mandant_id,
   wg_verkett_id
   FROM dbp_view.v_l_wg_verkettung;