CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_GP_TEILSORTIMENT_SPR_ZU_1
(
mandant_id
, gp_id
, gp_teilsortiment_id
, einkaufsorganisation_id
, spr_id
, gp_teilsortiment_bez

)
AS
   SELECT
   mandant_id, gp_id, gp_teilsortiment_id, einkaufsorganisation_id, spr_id, gp_teilsortiment_bez

   FROM dbp_view.v_gp_teilsortiment_spr_zu_1;