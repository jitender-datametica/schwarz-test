CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_GP_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 02.02.2022
--INC4546960 Anpassung an AIS_INT bzgl kyrillischer Sprache / ssch1303 12.04.2022
(
 gp_id
,mandant_id
,gp_name
,gp_name_de
,gp_name_cz
,gp_name_pl
,gp_name_md
,gp_name_sk
,gp_name_hr
,gp_name_ro
,gp_name_bg
)
AS
SELECT
 v01.gp_id
,v01.mandant_id
,v01.gp_name_lat AS gp_name
,v01.gp_name_lat AS gp_name_de  -- DE
,v01.gp_name_lat AS gp_name_cz  -- CZ
,v01.gp_name_lat AS gp_name_pl  -- PL
,v01.gp_name_lat AS gp_name_md  -- MD
,v01.gp_name_lat AS gp_name_s   -- SK
,v01.gp_name_lat AS gp_name_h   -- HR
,v01.gp_name_lat AS gp_name_r   -- RO
,v01.gp_name AS gp_name_bg      -- BG

FROM dbp_view.v_gp_2 v01
JOIN dbp_view.v_region_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.land_id = v02.land_id
AND v01.region_id = v02.region_id

WHERE v01.mandant_id <> 1
AND v01.einkaufsorganisation_id <> -1;