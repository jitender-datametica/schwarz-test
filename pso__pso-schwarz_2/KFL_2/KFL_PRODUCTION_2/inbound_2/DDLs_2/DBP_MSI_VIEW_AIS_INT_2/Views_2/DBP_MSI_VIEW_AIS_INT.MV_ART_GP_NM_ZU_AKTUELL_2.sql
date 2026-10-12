CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ART_GP_NM_ZU_AKTUELL_2
(
art_id
,akt_gp_id
,gp_name
,gp_name_de
,gp_name_cz  
,gp_name_pl  
,gp_name_md  
,gp_name_sk  
,gp_name_hr  
,gp_name_ro  
,gp_name_bg
,mandant_id
,anz_lief
)
AS
-- NSR2439387 -- initial creation 
-- NSR4749653 -- Anpassung Row_Number () Funktion
-- SPEC0305762, prescherad, 07.04.2025, Umbau auf Mehrsprachigkeit 

SELECT
v01.art_id
,v01.gp_id
,v02.gp_name_lat AS gp_name
,v02.gp_name_lat AS gp_name_de  -- DE
,v02.gp_name_lat AS gp_name_cz  -- CZ
,v02.gp_name_lat AS gp_name_pl  -- PL
,v02.gp_name_lat AS gp_name_md  -- MD
,v02.gp_name_lat AS gp_name_sk  -- SK
,v02.gp_name_lat AS gp_name_hr  -- HR
,v02.gp_name_lat AS gp_name_ro  -- RO
,v02.gp_name     AS gp_name_bg  -- BG
,v01.mandant_id
,COUNT(v01.wup_id) AS anz_lief
FROM dbp_view.v_art_gp_nm_zu_per_2 v01 
JOIN dbp_view.v_gp_2 v02
ON v01.gp_id=v02.gp_id
AND v01.mandant_id = v02.mandant_id
JOIN dbp_view.v_wup_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.wup_id = v03.wup_id
AND v01.nb_id = v03.nb_id
WHERE
v01.dat_bis = '9999-12-31'
AND v03.nb_id = 0
AND CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
GROUP BY 
v01.art_id
,v01.gp_id
,gp_name
,gp_name_de  -- DE
,gp_name_cz  -- CZ
,gp_name_pl  -- PL
,gp_name_md  -- MD
,gp_name_sk  -- SK
,gp_name_hr  -- HR
,gp_name_ro  -- RO
,gp_name_bg  -- BG
,v01.mandant_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.art_id ORDER BY anz_lief DESC NULLS LAST) = 1;


