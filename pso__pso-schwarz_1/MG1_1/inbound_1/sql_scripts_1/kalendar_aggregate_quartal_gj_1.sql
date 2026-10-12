DELETE FROM DBP_DATA.quartal_gj_1;

INSERT INTO DBP_DATA.quartal_gj_1
(
  gjqu
, akt_gjqu
, akt_gjqu_komplett
, gj
, akt_gj
, akt_gj_komplett
, gjhj
)
SELECT
  gjqu
, akt_gjqu
, akt_gjqu_komplett
, gj
, akt_gj
, akt_gj_komplett
, gjhj
FROM DBP_DATA.tag_1
GROUP BY 1,2,3,4,5,6,7
;
COMMIT;
