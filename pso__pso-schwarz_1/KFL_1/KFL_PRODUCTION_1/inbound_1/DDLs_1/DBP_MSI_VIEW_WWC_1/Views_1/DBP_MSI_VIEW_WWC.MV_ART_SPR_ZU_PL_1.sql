CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_SPR_ZU_PL_1
(
spr_id
, art_id
, mandant_id
, art_bez
, art_id_bez
)
AS
   SELECT
   v01.spr_id, v01.art_id, v01.mandant_id, v01.art_bez, CAST(CAST(v01.art_id AS CHAR(10)) || ' ' || v01.art_bez AS CHAR(61))

   FROM dbp_view.v_art_spr_zu_1 v01
   WHERE spr_id = 90
;