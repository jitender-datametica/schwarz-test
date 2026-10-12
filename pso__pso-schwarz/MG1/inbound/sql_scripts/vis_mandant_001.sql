/* AW check 2021-05-10*/
DROP TABLE IF EXISTS DBP_ETL.vis_mandant;

CREATE TABLE DBP_ETL.vis_mandant  (
	mandant_id BYTEINT
)
;

INSERT INTO DBP_ETL.vis_mandant
(mandant_id)
SELECT
mandant_id 
FROM DBP_DATA.mandant
WHERE mandant_id IN (${MANDANT});
