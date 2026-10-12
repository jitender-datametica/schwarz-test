DELETE FROM DBP_DATA.woche_gj_kl;

INSERT INTO DBP_DATA.woche_gj_kl
(
gjwo_kl
, gjwo_kl_dat_von
, gjwo_kl_dat_bis
, akt_gjwo_kl
, akt_gjwo_kl_komplett
, akt_gj
, akt_gj_komplett
)

SELECT
gjwo_kl
, gjwo_kl_dat_von
, gjwo_kl_dat_bis
, akt_gjwo_kl
, akt_gjwo_kl_komplett
, akt_gj
, akt_gj_komplett
FROM DBP_DATA.tag
GROUP BY 1,2,3,4,5,6,7
;
COMMIT;
