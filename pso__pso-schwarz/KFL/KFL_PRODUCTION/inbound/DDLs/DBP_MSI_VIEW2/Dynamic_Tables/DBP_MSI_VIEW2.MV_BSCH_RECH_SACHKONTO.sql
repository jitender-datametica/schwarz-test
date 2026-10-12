CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BSCH_RECH_SACHKONTO
(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WG_ID,
	DAT,
	ART_ID,
	RECH_BELEG_ID,
	RECH_BELEG_KONT_POS_ID,
	GP_ID,
	BETRAG_BELEG,
	WE_WERT_EKN_ROW,
	WE_WERT_EKN_GOW,
	POSTEN_KZ_PER
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
   v02.mandant_id, 
   v02.wup_id, 
   v02.nb_id, 
   v01.wg_id,
   v02.dat_leist_erstellung AS dat, 
   v03.art_id, v01.rech_beleg_id, 
   v01.rech_beleg_kont_pos_id,
   v02.gp_id, v01.betrag_beleg, 
   CASE WHEN v01.betrag_beleg > 0 THEN v01.betrag_beleg END AS we_wert_ekn_row, 
   CASE WHEN v01.betrag_beleg < 0 THEN v01.betrag_beleg END AS we_wert_ekn_gow,
   CASE WHEN v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
        ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
   
   FROM dbp_view.v_besch_rech_det_kont v01
   LEFT OUTER JOIN dbp_view.v_besch_rech v02
   ON v01.rech_beleg_id = v02.rech_beleg_id
   AND v01.gj = v02.gj
   AND v01.mandant_id = v02.mandant_id
   JOIN dbp_view.v_art_wg_zu_per v03
   ON v01.wg_id*-1000 = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   AND v01.arthiertyp_id = v03.arthiertyp_id
   AND v03.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_art_per v04
   ON v03.art_id = v04.art_id
   AND v02.mandant_id = v04.mandant_id
   AND v02.dat_leist_erstellung BETWEEN v04.dat_von-1 AND v04.dat_bis-1 
   WHERE v01.mandant_id = 1
   AND 
   
   RIGHT(v01.sachkonto_id,6) IN
   (
   '314602'
   ,'314603'
   ,'314604'
   ,'314605'
   ,'314606'
   ,'314607'
   ,'314608'
   ,'314609'
   ,'314610'
   ,'314611'
   ,'314612'
   ,'314616'
   ,'314617'
   ,'314621'
   ,'314622'
   ,'314623'
   ,'314624'
   )
   AND v01.row_grund_id IN (
   '100'
   ,'101'
   ,'103'
   ,'104'
   ,'105'
   ,'106'
   ,'107'
   ,'108'
   ,'109'
   ,'110'
   ,'111'
   ,'112'
   ,'114'
   ,'116'
   ,'119'
   ,'120'
   ,'142'
   ,'160'
   ,'161'
   ,'199'
   );