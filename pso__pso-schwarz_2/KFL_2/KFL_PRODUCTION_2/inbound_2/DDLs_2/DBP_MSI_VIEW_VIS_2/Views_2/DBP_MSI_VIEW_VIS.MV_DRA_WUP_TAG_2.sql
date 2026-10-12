CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_DRA_WUP_TAG_2(
	MANDANT_ID,
	WUP_ID,
	DAT,
	BETRAG_DRA,
	ANZ_BON
) AS

   -- KW04/2013: Initial
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
   
SELECT
 v01.mandant_id
 , wup.aktuell_wup_id 													AS wup_id
 , v01.dat
 , v01.betrag_dra
 , v01.anz_bon
FROM dbp_view.v_dra_wup_tag_2 v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;