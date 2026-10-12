CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_FEHLMENGEN_NGW_EK_2(
	MANDANT_ID,
	DAT_LIEF_SOLL,
	WUP_ID,
	NB_ID,
	ART_ID,
	LAGERORT_ID,
	GP_ID,
	DIFF_ID,
	MENGE_LIEF_IST_KOLLI_MARKT,
	MENGE_LIEF_SOLL_KOLLI_MARKT
) TARGET_LAG = '60 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
--2025-11-14, dknop, initial
 AS
SELECT
    t1.mandant_id,
    t1.DAT_LIEF_SOLL,
    t1.wup_id, --vz
    t1.nb_id,
    t1.art_id,
    t1.LAGERORT_ID,
    t2.gp_id,
    t1.diff_id,
    SUM(MENGE_LIEF_IST_KOLLI) AS MENGE_LIEF_IST_KOLLI_markt,
    SUM(MENGE_LIEF_SOLL_KOLLI) AS MENGE_LIEF_SOLL_KOLLI_markt
    FROM
    dbp_view.v_besch_lief_fehlmengen_2 t1_2
    JOIN DBP_VIEW.v_tag_2 v06 ON t1.DAT_LIEF_SOLL=v06.dat AND v06.akt_kj BETWEEN -1 AND 0
    JOIN dbp_view.v_ek_infosatz_2 t2 ON t1.mandant_id=t2.mandant_id AND t2.art_id=t1.art_id AND t1.dat_lief_soll BETWEEN t2.dat_von AND t2.dat_bis AND t2.gp_id > 10000
    AND t2.loesch_fg = 0
    WHERE DIFF_ID NOT IN ('N','S') AND KUERZUNG_FG >= 0
    GROUP BY 1,2,3,4,5,6,7,8
;