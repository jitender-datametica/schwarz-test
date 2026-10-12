CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PRODUKT_SCHAUFENSTER_1
(
mandant_id
, psf_id
)
AS
   SELECT
   mandant_id, psf_id

   FROM dbp_view.v_l_produkt_schaufenster_1
   WHERE mandant_id = 1;