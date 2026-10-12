CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_PREIS_AENDERUNG_SPR_ZU_PL_2
(
mandant_id
,PV_GRUND
,preis_aend_grund_bez
,spr_id
)
AS
   SELECT
   mandant_id, preis_aend_grund_id AS PV_GRUND, preis_aend_grund_bez, spr_id
   FROM dbp_view.v_preis_aenderung_spr_zu_2
   WHERE spr_id = 90
;