DELETE FROM DBP_DATA.quartal_kj_2;

INSERT INTO DBP_DATA.quartal_kj_2
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
FROM DBP_DATA.tag_2
GROUP BY 1,2,3,4,5,6
;
COMMIT;
