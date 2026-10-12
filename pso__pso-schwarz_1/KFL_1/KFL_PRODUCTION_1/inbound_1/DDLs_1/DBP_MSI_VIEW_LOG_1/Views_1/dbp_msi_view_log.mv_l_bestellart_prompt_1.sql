CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_bestellart_prompt_1 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 bestellart_id
)
AS
SELECT
v01.bestellart_id
FROM dbp_view.v_l_bestellart_1 v01
GROUP BY v01.bestellart_id

-- Dummy_1 records for noch available ID within movement data records
UNION

SELECT
bestellart_id
FROM
(SELECT
'-2' AS bestellart_id
) v02;
