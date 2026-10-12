DELETE FROM DBP_DATA.jahr_gj_1;

INSERT INTO DBP_DATA.jahr_gj_1
(
gj
, akt_gj
, akt_gj_komplett
)

SELECT
gj
, akt_gj
, akt_gj_komplett
FROM DBP_DATA.tag_1
GROUP BY 1,2,3
;

COMMIT;
