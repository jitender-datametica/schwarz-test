CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_VERRECHFALL_KOSTEN_1(
	BELOS_VORGANG_ID,
	MANDANT_ID,
	VERRECHFALL_KOSTENART_ID,
	BETRAG_KOSTEN,
	BELOS_ADRESSE_RECHNUNG_ID,
	BELOS_ADRESSE_STEUERUNG_ID,
	WRG_ID
) AS
--03.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_1
--08.02.2021, SPEC0091861, AP0073899, dknop, adding join to dbp_view.v_verrechfall_1
--16.06.2021, dknop, per Silke Panzer request, adding filter soll_ist_fg = 1
--23.06.2021, SPEC0091861, AP0073899, dknop, belos_adresse_rechnung_id, belos_adresse_steuerung_id
--2022.02.16, dknop, adding inner join to akt_msi_user_wrg_typ_zu_1, join to dbp_msi_view_log.mv_kurs_1 for umrechnungskurs
--2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_1 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU
--2024-07-08, dknop, adding union to new Kostenarten
--2024-10-29, nwag, limit to akt_kj > -2 due to TU repeating
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
WITH  m_kostenart AS (
SELECT 'MDIES' AS verrechfall_kostenart_id UNION 
SELECT 'MSTRO' AS verrechfall_kostenart_id UNION
SELECT 'MGAS' AS verrechfall_kostenart_id UNION
SELECT 'MMAUT' AS verrechfall_kostenart_id UNION
SELECT 'MKUEH' AS verrechfall_kostenart_id 
)
SELECT
v01.belos_vorgang_id
,v01.mandant_id
,v02.verrechfall_kostenart_id
,SUM(CASE WHEN v04.wrg_typ_id = 0 THEN v02.betrag_kosten * v03.umrechnungskurs ELSE v02.betrag_kosten END) AS betrag_kosten
,COALESCE (v01.belos_adresse_rechnung_id, '-1') AS belos_adresse_rechnung_id
,COALESCE (v01.belos_adresse_steuerung_id, '-1') AS belos_adresse_steuerung_id
--,v01.verrechfall_id
--,v02.verrechfall_kosten_id
--,v02.mwst_id
--,v01.storno_fg
--,v02.soll_ist_fg
--,v02.manuelle_erfassung_fg
,CASE WHEN v05.wrg_typ_id=0 THEN 'EUR' ELSE v01.wrg_id END AS wrg_id_
--,v02.dat_verrechnung_intern
--,v02.dat_verrechnung_extern
--,v02.verrechfall_status_id
--,v02.bemerkung
--,v01.belosart_fg
--,v02.zeit_verrechnung_intern
FROM dbp_view.v_verrechfall_1 v01
LEFT JOIN dbp_view.v_verrechfall_kosten_1 v02 
ON v02.verrechfall_id=v01.verrechfall_id 
AND v02.mandant_id=v01.mandant_id
LEFT JOIN dbp_msi_view_log.mv_kurs_1 v03 ON v01.wrg_id = v03.von_wrg_id
INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v04 ON v02.mandant_id = v04.mandant_id 
INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v05 -- dbp_msi.akt_msi_user_wrg_typ_zu_1 v05 
ON v04.wrg_typ_id = v05.wrg_typ_id
WHERE soll_ist_fg=1
  GROUP BY v01.belos_vorgang_id,v01.mandant_id,v02.verrechfall_kostenart_id,belos_adresse_rechnung_id,belos_adresse_steuerung_id,v01.wrg_id, v05.wrg_typ_id

--example: where v01.belos_vorgang_id=18891068
UNION

SELECT 
bv.belos_vorgang_id
,bv.mandant_id
,verrechfall_kostenart_id
,SUM(CASE WHEN verrechfall_kostenart_id = 'MDIES' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_diesel * v03.umrechnungskurs ELSE betrag_diesel END  
WHEN verrechfall_kostenart_id = 'MSTRO' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_strom * v03.umrechnungskurs ELSE betrag_strom END 
WHEN verrechfall_kostenart_id = 'MGAS' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_gas * v03.umrechnungskurs ELSE betrag_gas END
WHEN verrechfall_kostenart_id = 'MMAUT' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_maut * v03.umrechnungskurs ELSE betrag_maut END
WHEN verrechfall_kostenart_id = 'MKUEH' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_kuehlung * v03.umrechnungskurs ELSE betrag_kuehlung END 
ELSE 0 END) AS betrag_kosten
,vf.belos_adresse_rechnung_id
,vf.belos_adresse_steuerung_id
,CASE WHEN v05.wrg_typ_id=0 THEN 'EUR' ELSE tu_k_up.wrg_id END AS wrg_id_
FROM dbp_view.v_transportation_unit_kosten_1 tu_k_up
JOIN ( SELECT mandant_id, tour_id,  b.dat_leistung, MAX(belos_vorgang_id) AS belos_vorgang_id, MAX(belos_adresse_absender_num_id) AS belos_adresse_absender_num_id 
       FROM dbp_view.v_belos_vorgang_1 b
       JOIN dbp_view.v_tag_1 t ON b.dat_leistung=t.dat AND t.akt_kj >= -2
       GROUP BY  mandant_id, tour_id, b.dat_leistung ) bv  
ON tu_k_up.mandant_id = bv.mandant_id
AND tu_k_up.transportation_unit_id = bv.tour_id
AND tu_k_up.wup_id = bv.belos_adresse_absender_num_id
AND tu_k_up.KJ_TRANSPORTATION_UNIT = YEAR(bv.dat_leistung)
 
JOIN ( --doing max() is mostly "just in case"; as of 2024-07-08 there are no cases in which there are > 1 distinct values for rechnung/steuerung
       SELECT mandant_id, belos_vorgang_id, MAX(belos_adresse_rechnung_id) AS belos_adresse_rechnung_id , MAX(belos_adresse_steuerung_id) AS belos_adresse_steuerung_id 
       FROM dbp_view.v_verrechfall_1 bv  
       WHERE STORNO_FG=0 AND BELOSART_FG=1
       GROUP BY mandant_id, belos_vorgang_id
       ) vf_1
ON vf.mandant_id = bv.mandant_id
AND vf.belos_vorgang_id = bv.belos_vorgang_id
CROSS JOIN m_kostenart

LEFT JOIN dbp_msi_view_log.mv_kurs_1 v03 ON tu_k_up.wrg_id = v03.von_wrg_id
INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v04 ON bv.mandant_id = v04.mandant_id 
INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v05 -- dbp_msi.akt_msi_user_wrg_typ_zu_1 v05 
ON v04.wrg_typ_id = v05.wrg_typ_id

GROUP BY bv.belos_vorgang_id,bv.mandant_id,verrechfall_kostenart_id,vf.belos_adresse_rechnung_id,vf.belos_adresse_steuerung_id, v05.wrg_typ_id, tu_k_up.wrg_id 
HAVING betrag_kosten > 0;