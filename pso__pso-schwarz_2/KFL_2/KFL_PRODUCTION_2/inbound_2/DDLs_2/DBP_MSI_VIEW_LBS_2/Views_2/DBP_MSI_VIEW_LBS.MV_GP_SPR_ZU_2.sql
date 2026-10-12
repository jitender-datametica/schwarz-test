CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GP_SPR_ZU_2(
	GP_ID,
	MANDANT_ID,
	GP_NAME,
	GP_NAME_DE,
	GP_NAME_CZ,
	GP_NAME_PL,
	GP_NAME_MD,
	GP_NAME_SK,
	GP_NAME_HR,
	GP_NAME_RO,
	GP_NAME_BG
) AS SELECT
    v01.gp_id,
    v01.mandant_id,
    v01.gp_name_lat AS gp_name,
    v01.gp_name_lat AS gp_name_de   -- DE
    ,v01.gp_name_lat AS gp_name_cz  -- CZ
    ,v01.gp_name_lat AS gp_name_pl  -- PL
    ,v01.gp_name_lat AS gp_name_md  -- MD
    ,v01.gp_name_lat AS gp_name_sk  -- SK
    ,v01.gp_name_lat AS gp_name_hr  -- HR
    ,v01.gp_name_lat AS gp_name_ro  -- RO
    ,v01.gp_name AS gp_name_bg      -- BG

FROM dbp_view.v_gp_2 v01
JOIN dbp_view.v_region_2 v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.land_id = v02.land_id
    AND v01.region_id = v02.region_id
WHERE v01.gp_id NOT BETWEEN 10000 AND 999999;