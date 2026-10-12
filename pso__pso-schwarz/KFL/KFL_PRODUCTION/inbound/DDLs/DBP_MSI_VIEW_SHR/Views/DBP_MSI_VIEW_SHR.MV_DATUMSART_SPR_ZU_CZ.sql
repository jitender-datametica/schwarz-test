CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_DATUMSART_SPR_ZU_CZ
(
mandant_id
, datumsart_id
, datumsart_bez
)
AS
   SELECT
   v01.mandant_id, v01.datumsart_id, v01.datumsart_bez

   FROM dbp_view.v_datumsart_spr_zu v01
   WHERE v01.spr_id = 124
;