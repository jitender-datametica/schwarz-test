CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_fakturaart_prompt_1 -- 12.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
fakturaart_id
)
AS
SELECT
v01.fakturaart_id
FROM dbp_view.v_l_fakturaart_1 v01
GROUP BY v01.fakturaart_id;
