DELETE FROM DBP_DATA.quartal_kj;

INSERT INTO DBP_DATA.quartal_kj
(
kjqu
, kj
, akt_kjqu
, akt_kjqu_komplett
, akt_kj
, akt_kj_komplett
)

SELECT
kjqu
, kj
, akt_kjqu
, akt_kjqu_komplett
, akt_kj
, akt_kj_komplett
FROM DBP_DATA.tag
GROUP BY 1,2,3,4,5,6
;
COMMIT;
