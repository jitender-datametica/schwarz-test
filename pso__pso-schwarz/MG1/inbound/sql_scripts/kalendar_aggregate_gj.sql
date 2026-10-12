DELETE FROM DBP_DATA.jahr_gj;

INSERT INTO DBP_DATA.jahr_gj
(
gj
, akt_gj
, akt_gj_komplett
)

SELECT
gj
, akt_gj
, akt_gj_komplett
FROM DBP_DATA.tag
GROUP BY 1,2,3
;

COMMIT;
