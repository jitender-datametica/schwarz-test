CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_PREIS_STEUERUNG_SPR_ZU_CZ
(
mandant_id
,preis_steuer_kz
,spr_id
,preis_steuerung_bez
)
AS
   SELECT
   mandant_id, preis_steuer_kz, spr_id, preis_steuerung_bez
   FROM dbp_view.v_preis_steuerung_spr_zu
   WHERE spr_id = 124
;