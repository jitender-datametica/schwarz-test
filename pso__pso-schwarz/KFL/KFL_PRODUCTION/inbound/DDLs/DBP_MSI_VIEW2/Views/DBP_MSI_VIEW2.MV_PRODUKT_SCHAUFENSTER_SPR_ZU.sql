CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_PRODUKT_SCHAUFENSTER_SPR_ZU
(
mandant_id
, psf_id
, spr_id
, psf_bez
)
AS
   SELECT
   mandant_id, psf_id, spr_id, psf_bez

   FROM dbp_view.v_produkt_schaufenster_spr_zu
   WHERE mandant_id = 1
   AND spr_id = 22;