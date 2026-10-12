DELETE FROM dbp_msi_data.prognose_artbew_wg_sum_2
WHERE dat >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY);



INSERT INTO dbp_msi_data.prognose_artbew_wg_sum_2 (
    mandant_id, wup_id, nb_id, wg_id, dat, dat_prognoselauf,
    kjmo,
    kjwo,
    udf_prognose_horizont,
    fur_prognose_horizont,
    udf_vk_menge,
    udf_vk_menge_sa,
    udf_vk_menge_af,
    udf_menge_prognose,
    udf_menge_prognose_sa,
    udf_menge_prognose_af,
    udf_abs_diff,
    udf_abs_diff_sa,
    udf_abs_diff_af,
    udf_gesteuert_menge_prognose,
    udf_gesteuert_menge_prognose_sa,
    udf_gesteuert_menge_prognose_af,
    udf_gesteuert_abs_diff,
    udf_gesteuert_abs_diff_sa,
    udf_gesteuert_abs_diff_af,
    fur_menge_prognose,
    fur_menge_prognose_sa,
    fur_menge_prognose_af,
    fur_menge_prognose_max,
    fur_vk_menge,
    fur_vk_menge_sa,
    fur_vk_menge_af,
    fur_abs_diff,
    fur_abs_diff_sa, fur_abs_diff_af, td_update, td_insert
)
(
    SELECT
        COALESCE(UDF_PASS_AGG.mandant_id, FUR_PASS_AGG.mandant_id)
            AS udf_pass_agg_mandant_id_fur_pass_agg_mandant_id,
        COALESCE(UDF_PASS_AGG.wup_id, FUR_PASS_AGG.wup_id)
            AS udf_pass_agg_wup_id_fur_pass_agg_wup_id,
        COALESCE(UDF_PASS_AGG.nb_id, FUR_PASS_AGG.nb_id)
            AS udf_pass_agg_nb_id_fur_pass_agg_nb_id,
        COALESCE(UDF_PASS_AGG.wg_id, FUR_PASS_AGG.wg_id)
            AS udf_pass_agg_wg_id_fur_pass_agg_wg_id,
        COALESCE(UDF_PASS_AGG.dat, FUR_PASS_AGG.dat)
            AS udf_pass_agg_dat_fur_pass_agg_dat,
        COALESCE(
            UDF_PASS_AGG.dat_prognoselauf, FUR_PASS_AGG.dat_prognoselauf) AS
        udf_pass_agg_dat_prognoselauf_fur_pass_agg_dat_prognoselauf,
        COALESCE(UDF_PASS_AGG.kjmo, -1) AS udf_pass_agg_kjmo,
        COALESCE(UDF_PASS_AGG.kjwo, -1) AS udf_pass_agg_kjwo,
        UDF_PASS_AGG.udf_prognose_horizont,
        FUR_PASS_AGG.fur_prognose_horizont,
        UDF_PASS_AGG.udf_vk_menge,
        UDF_PASS_AGG.udf_vk_menge_sa,
        UDF_PASS_AGG.udf_vk_menge_af,
        UDF_PASS_AGG.udf_menge_prognose,
        UDF_PASS_AGG.udf_menge_prognose_sa,
        UDF_PASS_AGG.udf_menge_prognose_af,
        UDF_PASS_AGG.udf_abs_diff,
        UDF_PASS_AGG.udf_abs_diff_sa,
        UDF_PASS_AGG.udf_abs_diff_af,
        UDF_PASS_AGG.udf_gesteuert_menge_prognose,
        UDF_PASS_AGG.udf_gesteuert_menge_prognose_sa,
        UDF_PASS_AGG.udf_gesteuert_menge_prognose_af,
        UDF_PASS_AGG.udf_gesteuert_abs_diff,
        UDF_PASS_AGG.udf_gesteuert_abs_diff_sa,
        UDF_PASS_AGG.udf_gesteuert_abs_diff_af,
        FUR_PASS_AGG.fur_menge_prognose,
        FUR_PASS_AGG.fur_menge_prognose_sa,
        FUR_PASS_AGG.fur_menge_prognose_af 
            AS fur_menge_prognose_af,
        FUR_PASS_AGG.fur_menge_prognose_max,
        FUR_PASS_AGG.fur_vk_menge,
        FUR_PASS_AGG.fur_vk_menge_sa  AS fur_vk_menge_sa,
        FUR_PASS_AGG.fur_vk_menge_af  AS fur_vk_menge_af,
        FUR_PASS_AGG.fur_abs_diff,
        FUR_PASS_AGG.fur_abs_diff_sa  AS fur_abs_diff_sa,
        FUR_PASS_AGG.fur_abs_diff_af  AS fur_abs_diff_af,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_etl.udf_pass_agg_2 AS UDF_PASS_AGG_2
    FULL JOIN dbp_etl.fur_pass_agg_2 AS FUR_PASS_AGG_2
        ON
            UDF_PASS_AGG.mandant_id = FUR_PASS_AGG.mandant_id
            AND UDF_PASS_AGG.wup_id = FUR_PASS_AGG.wup_id AND UDF_PASS_AGG.nb_id = FUR_PASS_AGG.nb_id AND UDF_PASS_AGG.dat
            = FUR_PASS_AGG.dat AND UDF_PASS_AGG.wg_id = FUR_PASS_AGG.wg_id
    WHERE
        COALESCE(UDF_PASS_AGG.dat, FUR_PASS_AGG.dat)
        >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
);
