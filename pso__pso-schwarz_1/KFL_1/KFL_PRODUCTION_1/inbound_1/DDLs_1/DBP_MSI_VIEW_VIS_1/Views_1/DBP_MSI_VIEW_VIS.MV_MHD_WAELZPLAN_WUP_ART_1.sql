CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MHD_WAELZPLAN_WUP_ART_1(
 MANDANT_ID,
 WUP_ID,
 KJWO,
 ART_ID,
 WAELZPLAN_PRUEF_ID,
 WIEDERHOLUNGSRHYTHMUS_WOCHEN,
 KJWO_WIEDERHOLUNG,
 DAT_AENDERUNG
) AS

	-- 09012023 snik - Creation 
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	
SELECT
 wwa.mandant_id
 , wup.aktuell_wup_id 														AS wup_id
 , wwa.kjwo
 , wwa.art_id
 , wwa.waelzplan_pruef_id
 , wwa.wiederholungsrhythmus_wochen
 , wwa.kjwo_wiederholung
 , wwa.dat_aenderung
FROM DBP_VIEW.V_MHD_WAELZPLAN_WUP_ART_1 wwa

INNER JOIN dbp_view.v_wup_1 wup_1
ON wwa.mandant_id = wup.mandant_id AND wwa.wup_id = wup.wup_id
;