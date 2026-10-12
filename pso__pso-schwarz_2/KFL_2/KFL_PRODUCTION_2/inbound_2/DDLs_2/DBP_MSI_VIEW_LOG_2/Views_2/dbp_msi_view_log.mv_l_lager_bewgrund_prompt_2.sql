CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lager_bewgrund_prompt_2 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 grund_id
,lager_bewart_id
,hist_fg
,retourenart_id
)
AS
SELECT
v01.grund_id,
v01.lager_bewart_id,
Max(v01.hist_fg) AS hist_fg,
Max(v01.retourenart_id) AS retourenart_id
FROM dbp_view.v_l_lager_bewgrund_2 v01
WHERE v01.hist_fg = 0
GROUP BY v01.grund_id
        ,v01.lager_bewart_id;
