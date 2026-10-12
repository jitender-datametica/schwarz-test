DELETE FROM DBP_MSI_DATA.PROGNOSE_ARTBEW_WG_SUM WHERE dat >= current_date - 1;

INSERT INTO DBP_MSI_DATA.PROGNOSE_ARTBEW_WG_SUM (
mandant_id,
wup_id,
nb_id,
dat,
dat_prognoselauf,
kjwo,
kjmo,
udf_prognose_horizont,
wg_id,
fur_prognose_horizont,
udf_vk_menge,
udf_vk_menge_sa,
udf_vk_menge_af,
udf_menge_prognose_sa,
udf_menge_prognose_af,
udf_menge_prognose,
udf_abs_diff,
udf_abs_diff_sa,
udf_abs_diff_af,
udf_gesteuert_menge_prognose_sa,
udf_gesteuert_menge_prognose_af,
udf_gesteuert_menge_prognose,
udf_gesteuert_abs_diff,
udf_gesteuert_abs_diff_sa,
udf_gesteuert_abs_diff_af,
fur_menge_prognose_sa,
fur_menge_prognose_af,
fur_menge_prognose,
fur_menge_prognose_max,
fur_vk_menge,
fur_vk_menge_sa,
fur_vk_menge_af,
fur_abs_diff,
fur_abs_diff_sa,
fur_abs_diff_af,
td_update,
td_insert
)
SELECT
COALESCE(udf_pass_agg.mandant_id, fur_pass_agg.mandant_id),
COALESCE(udf_pass_agg.wup_id, fur_pass_agg.wup_id),
COALESCE(udf_pass_agg.nb_id, fur_pass_agg.nb_id),
COALESCE(udf_pass_agg.dat, fur_pass_agg.dat),
COALESCE(udf_pass_agg.dat_prognoselauf,fur_pass_agg.dat_prognoselauf),
COALESCE(udf_pass_agg.kjwo,-1),
COALESCE(udf_pass_agg.kjmo,-1),
udf_pass_agg.udf_prognose_horizont,
COALESCE(udf_pass_agg.wg_id, fur_pass_agg.wg_id),
fur_pass_agg.fur_prognose_horizont,
udf_pass_agg.udf_vk_menge,
udf_pass_agg.udf_vk_menge_sa,
udf_pass_agg.udf_vk_menge_af,
udf_pass_agg.udf_menge_prognose_sa,
udf_pass_agg.udf_menge_prognose_af,
udf_pass_agg.udf_menge_prognose,
udf_pass_agg.udf_abs_diff,
udf_pass_agg.udf_abs_diff_sa,
udf_pass_agg.udf_abs_diff_af,
udf_pass_agg.udf_gesteuert_menge_prognose_sa,
udf_pass_agg.udf_gesteuert_menge_prognose_af,
udf_pass_agg.udf_gesteuert_menge_prognose,
udf_pass_agg.udf_gesteuert_abs_diff,
udf_pass_agg.udf_gesteuert_abs_diff_sa,
udf_pass_agg.udf_gesteuert_abs_diff_af,
fur_pass_agg.fur_menge_prognose_sa,
fur_pass_agg.fur_menge_prognose_af,
fur_pass_agg.fur_menge_prognose,
fur_pass_agg.fur_menge_prognose_max,
fur_pass_agg.fur_vk_menge,
fur_pass_agg.fur_vk_menge_sa,
fur_pass_agg.fur_vk_menge_af,
fur_pass_agg.fur_abs_diff,
fur_pass_agg.fur_abs_diff_sa,
fur_pass_agg.fur_abs_diff_af,
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP

FROM DBP_ETL.udf_pass_agg udf_pass_agg
FULL OUTER JOIN DBP_ETL.fur_pass_agg fur_pass_agg
ON udf_pass_agg.mandant_id = fur_pass_agg.mandant_id
   AND udf_pass_agg.wup_id = fur_pass_agg.wup_id
   AND udf_pass_agg.nb_id = fur_pass_agg.nb_id
   AND udf_pass_agg.dat = fur_pass_agg.dat
   AND udf_pass_agg.wg_id = fur_pass_agg.wg_id 

WHERE COALESCE(udf_pass_agg.dat, fur_pass_agg.dat) >= current_date - 1
;
