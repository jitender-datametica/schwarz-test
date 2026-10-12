CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PREDICT_COMPETITORS_KAUFLAND_ZU_1
(
	GOOGLE_PLACE_ID,
	KJMO,
	MANDANT_ID,
	WUP_ID,
	AIRLINE_DISTANCE
) AS

	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	
SELECT
 pck.google_place_id
 , pck.kjmo
 , pck.mandant_id
 , wup.aktuell_wup_id 																AS wup_id
 , pck.airline_distance 
FROM dbp_view.v_predict_competitors_kaufland_zu_1 pck

INNER JOIN dbp_view.v_wup_1 wup_1
ON pck.mandant_id = wup.mandant_id AND pck.wup_id = wup.wup_id

WHERE airline_distance > 0.00
;