DELETE FROM DBP_DATA.jahr_kj_1;

INSERT INTO DBP_DATA.jahr_kj_1
(
kj
, akt_kj
, akt_kj_komplett
)

SELECT
kj
, akt_kj
, akt_kj_komplett
FROM DBP_DATA.tag_1
GROUP BY 1,2,3
;
COMMIT;
