CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BEZUGSWEG_SPR_ZU
(
mandant_id
,bezugsweg_id
, spr_id
, bezugsweg_bez
)
AS
   SELECT
   v01.mandant_id, v01.bezugsweg_id, v01.spr_id, v01.bezugsweg_bez

   FROM dbp_view.v_bezugsweg_spr_zu v01

   WHERE v01.mandant_id =1
   and v01.spr_id = 22;