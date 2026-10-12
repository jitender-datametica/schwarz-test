CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_LAGER_BEWGRUND_SPR_ZU_HIST_HR_1
-- AP0014173, srom0404, hist_fg und retourenart_id aufgenommen
(
mandant_id
, GRUND
, BWART
, grund_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.grund_id AS GRUND, v01.lager_bewart_id AS BWART, v01.grund_bez, v01.spr_id

   FROM dbp_view.v_lager_bewgrund_spr_zu_1 v01
   WHERE v01.spr_id = 65
   AND v01.hist_fg = 1
;