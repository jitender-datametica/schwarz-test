CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lager_bewart_typ_2 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 mandant_id
,lager_bewart_typ_id
,hist_fg
)
AS
SELECT
mandant_id,
lager_bewart_typ_id,
hist_fg
FROM dbp_view.v_l_lager_bewart_typ_2
WHERE hist_fg = 0;
