CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_SORTIMENTSLISTENART_SPR_ZU_2
(
mandant_id
, spr_id
, sortimentslistenart_id
, sortimentslistenart_bez
)
AS
   SELECT
   mandant_id, spr_id, sortimentslistenart_id, sortimentslistenart_bez

   FROM dbp_view.v_sortimentslistenart_spr_zu_2
   WHERE mandant_id = 1
   AND spr_id = 22;