DELETE FROM DBP_DATA.monat_2;

INSERT INTO DBP_DATA.monat_2
(
kjmo
, kjmo_vj
, kjmo_vvj
, gjmo
, gjmo_vj
, kjqu
, gjqu
, kj
, gj
, akt_mo
, akt_mo_komplett
, akt_gjqu
, akt_gjqu_komplett
, akt_kjqu
, akt_kjqu_komplett
, akt_gj
, akt_gj_komplett
, akt_kj
, akt_kj_komplett
, mo_gj
, mo_kj
, min_dat
, max_dat
, gjhj
)

SELECT
kjmo
, kjmo_vj
, kjmo_vvj
, gjmo
, gjmo_vj
, kjqu
, gjqu
, kj
, gj
, akt_mo
, akt_mo_komplett
, akt_gjqu
, akt_gjqu_komplett
, akt_kjqu
, akt_kjqu_komplett
, akt_gj
, akt_gj_komplett
, akt_kj
, akt_kj_komplett
, mo_gj
, mo_kj
, MIN(dat) AS min_dat
, MAX(dat) AS max_dat
, gjhj
FROM DBP_DATA.tag_2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,24
;
COMMIT;
