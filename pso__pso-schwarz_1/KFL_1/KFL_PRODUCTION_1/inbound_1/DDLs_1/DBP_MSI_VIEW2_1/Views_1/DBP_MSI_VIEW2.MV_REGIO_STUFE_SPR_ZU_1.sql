CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_STUFE_SPR_ZU_1
(
mandant_id
, regio_stufe_id
, spr_id
, regio_stufe_bez
)
AS
   SELECT
   mandant_id, regio_stufe_id, spr_id, regio_stufe_bez
   FROM dbp_view.v_regio_stufe_spr_zu_1
   WHERE mandant_id = 1
   AND spr_id = 22;