CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_STERNCHEN_LOGIK
-- SPEC0066356 Erweiterung um ksm_id / sschuecke 03.12.2019
-- 08.07.2020 lsvi0303: AP0043104, SPEC0069749 Attribut Sortimentskategorie/K-Sortimentskategorie anpassen
( 
  mandant_id
, art_id 
, sm_id
, ksm_id
, list_durchg_fg
, listung_fct
, anzahl_markt
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

SELECT 
     v01.mandant_id
    ,v01.art_id
    ,CASE 
            WHEN sm_id=-9 THEN CAST(TRIM(ksm_id) AS VARCHAR(2))
            WHEN ksm_id= -9 THEN CAST(TRIM(sm_id) AS VARCHAR(2))
        END
     AS sm_id
    ,v01.ksm_id
    ,v01.list_durchg_fg
    ,CASE
        WHEN v02.sternchen_id = '' THEN NULL
        ELSE v02.sternchen_id 
     END listung_fct 
    ,anzahl_markt_soll 

FROM dbp_view.v_sternchen_logik v01
    
    JOIN dbp_view.v_l_sternchen v02
        ON v01.mandant_id = v02.mandant_id
        AND v01.list_durchg_fg = v02.list_durchg_fg
        AND v01.bezugsweg1_fg = v02.bezugsweg1_fg
        AND v01.bezugsweg4_fg = v02.bezugsweg4_fg
        AND v01.kdis0_fg = v02.kdis0_fg
        AND v01.kdis1_fg = v02.kdis1_fg

WHERE v01.mandant_id <> 1;