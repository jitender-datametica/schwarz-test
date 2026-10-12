/* AW check 2021-05-10*/
DROP TABLE IF EXISTS DBP_ETL.vis_mandant_2;

CREATE TABLE DBP_ETL.vis_mandant_2  (
	mandant_id BYTEINT
)
;

INSERT INTO DBP_ETL.vis_mandant_2
(mandant_id)
SELECT
mandant_id 
FROM DBP_DATA.mandant_2
WHERE mandant_id IN (${MANDANT_2});
