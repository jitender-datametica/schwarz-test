CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BESCH_FAKTURA_MEDATA_2
(
	ART_ID,
	DAT_FAKTURA,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	MENGE_FAKTURIERT,
	VZ_WUP_ID,
	VZ_NB_ID,
	GP_ID,
	POSTEN_KZ_PER,
	MD_FAKTURA_EK_N,
	MD_EK_NETTO_BNK,
	MD_ZEKP_EK_BRUTTO,
	MD_ZEKP_EK_MEP,
	MD_ZEKP_EK_MEPOLK
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.art_id, 
v01.dat_faktura, 
v02.wup_id, 
v02.nb_id, 
v01.mandant_id, 
v01.menge_fakturiert, 
v01.wup_id AS vz_wup_id, 
v01.nb_id AS vz_nb_id, 
v03.gp_id, 
CASE WHEN v06.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER, 
v01.zwsum_3_betrag AS md_faktura_ek_n, 
v01.ek_netto_bnk AS md_ek_netto_bnk, 
v01.zwsum_3_betrag * CAST((100 +v05.mwst)/ 100 AS NUMBER(38,5)) AS md_zekp_ek_brutto, 
v01.ek_mep AS md_zekp_ek_mep, 
v01.ek_mep - v01.logistikkostenzuschlag AS md_zekp_ek_mepolk

FROM dbp_view.v_besch_faktura_medata_2 v01

JOIN dbp_view.v_wup_2 v02
ON v01.faktura_markt = v02.wup_id
AND v01.mandant_id = v02.mandant_id

JOIN dbp_view.v_art_gp_zu_per_2 v03
ON v01.art_id = v03.art_id
AND v01.mandant_id = v03.mandant_id
AND v01.dat_faktura BETWEEN v03.dat_von AND v03.dat_bis

JOIN dbp_view.v_art_2 v04
ON v01.art_id = v04.art_id
AND v01.mandant_id = v04.mandant_id

JOIN dbp_view.v_mwst_per_2 v05
ON v04.mwst_id = v05.mwst_id
AND v04.mandant_id = v05.mandant_id
AND v01.dat_faktura BETWEEN v05.dat_von AND v05.dat_bis
   
LEFT JOIN dbp_view.v_art_per_2 v06
ON v01.art_id = v06.art_id
AND v01.mandant_id = v06.mandant_id
AND v01.dat_faktura BETWEEN v06.dat_von-1 AND v06.dat_bis-1 

WHERE v01.mandant_id = 1;