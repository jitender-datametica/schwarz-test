DELETE FROM DBP_DATA.halbjahr_gj_1;

INSERT INTO DBP_DATA.halbjahr_gj_1
(
 gjhj
,akt_gjhj
,akt_gjhj_komplett
,gj
)

SELECT
 gjhj
,akt_gjhj
,akt_gjhj_komplett
,gj
FROM DBP_DATA.tag_1
GROUP BY 1,2,3,4
;

COMMIT
