CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_PREIS_STEUERUNG_SPR_ZU
(
preis_steuer_kz
,mandant_id
,spr_id
,preis_steuerung_bez
)
AS
   SELECT
  preis_steuer_kz, mandant_id, spr_id, preis_steuerung_bez

   FROM dbp_view.v_preis_steuerung_spr_zu
   WHERE mandant_id = 1 and spr_id = 22;