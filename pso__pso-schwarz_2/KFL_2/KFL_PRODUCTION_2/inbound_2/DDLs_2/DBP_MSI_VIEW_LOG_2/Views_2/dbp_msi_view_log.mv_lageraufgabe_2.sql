CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lageraufgabe_2(
	MANDANT_ID,
	LAGERAUFGABE_ID,
	LAGERAUFGABE_POS_ID,
	LAGERPROZESSART_ID,
	STATUS_ID,
	LAGERPROZESS_ID,
	LAGERPROZESSTYP_ID,
	MENGE_KOLLI,
	MENGE_SOLL_BME,
	MENGE_IST_BME,
	GV_MENGE_BEWEGT,
	LAGERBEREICH_ID_NACH,
	LAGERTYP_ID_NACH,
	LAGERTYP_ID_VON,
	ART_ID,
	ART_GUID,
	LAGERNUMMER_ID,
	LE_TYP_ID,
	GEWICHT_NETTO,
	GEW_EINH_ID,
	VOLUMEN,
	VOL_EINH_ID,
	DAT_MHD,
	DATZEIT_WE,
	DAT_WE,
	DATZEIT_ERSTELLUNG,
	DAT_ERSTELLUNG,
	ZEIT_ERSTELLUNG,
	HANDLING_UNIT_ID_NACH,
	HANDLING_UNIT_GUID_NACH,
	HANDLING_UNIT_ID_VON,
	HANDLING_UNIT_GUID_VON,
	BESTANDSART_ID,
	CHARGE_ID,
	GEFAHRSTOFF_FG,
	AKTIVITAETSBEREICH_ID,
	DATZEIT_QUITTIERUNG,
	DAT_QUITTIERUNG,
	ZEIT_QUITTIERUNG,
	LAGERPROZESS_EXTERN_ID,
	QUEUE_ID,
	AUSNAHME_CODE,
	DAT_START,
	ZEIT_START,
	KONSOLIDIERUNGSGRUPPE_ID,
	EWM_EXC_KATEGORIE_ID,
	BUS_KONTEXT,
	AUSFUEHR_SCHRITT_ID,
	ZEUGNIS_NR,
	LIEF_PAL_TYP_ID,
	WERBEWARE_ID,
	EWM_GV_ID,
	WELLE_ID,
	WELLE_POS_ID,
	LAGERAUFTRAG_ID,
	EWM_GV_GRP_ID,
	ARTIKELSORTIMENT_ID,
	LAGERSORTIMENT_ID,
	LAGERPLATZ_ID_NACH,
	LAGERPLATZ_ID_VON,
	DAT_LIEF_SOLL,
	WG_VERKETT_LIEF,
	MANDANT_ID_KUNDE,
	BESTELLART_ID
) AS
-- 18.09.2020, AP0064865, SPEC0085770, baranowska, create view
-- 18.09.2020, AP0064865, SPEC0085770, nwag2310, added HU guids
-- 15.12.2020, AP0064865, SPEC0085770, nwag2310, added dat_/datzei_erstellung - datzeit_we to be adjusted in schema! + added rollback_fg + art_2 guid set to left join, can be 00 in lageraufgabe_2
-- 25.03.2021, SPEC0107644, AP0081632 , dknop, adding  datzeit_quittierung, lagerprozess_extern_id 
-- 26.03.2021, SPEC0107644, AP0081632 , dknop, adding queue_id, ausnahme_code
-- 30.03.2021, SPEC0107644, AP0081632 , nwag2310, removed rollback (currently only required in lageraufgabe_we_2), changed art_guid to inner join
-- 22.04.2021, SPEC0107644, AP0081632 , dknop, adding lagertyp_id_von
-- 19.05.2021, SPEC0112147, AP0070892, dknop, adding datzeit_start, lagerprozesstyp_id, konsolidierungsgruppe_id,ewm_exc_kategorie_id,bus_kontext,ausfuehr_schritt_id,zeugnis_nr,lief_pal_typ_id,werbeware_id,ewm_gv_id,welle_id,welle_pos_id,lagerauftrag_id, ewm_gv_grp_id
-- 20.05.2021, SPEC0112147, AP0070892, dknop, adding menge_soll_bme, menge_ist_bme, gv_menge_bewegt
-- 21.05.2021, SPEC0112147, AP0070892, dknop, adding lageraufgabe_pos_id
-- 08.06.2021, SPEC0112147, AP0070892, dknop, zerotonull for konsolidierungsgruppe_id, welle_id, welle_pos_id, ewm_gv_id
-- 09.07.2021, SPEC0107644, AP0081632, dknop, adding artikelsortiment, lagersoriment and changing to left join for art_guid_zu_2
-- 14.07.2021, SPEC0112147, AP0070892, artikelsortiment_id null to '0' 
-- 20.07.2021, SPEC0112147, AP0070892, lagersortiment_id null to '0' 
-- AP0147364_SPEC0171786, dknop, adding lagerplatz_id_nach,lagerplatz_id_von
-- AP0190542_SPEC0217469, dknop, adding dat_lief_soll
--2023-11-24, dknop, removing dat_lief_soll
-- AP0190542_SPEC0217469, dknop, adding wg_verkett_lief + re_2-adding dat_lief_soll
--2024-01-29, dknop, COALESCE for lagertyp_id_von
--2024-06-04, nwag, added t_r for performance + LIPS for bestellart_id
--2024-06-25, nwag, AND likp.lief_beleg_id= TRY_CAST(refdoc_i.referenzbeleg_id as NUMBER(35,0))  --::NUMBER(35,0)=proci_o.beleg_id
SELECT
v01.mandant_id,
v01.lageraufgabe_id,
v01.lageraufgabe_pos_id,
v01.lagerprozessart_id,
v01.status_id,
v01.lagerprozess_id,
v01.lagerprozesstyp_id,
v01.menge_kolli,
v01.menge_soll_bme,
v01.menge_ist_bme,
v01.gv_menge_bewegt,
v01.lagerbereich_id_nach,
v01.lagertyp_id_nach,
COALESCE(v01.lagertyp_id_von,'') AS lagertyp_id_von,
/* ,v01.lagerort_id wird erstmal seitens Quellsystem nicht befüllt und daher hier entfernt*/
NVL(v02.art_id, -1) AS art_id,
v01.art_guid,
v01.lagernummer_id,
v01.le_typ_id,
v01.gewicht_netto,
v01.gew_einh_id,
v01.volumen,
v01.vol_einh_id,
v01.dat_mhd,
v01.datzeit_we,
CAST(v01.datzeit_we AS DATE) AS dat_we,
v01.datzeit_erstellung,
CAST(v01.datzeit_erstellung AS DATE) AS dat_erstellung,
CAST(v01.datzeit_erstellung AS TIME) AS zeit_erstellung,
CASE
WHEN Trim(v01.handling_unit_id_nach) = '' THEN NULL
ELSE v01.handling_unit_id_nach END AS handling_unit_id_nach,
v01.handling_unit_guid_nach,
v01.handling_unit_id_von,
v01.handling_unit_guid_von,
v01.bestandsart_id,
v01.charge_id,
v01.gefahrstoff_fg,
v01.aktivitaetsbereich_id,
v01.datzeit_quittierung,
CAST(v01.datzeit_quittierung AS DATE) AS dat_quittierung,
CAST(v01.datzeit_quittierung AS TIME) AS zeit_quittierung,
v01.lagerprozess_extern_id,
v01.queue_id,
v01.ausnahme_code,
CAST(v01.datzeit_start AS DATE) AS dat_start,
CAST(v01.datzeit_start AS TIME) AS zeit_start,
NULLIFZERO(v01.konsolidierungsgruppe_id) AS konsolidierungsgruppe_id,
v01.ewm_exc_kategorie_id,
v01.bus_kontext,
v01.ausfuehr_schritt_id,
v01.zeugnis_nr,
v01.lief_pal_typ_id,
v01.werbeware_id,
NULLIFZERO(v01.ewm_gv_id) AS ewm_gv_id,
NULLIFZERO(v01.welle_id) AS welle_id,
NULLIFZERO(v01.welle_pos_id) AS welle_pos_id,
v01.lagerauftrag_id, 
v01.ewm_gv_grp_id,
NVL(a_sort.artikelsortiment_id,'0') AS artikelsortiment_id ,
CASE WHEN v01.lagertyp_id_nach <> '' THEN LEFT(v01.lagertyp_id_nach,1) 
 WHEN v01.lagertyp_id_von <> '' THEN  LEFT(v01.lagertyp_id_von,1) ELSE '0' END AS lagersortiment_id,
v01.lagerplatz_id_nach,
v01.lagerplatz_id_von
,refdoc.dat_lief_soll
,refdoc.wg_verkett_lief
,refdoc.mandant_id_kunde
,refdoc.bestellart_id
--,CASE WHEN v03.lageraufgabe_id IS NOT NULL THEN 1 ELSE 0 end AS rollback_fg
FROM dbp_view.v_lageraufgabe_2 v01

LEFT JOIN 
( 
       SELECT 
        refdoc_i.mandant_id 
       ,refdoc_i.beleg_guid 
       ,refdoc_i.beleg_pos_guid 
       ,refdoc_i.referenzbeleg_guid 
       ,refdoc_i.referenzbeleg_pos_guid 
       ,refdoc_i.referenzbeleg_id 
       ,refdoc_i.referenzbeleg_pos_id 
       ,ROW_NUMBER() OVER (PARTITION BY refdoc_i.mandant_id, refdoc_i.beleg_guid,refdoc_i.beleg_pos_guid ORDER BY refdoc_i.datzeit_termin_beginn DESC NULLS LAST) AS relevant
       ,likp.dat_lief_soll
       ,likp.wg_verkett_lief
       ,likp.mandant_id_kunde
       ,COALESCE(lips.bestellart_id,'-1') AS bestellart_id
       FROM dbp_view.v_belegreferenz_2 refdoc_i 
JOIN dbp_view.v_auslieferposition_2 proci_o 
ON  proci_o.mandant_id = refdoc_i.mandant_id 
AND proci_o.beleg_guid = refdoc_i.beleg_guid 
AND proci_o.beleg_pos_guid = refdoc_i.beleg_pos_guid
AND proci_o.beleg_id <= 999999999999999999
AND refdoc_i.referenz_belegtyp_id='ERO'
 
JOIN dbp_view.v_besch_lief_2 likp 
ON likp.mandant_id = proci_o.mandant_id 
AND likp.lief_beleg_id= TRY_CAST(refdoc_i.referenzbeleg_id AS NUMBER(35,0))  --::NUMBER(35,0)=proci_o.beleg_id
AND likp.dat_lief_soll = COALESCE(proci_o.dat_lief_soll, likp.dat_lief_soll)

LEFT JOIN dbp_view.v_besch_lief_det_2 lips 
ON likp.mandant_id = lips.mandant_id 
AND likp.lief_beleg_id = lips.lief_beleg_id
AND refdoc_i.referenzbeleg_pos_id  = lips.lief_beleg_pos_id
AND likp.dat_lief_soll = lips.dat_lief_soll
  
JOIN dbp_view.v_tag_2 t
ON likp.dat_lief_soll=t.dat 
AND t.akt_kj BETWEEN -2 AND 0

JOIN dbp_view.v_tag_2 t_r
ON COALESCE(refdoc_i.datzeit_erstellung::DATE,CURRENT_DATE)=t_r.dat 
AND t_r.akt_kj BETWEEN -2 AND 0
 
) refdoc  
       ON v01.mandant_id = refdoc.mandant_id 
       --AND v01.datzeit_erstellung::DATE BETWEEN refdoc.dat_lief_soll - 365 AND refdoc.dat_lief_soll + 365
       AND v01.ref_beleg_guid=refdoc.beleg_guid 
       AND v01.ref_beleg_pos_guid=refdoc.beleg_pos_guid 
       AND refdoc.relevant=1 

JOIN dbp_view.v_l_lagernummer_2 t001l
ON v01.mandant_id = t001l.mandant_id
AND v01.lagernummer_id = t001l.lagernummer_id

JOIN dbp_view.v_art_guid_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.art_guid = v02.art_guid

JOIN dbp_view.v_art_wup_status_per_2 marc_2
ON t001l.mandant_id = marc.mandant_id
AND marc.nb_id=-111
AND marc.dat_bis='9999-12-31'
AND t001l.wup_id = marc.wup_id
AND v02.art_id = marc.art_id

JOIN  dbp_view.v_fremd_lagerort_artikelsortiment_zu_2 a_sort
ON marc.fremd_lagerort_id = a_sort.fremd_lagerort_id
AND marc.mandant_id = a_sort.mandant_id

JOIN dbp_view.v_tag_2 t_q
ON v01.datzeit_quittierung::DATE=t_q.dat 
AND t_q.akt_kj BETWEEN -2 AND 0
;