CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_PREIS_STEUERUNG
(
mandant_id
,preis_steuer_kz
)
AS
   SELECT
   mandant_id, preis_steuer_kz
   FROM dbp_view.v_l_preis_steuerung
;