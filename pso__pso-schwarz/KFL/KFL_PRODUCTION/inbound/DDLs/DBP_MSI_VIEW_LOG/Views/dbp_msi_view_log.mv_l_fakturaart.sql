CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_fakturaart -- 12.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mandant_id
,fakturaart_id
)
AS
SELECT
v01.mandant_id,
v01.fakturaart_id
FROM dbp_view.v_l_fakturaart v01;
