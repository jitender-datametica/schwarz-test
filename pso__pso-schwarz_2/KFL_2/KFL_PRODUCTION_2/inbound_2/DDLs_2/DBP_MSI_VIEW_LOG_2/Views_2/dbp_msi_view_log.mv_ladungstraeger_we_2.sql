CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_LADUNGSTRAEGER_WE_2(
	MANDANT_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	DAT_ERSTELLUNG,
	BELEG_ID,
	GP_ID,
	LAGERORT_ID,
	LAGERNUMMER_ID,
	LADUNGSTRAEGER_STATUS_ID,
	ART_GUID,
	ART_ID,
	ARTIKELSORTIMENT_ID,
	ANZ_LADUNGSTRAEGER_DEFEKT,
	ANZ_LADUNGSTRAEGER,
	ANZ_LADUNGSTRAEGER_TAUSCH,
	ANZ_LADUNGSTRAEGER_DEFEKT_TAUSCH,
	WG_ID
)  AS 
--2022.02.16, AP0081637, SPEC0123461, dknop, initial
--2024-09-18, dknop, limiting to >= 01.01.2022 because of transportation_unit_2 duplication
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
SELECT  
 tcl.mandant_id
,tcl.transportation_unit_id
,tcl.KJ_TRANSPORTATION_UNIT
,CAST(tcl.datzeit_erstellung AS DATE) AS dat_erstellung
,tcl.beleg_id
,bl.gp_id
,bld.lagerort_id
,tu.lagernummer_id
,tcl.ladungstraeger_status_id
,tcl.art_guid
,art_guid.art_id
,a_sort.artikelsortiment_id
,tcl.anz_ladungstraeger_defekt
,tcl.anz_ladungstraeger
,tcl.anz_ladungstraeger_tausch
,tcl.anz_ladungstraeger_defekt_tausch
,wg.wg_id

FROM dbp_view.v_transportation_unit_carrier_log_2 tcl

JOIN dbp_view.v_besch_lief_2 bl
ON tcl.beleg_id = bl.lief_beleg_id
AND tcl.mandant_id = bl.mandant_id
AND ABS(bl.kj-tcl.kj_transportation_unit) <= 1

JOIN 
(SELECT 
  mandant_id
 ,lief_beleg_id 
 ,kj
 ,dat_lief_soll
 ,MIN(lagerort_id) AS lagerort_id
       FROM dbp_view.v_besch_lief_det_2
      GROUP BY 
        mandant_id
       ,lief_beleg_id 
       ,kj
       ,dat_lief_soll) bld 
ON bl.mandant_id = bld.mandant_id 
AND bl.lief_beleg_id = bld.lief_beleg_id 
AND bl.kj= bld.kj
AND bl.dat_lief_soll = bld.dat_lief_soll

JOIN dbp_view.v_art_guid_zu_2 art_guid
ON tcl.art_guid=art_guid.art_guid
AND tcl.mandant_id=art_guid.mandant_id

LEFT JOIN  dbp_view.v_fremd_lagerort_artikelsortiment_zu_2 a_sort
ON bld.lagerort_id = a_sort.fremd_lagerort_id
AND bld.mandant_id = a_sort.mandant_id

LEFT JOIN
( SELECT 
 mandant_id
,beleg_id
,transportation_unit_id
,kj_transportation_unit
,lagernummer_id
,ROW_NUMBER() OVER (PARTITION BY mandant_id, beleg_id ORDER BY datzeit_aenderung DESC, beleg_pos_id ASC) AS relevant
FROM dbp_view.v_transportation_unit_hu_lief_zu_2
 --WHERE beleg_pos_id <> 0
) tu
ON bl.mandant_id = tu.mandant_id
AND bl.lief_beleg_id = tu.beleg_id
AND tcl.kj_transportation_unit = tu.kj_transportation_unit
AND tu.relevant = 1

LEFT JOIN dbp_view.v_art_wg_zu_per_2 wg
ON wg.art_id = art_guid.art_id 
AND wg.mandant_id = tcl.mandant_id
AND CAST(tcl.datzeit_erstellung AS DATE) BETWEEN wg.dat_von AND wg.dat_bis
AND wg.arthiertyp_id = 2

WHERE tcl.KJ_TRANSPORTATION_UNIT >= YEAR(CURRENT_DATE)-2
;