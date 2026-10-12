CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_JAHR_GJ_1
AS 
SELECT
 v01.gj
,v01.akt_gj
,v01.akt_gj_komplett 
FROM dbp_view.v_jahr_gj_1 v01

WHERE v01.gj > 2001
;