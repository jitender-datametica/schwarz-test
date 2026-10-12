CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BESCH_FAKTURA_DET_2
(
	ART_ID,
	MANDANT_ID,
	VZ_NB_ID,
	VZ_WUP_ID,
	DAT_FAKTURA,
	FAKTURA_TYP_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	POSTEN_KZ_PER,
	RETOURE_FG,
	BESTELLART_ID,
	FAKTURA_BELEG_ID,
	FAKTURA_MENGE_BME,
	FAKTURA_MENGE_KOLLI,
	FAKTURA_WERT_EK_NETTO,
	FAKTURA_WERT_EK_BRUTTO,
	FAKTURA_ZEKP_EK_NETTO_BNK,
	FAKTURA_ZEKP_EK_MEP,
	FAKTURA_ZEKP_EK_MEPOLK
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
 v01.art_id
,v01.mandant_id
,v01.nb_id AS vz_nb_id
,v01.wup_id AS vz_wup_id
,v01.dat_faktura
,v02.faktura_typ_id
,v03.wup_id AS wup_id
,v03.nb_id
,v09.gp_id
,CASE WHEN v10.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','S') THEN 1 ELSE 0 END AS BYTEINT) AS retoure_fg
,v01.bestellart_id
,v01.faktura_beleg_id
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN v01.menge_faktura_bme * -1 ELSE v01.menge_faktura_bme END AS DECIMAL(18,3)) AS faktura_menge_bme
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN v01.menge_faktura_kolli            * -1 ELSE v01.menge_faktura_kolli            END AS DECIMAL(18,3)) AS faktura_menge_kolli
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * -1 ELSE (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) END AS DECIMAL(18,2)) AS faktura_wert_ek_netto
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * CAST(v01.mwst/100 + 1 AS NUMBER(38,5)) * -1 ELSE (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * (CAST(v01.mwst/100 + 1 AS NUMBER(38,5))) END AS DECIMAL(18,2)) AS faktura_wert_ek_brutto
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN v01.ek_netto_bnk * -1 ELSE v01.ek_netto_bnk END AS DECIMAL(18,2)) AS faktura_zekp_ek_netto_bnk
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.ek_mep) * -1 ELSE v01.ek_mep END AS DECIMAL(18,2)) AS faktura_zekp_ek_mep
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.ek_mep - v01.zwsum_6_betrag) * -1 ELSE (v01.ek_mep - v01.zwsum_6_betrag) END AS DECIMAL(18,2)) AS faktura_zekp_ek_mepolk

FROM dbp_view.v_besch_faktura_det_2 v01

JOIN dbp_view.v_besch_faktura_2 v02
ON v01.faktura_beleg_id=v02.faktura_beleg_id
AND v01.mandant_id = v02.mandant_id
AND v01.dat_faktura_sap = v02.dat_faktura_sap
AND v02.auftraggeber_id BETWEEN '0000001000' AND '0000009999'

JOIN dbp_view.v_wup_2 v03
ON TRY_CAST (v02.auftraggeber_id AS INTEGER) = v03.wup_id
AND v01.mandant_id = v03.mandant_id

JOIN dbp_view.v_art_wg_zu_per_2 v05
ON v01.art_id = v05.art_id
AND v01.mandant_id = v05.mandant_id
AND CURRENT_DATE BETWEEN v05.dat_von AND v05.dat_bis

JOIN dbp_view.v_wg_per_2 v06
ON v05.wg_id = v06.wg_id
AND v05.mandant_id = v06.mandant_id
AND CURRENT_DATE BETWEEN v06.dat_von AND v06.dat_bis

JOIN dbp_view.v_owg_per_2 v07
ON v06.owg_id = v07.owg_id
AND v06.mandant_id = v07.mandant_id
AND CURRENT_DATE BETWEEN v07.dat_von AND v07.dat_bis

JOIN dbp_view.v_hwg_per_2 v08
ON v07.hwg_id = v08.hwg_id
AND v07.mandant_id = v08.mandant_id
AND CURRENT_DATE BETWEEN v08.dat_von AND v08.dat_bis

JOIN dbp_view.v_art_gp_zu_per_2 v09
ON v01.art_id = v09.art_id
AND v01.mandant_id = v09.mandant_id
AND v01.dat_faktura BETWEEN v09.dat_von AND v09.dat_bis
AND v08.hwg_id <> 64

LEFT JOIN dbp_view.v_art_per_2 v10
ON v01.art_id = v10.art_id
AND v01.mandant_id = v10.mandant_id
AND v01.dat_faktura BETWEEN v10.dat_von-1 AND v10.dat_bis-1 

WHERE v01.mandant_id = 1
-- 20100330 Filterung der IWT Fakturen
AND v02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
AND v01.nb_id <> 99

UNION ALL

SELECT
 v01.art_id
,v01.mandant_id
,v01.nb_id AS vz_nb_id
,v01.wup_id AS vz_wup_id
,v01.dat_preisfindung AS dat_faktura
,v02.faktura_typ_id
,v03.wup_id AS wup_id
,v03.nb_id
,v09.gp_id
,CASE WHEN v10.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','S') THEN 1 ELSE 0 END AS BYTEINT) AS retoure_fg
,v01.bestellart_id
,v01.faktura_beleg_id
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN v01.menge_faktura_bme * -1 ELSE v01.menge_faktura_bme END AS DECIMAL(18,3)) AS faktura_menge_bme
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN v01.menge_faktura_kolli            * -1 ELSE v01.menge_faktura_kolli            END AS DECIMAL(18,3)) AS faktura_menge_kolli
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * -1 ELSE (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) END AS DECIMAL(18,2)) AS faktura_wert_ek_netto
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * CAST(v01.mwst/100 + 1 AS NUMBER(38,5)) * -1 ELSE (v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag) * (CAST(v01.mwst/100 + 1 AS NUMBER(38,5))) END AS DECIMAL(18,2)) AS faktura_wert_ek_brutto
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN v01.ek_netto_bnk * -1 ELSE v01.ek_netto_bnk END AS DECIMAL(18,2)) AS faktura_zekp_ek_netto_bnk
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.ek_mep) * -1 ELSE v01.ek_mep END AS DECIMAL(18,2)) AS faktura_zekp_ek_mep
,CAST(CASE WHEN v02.faktura_typ_id IN ('O','N') THEN (v01.ek_mep - v01.zwsum_6_betrag) * -1 ELSE (v01.ek_mep - v01.zwsum_6_betrag) END AS DECIMAL(18,2)) AS faktura_zekp_ek_mepolk

FROM dbp_view.v_besch_faktura_det_2 v01

JOIN dbp_view.v_besch_faktura_2 v02
ON v01.faktura_beleg_id=v02.faktura_beleg_id
AND v01.mandant_id = v02.mandant_id
AND v01.dat_faktura_sap = v02.dat_faktura_sap
AND v02.auftraggeber_id BETWEEN '0000001000' AND '0000009999'

JOIN dbp_view.v_wup_2 v03
ON TRY_CAST (v02.auftraggeber_id AS INTEGER) = v03.wup_id
AND v01.mandant_id = v03.mandant_id

JOIN dbp_view.v_art_wg_zu_per_2 v05
ON v01.art_id = v05.art_id
AND v01.mandant_id = v05.mandant_id
AND CURRENT_DATE BETWEEN v05.dat_von AND v05.dat_bis

JOIN dbp_view.v_wg_per_2 v06
ON v05.wg_id = v06.wg_id
AND v05.mandant_id = v06.mandant_id
AND CURRENT_DATE BETWEEN v06.dat_von AND v06.dat_bis

JOIN dbp_view.v_owg_per_2 v07
ON v06.owg_id = v07.owg_id
AND v06.mandant_id = v07.mandant_id
AND CURRENT_DATE BETWEEN v07.dat_von AND v07.dat_bis

JOIN dbp_view.v_hwg_per_2 v08
ON v07.hwg_id = v08.hwg_id
AND v07.mandant_id = v08.mandant_id
AND CURRENT_DATE BETWEEN v08.dat_von AND v08.dat_bis

JOIN dbp_view.v_art_gp_zu_per_2 v09
ON v01.art_id = v09.art_id
AND v01.mandant_id = v09.mandant_id
AND v01.dat_preisfindung BETWEEN v09.dat_von AND v09.dat_bis
AND v08.hwg_id = 64

LEFT JOIN dbp_view.v_art_per_2 v10
ON v01.art_id = v10.art_id
AND v01.mandant_id = v10.mandant_id
AND v01.dat_faktura BETWEEN v10.dat_von-1 AND v10.dat_bis-1 

WHERE v01.mandant_id = 1
-- 20100330 Filterung der IWT Fakturen
AND v02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
AND v01.nb_id <> 99;