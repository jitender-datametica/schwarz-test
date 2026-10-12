CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lager_bewart_prompt -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 lager_bewart_id
)
AS
SELECT
lager_bewart_id
FROM dbp_view.v_l_lager_bewart v01
-- keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
WHERE v01.system_id NOT IN (2,17,28,32,48,53)
GROUP BY v01.lager_bewart_id;
