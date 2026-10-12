CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lager_bewgrund_hist_1 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 mandant_id
,grund_id
,lager_bewart_id
,hist_fg
,retourenart_id
)
AS
SELECT
v01.mandant_id,
v01.grund_id,
v01.lager_bewart_id,
v01.hist_fg,
v01.retourenart_id
FROM dbp_view.v_l_lager_bewgrund_1 v01
WHERE v01.hist_fg = 1;
