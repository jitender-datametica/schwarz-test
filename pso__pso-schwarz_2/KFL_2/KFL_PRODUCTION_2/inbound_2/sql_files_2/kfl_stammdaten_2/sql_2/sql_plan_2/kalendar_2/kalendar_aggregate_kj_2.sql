DELETE FROM DBP_DATA.jahr_kj_2;

INSERT INTO DBP_DATA.jahr_kj_2
(
kj
, akt_kj
, akt_kj_komplett
)

SELECT
kj
, akt_kj
, akt_kj_komplett
FROM DBP_DATA.tag_2
GROUP BY 1,2,3
;
COMMIT;
