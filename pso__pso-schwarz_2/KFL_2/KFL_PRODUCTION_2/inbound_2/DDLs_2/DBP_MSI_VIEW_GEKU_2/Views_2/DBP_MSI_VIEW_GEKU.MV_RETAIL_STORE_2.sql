CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_RETAIL_STORE_2
(
	EXT_STORE_ID,
	MANDANT_ID,
	EXT_SYSTEM_NAME,
	RETAIL_STORE_NAME,
	RETAIL_STORE_ADDRESS,
	BREITENGRAD,
	LAENGENGRAD,
	EXT_RETAIL_COMPANY_ID,
	COMPETITOR_WUP_ID,
	WUP_ID_INTERN_EXTERN,
	WUP_ID,
	MANDANT_ID_WUP,
	NB_ID,
	DRIVETIME_DISTANCE_KM
) AS

--24.01.2023 twie: SPEC0170810 die zugehörige wup_id zum Store ermitteln. In retail_store_2 ist dies nur bei Kaufland Märkten zugordnet
--                 in retail_store_distance_2 haben auch Wettbewerbermärkte eine_2 wup_id zugordnet, und zwar die des nächstgelegenen Kauflands bzw. einer Zentralfiliale
--22.02.2023 twie: SPEC0170810 drivetime_distance_km ergänzt (kürzeste falls mehrere pro Store).
--                 mandant_id für Store und Filiale (wup_2) aufgesplittet (nicht bei jedem Store gibt es zugeordneten wup_2)
--                 für wup_id_intern_extern statt der competitor_wup_id die ext_store_id verwendet
--27.02.2023 twie: SPEC0170810 Feld competitor_wup_id hinzugefügt, wup_id_intern_extern ist kein VARCHAR mehr
--08.03.2023 twie: SPEC0170810 die retail_store_distance_2 als Inner Join, soll als Filter dienen, nur Stores anzeigen die auch hierin sind (vgl. VIS)
--14.08.2024 twie: SPEC0261627 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--				   somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 
--21.11.2024 twie: SPEC0267631 PK wird geändert von retail_company_sid auf ext_retail_company_id, store analog
--27.11.2024 twie: SPEC0267631 Felder mit sid werden komplett entfernt

SELECT  
	 v01.ext_store_id
	,v01.mandant_id
	,v01.ext_system_name
	,v01.retail_store_name
	,v01.retail_store_address
	,v01.breitengrad
	,v01.laengengrad
	,v01.ext_retail_company_id
	,v01.competitor_wup_id
	,CASE WHEN v01.wup_id = -1 THEN v01.ext_store_id ELSE v03.aktuell_wup_id END AS wup_id_intern_extern
	,COALESCE(v03.aktuell_wup_id, -1) AS wup_id
	,COALESCE(v02.mandant_id, -1) AS mandant_id_wup
	,COALESCE(v02.nb_id, -1) AS nb_id
	,v02.drivetime_distance_km

FROM dbp_view.v_retail_store_2 v01

INNER JOIN 
(SELECT 
  ext_store_id
 ,MAX(wup_id) AS wup_id
 ,MAX(mandant_id) AS mandant_id
 ,MAX(nb_id) AS nb_id
 ,MIN(drivetime_distance_km) AS drivetime_distance_km
 FROM dbp_view.v_retail_store_distance_2
 GROUP BY ext_store_id --gruppieren nach ext_store_id, da in Tabelle die retail_store_distance_sid der PK ist
 ) v02
ON v01.ext_store_id = v02.ext_store_id

INNER JOIN dbp_view.v_wup_2 v03
ON v02.wup_id = v03.wup_id
AND v02.mandant_id = v03.mandant_id
;

