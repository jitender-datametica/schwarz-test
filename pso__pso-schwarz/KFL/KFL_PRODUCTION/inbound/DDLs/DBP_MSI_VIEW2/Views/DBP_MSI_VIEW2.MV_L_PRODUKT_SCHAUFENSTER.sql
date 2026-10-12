CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PRODUKT_SCHAUFENSTER
(
mandant_id
, psf_id
)
AS
   SELECT
   mandant_id, psf_id

   FROM dbp_view.v_l_produkt_schaufenster
   WHERE mandant_id = 1;