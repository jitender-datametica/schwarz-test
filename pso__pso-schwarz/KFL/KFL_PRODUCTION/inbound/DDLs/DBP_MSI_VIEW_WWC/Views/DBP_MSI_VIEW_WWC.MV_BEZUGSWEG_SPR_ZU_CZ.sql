CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BEZUGSWEG_SPR_ZU_CZ
(
mandant_id
,BWSCL
,spr_id
,bezugsweg_bez
)
AS
   SELECT
   mandant_id, bezugsweg_id AS BWSCL, spr_id, bezugsweg_bez
   FROM dbp_view.v_bezugsweg_spr_zu
   WHERE spr_id = 124
   AND mandant_id <> 1
;