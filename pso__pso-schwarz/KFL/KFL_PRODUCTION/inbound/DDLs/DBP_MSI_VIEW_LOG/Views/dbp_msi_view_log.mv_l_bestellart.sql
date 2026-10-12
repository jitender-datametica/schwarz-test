CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_bestellart -- 13.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mandant_id
,bestellart_id
)
AS
SELECT
v01.mandant_id,
v01.bestellart_id
FROM dbp_view.v_l_bestellart v01

-- Dummy records for noch available ID within movement data records
UNION

SELECT
v02.mandant_id,
'-2' AS bestellart_id
FROM dbp_view.v_mandant v02;
