DELETE FROM DBP_DATA.woche_kj_kl;

INSERT INTO DBP_DATA.woche_kj_kl
(
kjwo_kl
, kjwo_kl_dat_von
, kjwo_kl_dat_bis
, akt_kjwo_kl
, akt_kjwo_kl_komplett
, akt_kj
, akt_kj_komplett
, kjwo
, akt_wo
)
SELECT
kjwo_kl
, kjwo_kl_dat_von
, kjwo_kl_dat_bis
, akt_kjwo_kl
, akt_kjwo_kl_komplett
, akt_kj
, akt_kj_komplett
, kjwo
, akt_wo
FROM DBP_DATA.tag
GROUP BY 1,2,3,4,5,6,7,8,9
;

COMMIT;
