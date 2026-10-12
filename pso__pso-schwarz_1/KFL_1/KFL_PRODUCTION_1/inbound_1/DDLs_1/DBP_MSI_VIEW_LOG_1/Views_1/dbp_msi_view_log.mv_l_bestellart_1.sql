CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_bestellart_1 -- 13.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 mandant_id
,bestellart_id
)
AS
SELECT
v01.mandant_id,
v01.bestellart_id
FROM dbp_view.v_l_bestellart_1 v01

-- Dummy_1 records for noch available ID within movement data records
UNION

SELECT
v02.mandant_id,
'-2' AS bestellart_id
FROM dbp_view.v_mandant_1 v02;
