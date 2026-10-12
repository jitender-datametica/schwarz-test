CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGER_BEWART_TYP_2
-- AP0014173, srom0404, system_id entfällt, hist_fg hinzu
(
lager_bewart_typ_id
,mandant_id
,hist_fg
)
AS
   SELECT
   lager_bewart_typ_id, mandant_id, hist_fg
   FROM dbp_view.v_l_lager_bewart_typ_2
   WHERE hist_fg = 0;