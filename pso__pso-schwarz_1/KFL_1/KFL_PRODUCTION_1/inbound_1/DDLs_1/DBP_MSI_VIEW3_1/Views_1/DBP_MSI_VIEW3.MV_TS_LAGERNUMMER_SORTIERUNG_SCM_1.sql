CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TS_LAGERNUMMER_SORTIERUNG_SCM_1(
	MANDANT_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	LAGERSORTIMENT_ID,
	ARTIKELSORTIMENT_ID,
	LAGERNUMMER_SORTIERUNG_SCM_ID,
	LAGERNUMMER_SORTIERUNG_SCM_BEZ
) AS
-- 2022-06-01, AP0094047 , dknop, initial
--2024-10-17, AP0210954_SPEC0239355, nwag, move TS to msi_data
    SELECT 
         v01.mandant_id
        ,v01.lagernummer_id
        ,v01.wup_id
        ,v01.nb_id
        ,COALESCE(v02.lagersortiment_id,'-1')
        ,COALESCE(v02.artikelsortiment_id,'-1')
        ,COALESCE(v02.lagernummer_sortierung_scm_id,'-1')
        ,COALESCE(v02.lagernummer_sortierung_scm_bez,'N/A')

FROM dbp_view.v_l_lagernummer_1 v01

LEFT JOIN DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM_1 v02
ON  v01.lagernummer_id=v02.lagernummer_id
AND v01.mandant_id=v02.mandant_id
AND v01.nb_id=v02.nb_id
AND v01.wup_id=v02.wup_id
;