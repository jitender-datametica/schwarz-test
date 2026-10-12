DELETE FROM DBP_DATA.halbjahr_gj;

INSERT INTO DBP_DATA.halbjahr_gj
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
FROM DBP_DATA.tag
GROUP BY 1,2,3,4
;

COMMIT
