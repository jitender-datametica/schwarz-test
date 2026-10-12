CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_VW_WUP_ZU_2
-- AP0032822, SPEC0041631 - 31.10.2108, mkub1811 neue View
(
mandant_id
,wup_id
,vw_id
,art_id
,nb_id
,rabatt_zul_fg
)
AS
   SELECT
   mandant_id, wup_id, vw_id, art_id, nb_id, rabatt_zul_fg
   FROM dbp_view.v_art_vw_wup_zu_2
   WHERE
   --mandant_id <> 1
   --AND
   wup_id = -1
   AND vw_id = 10;