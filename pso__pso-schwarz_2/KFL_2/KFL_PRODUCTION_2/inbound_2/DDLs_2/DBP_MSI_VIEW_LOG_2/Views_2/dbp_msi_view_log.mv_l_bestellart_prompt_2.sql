CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_bestellart_prompt_2 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 bestellart_id
)
AS
SELECT
v01.bestellart_id
FROM dbp_view.v_l_bestellart_2 v01
GROUP BY v01.bestellart_id

-- Dummy_2 records for noch available ID within movement data records
UNION

SELECT
bestellart_id
FROM
(SELECT
'-2' AS bestellart_id
) v02;
