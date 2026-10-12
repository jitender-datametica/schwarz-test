CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ANNAHMEVERWEIGERUNG_SPR_ZU_1
(
annahmeverweigerung_id
,annahmeverweigerung_bez
,spr_id
,mandant_id
)
AS
   SELECT
  annahmeverweigerung_id, annahmeverweigerung_bez, spr_id, mandant_id

   FROM dbp_view.v_annahmeverweigerung_spr_zu_1
   WHERE mandant_id = 1;