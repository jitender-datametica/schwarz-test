CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_BELASTUNGSART_VD_BIG
(
	BELASTUNGSART_VD_ID,
	BELASTUNGSART_VD_BEZ

) AS
/* 
   BIG DE
   2024-01-16 muellerpatri : Initiale Erstellung der View, AP0199691 (Logik der Views aus RPW)
*/ 
SELECT 
	belastungsart_vd_id,
	belastungsart_vd_bez
FROM dbp_view.v_rpw_l_belastungsart_vd;