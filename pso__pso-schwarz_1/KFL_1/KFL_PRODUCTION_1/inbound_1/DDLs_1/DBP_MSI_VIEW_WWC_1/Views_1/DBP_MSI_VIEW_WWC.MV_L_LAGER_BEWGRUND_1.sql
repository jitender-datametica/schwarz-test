CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_LAGER_BEWGRUND_1
-- AP0014173, srom0404, hist_fg und retourenart_id aufgenommen
(
mandant_id
,mandant_kbez
,GRUND
,BWART
,ZZPRTART
)
AS
   SELECT
  v01.mandant_id, v02.mandant_kbez, v01.grund_id AS GRUND, v01.lager_bewart_id AS BWART, v01.retourenart_id AS ZZPRTART
   FROM dbp_view.v_l_lager_bewgrund_1 v01
   INNER JOIN dbp_view.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id
   WHERE v01.hist_fg = 0
   ;