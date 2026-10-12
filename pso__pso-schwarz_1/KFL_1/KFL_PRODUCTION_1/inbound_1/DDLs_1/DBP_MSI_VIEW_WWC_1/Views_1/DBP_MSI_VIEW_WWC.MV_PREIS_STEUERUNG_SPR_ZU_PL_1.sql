CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_PREIS_STEUERUNG_SPR_ZU_PL_1
(
mandant_id
,preis_steuer_kz
,spr_id
,preis_steuerung_bez
)
AS
   SELECT
   mandant_id, preis_steuer_kz, spr_id, preis_steuerung_bez
   FROM dbp_view.v_preis_steuerung_spr_zu_1
   WHERE spr_id = 90
;