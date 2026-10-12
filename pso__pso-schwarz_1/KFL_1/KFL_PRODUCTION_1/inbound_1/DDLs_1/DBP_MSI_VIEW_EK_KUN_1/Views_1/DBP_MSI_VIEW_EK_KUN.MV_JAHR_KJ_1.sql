CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_JAHR_KJ_1
AS 
SELECT
 v01.kj
,v01.akt_kj
,v01.akt_kj_komplett    
FROM dbp_view.v_jahr_kj_1 v01
;