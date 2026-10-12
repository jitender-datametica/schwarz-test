CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_bestellart_prompt -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 bestellart_id
)
AS
SELECT
v01.bestellart_id
FROM dbp_view.v_l_bestellart v01
GROUP BY v01.bestellart_id

-- Dummy records for noch available ID within movement data records
UNION

SELECT
bestellart_id
FROM
(SELECT
'-2' AS bestellart_id
) v02;
