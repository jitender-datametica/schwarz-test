/*
###########################################################################
#  clone data from KFL_PRODUCTION
###########################################################################
*/


TRUNCATE TABLE dbp_data.art_gp_zu_per;


INSERT INTO dbp_data.art_gp_zu_per
(SELECT
    dat_von,
    mandant_id,
    art_id,
    gp_id,
    einkaufsorganisation_id,
    gp_art_id,
    dat_bis,
    herst_id,
    mhd_zeitraum_dz,
    mutter_ek_id,
    td_update,
    td_insert
FROM dbp_data.art_gp_zu_per);
