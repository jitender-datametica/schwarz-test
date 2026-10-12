CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lager_bewart -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mandant_id
,lager_bewart_id
)
AS
SELECT
mandant_id,
lager_bewart_id
FROM dbp_view.v_l_lager_bewart v01
-- keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
WHERE v01.system_id NOT IN (2,17,28,32,48,53);
