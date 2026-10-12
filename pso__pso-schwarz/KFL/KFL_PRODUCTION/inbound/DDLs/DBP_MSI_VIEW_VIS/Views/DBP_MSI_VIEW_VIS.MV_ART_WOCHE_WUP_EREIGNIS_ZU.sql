CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WOCHE_WUP_EREIGNIS_ZU(
mandant_id
,art_id
,kjwo
,wup_id
,nb_id
,ereignis_id
,ereignistyp_id
) AS

-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 ez.mandant_id
 , ez.art_id
 , ez.kjwo
 , wup.aktuell_wup_id													 AS wup_id
 , ez.nb_id
 , ez.ereignis_id
 , ez.ereignistyp_id
FROM dbp_view.v_art_woche_wup_ereignis_zu ez

INNER JOIN dbp_view.v_wup wup
ON ez.mandant_id = wup.mandant_id AND ez.wup_id = wup.wup_id
;