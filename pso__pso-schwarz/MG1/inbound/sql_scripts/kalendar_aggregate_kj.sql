DELETE FROM DBP_DATA.jahr_kj;

INSERT INTO DBP_DATA.jahr_kj
(
kj
, akt_kj
, akt_kj_komplett
)

SELECT
kj
, akt_kj
, akt_kj_komplett
FROM DBP_DATA.tag
GROUP BY 1,2,3
;
COMMIT;
