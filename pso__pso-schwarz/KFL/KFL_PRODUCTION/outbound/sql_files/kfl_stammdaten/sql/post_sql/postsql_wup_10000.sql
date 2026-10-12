--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.wup SET
    getraenkemarkt_fg = dt1.`_getraenkemarkt_fg` FROM (SELECT
    mandant_id AS `_mandant_id`,
    wup_id AS `_wup_id`,
    getraenkemarkt_fg AS `_getraenkemarkt_fg`
FROM ${TEMP_TABLE}) AS dt1
WHERE wup.mandant_id = dt1.`_mandant_id` AND wup.wup_id = dt1.`_wup_id` AND wup.nb_id = 0 AND wup.dat_von IS NOT NULL;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.wup SET
    wup_name_e = dt1.`_wup_name_e`,
    wup_str = dt1.`_wup_str`,
    wup_plz = dt1.`_wup_plz`,
    wup_stadt = dt1.`_wup_stadt`,
    land_id = dt1.`_land_id`,
    vw_id = dt1.`_vw_id`,
    wup_typ_id = dt1.`_wup_typ_id`,
    bewertungskreis_id = dt1.`_bewertungskreis_id`,
    verkaufsorganisation_id = dt1.`_verkaufsorganisation_id`,
    haupt_wup_id = dt1.`_haupt_wup_id`,
    nb_id = dt1.`_nb_id`,
    mandant_id_ursprung = dt1.`_mandant_id_ursprung` FROM (SELECT
    nb_id AS `_nb_id`,
    wup_plz AS `_wup_plz`,
    land_id AS `_land_id`,
    wup_stadt AS `_wup_stadt`,
    wup_str AS `_wup_str`,
    haupt_wup_id AS `_haupt_wup_id`,
    bewertungskreis_id AS `_bewertungskreis_id`,
    mandant_id AS `_mandant_id`,
    wup_typ_id AS `_wup_typ_id`,
    verkaufsorganisation_id AS `_verkaufsorganisation_id`,
    wup_id AS `_wup_id`,
    wup_name_e AS `_wup_name_e`,
    vw_id AS `_vw_id`,
    mandant_id_ursprung AS `_mandant_id_ursprung`
FROM ${TEMP_TABLE}) AS dt1
WHERE wup.mandant_id = dt1.`_mandant_id` AND wup.wup_id = dt1.`_wup_id`;
