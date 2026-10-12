CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_LIEFERUNGSKUERZUNG_SPR_ZU_2(
	LIEFERUNGSKUERZUNG_FG,
	LIEFERUNGSKUERZUNG_BEZ,
	LIEFERUNGSKUERZUNG_BEZ_DE,
	LIEFERUNGSKUERZUNG_BEZ_CZ,
	LIEFERUNGSKUERZUNG_BEZ_SK,
	LIEFERUNGSKUERZUNG_BEZ_HR,
	LIEFERUNGSKUERZUNG_BEZ_PL,
	LIEFERUNGSKUERZUNG_BEZ_RO,
	LIEFERUNGSKUERZUNG_BEZ_BG
) AS
--2024-04-30, AP0179753, dknop, initial
--2024-05-15, AP0179753, dknop, adding new ids
--2024-06-21, adding LIEFERUNGSKUERZUNG_FG=5
--2025-01-21, adding -8 / 8
SELECT
 0 AS lieferungskuerzung_fg
,'Keine Kürzung' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'Bestellung ohne Kürzung generiert' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'Order generated without shortening' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'Order generated without shortening' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'Order generated without shortening' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'Order generated without shortening' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'Order generated without shortening' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'Order generated without shortening' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 1 AS lieferungskuerzung_fg
,'ZLDELMON_SHORT (ATP-Check)' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'ZLDELMON_SHORT (ATP-Check)' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'ZLDELMON_SHORT (ATP-Check)' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'ZLDELMON_SHORT (ATP-Check)' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'ZLDELMON_SHORT (ATP-Check)' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'ZLDELMON_SHORT (ATP-Check)' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'ZLDELMON_SHORT (ATP-Check)' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'ZLDELMON_SHORT (ATP-Check)' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 2 AS lieferungskuerzung_fg
,'ZBLOCKBEST_SHORT' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'ZBLOCKBEST_SHORT' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'ZBLOCKBEST_SHORT' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'ZBLOCKBEST_SHORT' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'ZBLOCKBEST_SHORT' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'ZBLOCKBEST_SHORT' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'ZBLOCKBEST_SHORT' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'ZBLOCKBEST_SHORT' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 3 AS lieferungskuerzung_fg
,'ZLV0BEST_SHORT' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 4 AS lieferungskuerzung_fg
,'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 5 AS lieferungskuerzung_fg
,'EKPO.LOEKZ = X jedoch Lieferposition vorhanden' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'EKPO.LOEKZ = X jedoch Lieferposition vorhanden (alt)' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'EKPO.LOEKZ = X but delivery position exists (old)' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'EKPO.LOEKZ = X but delivery position exists (old)' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'EKPO.LOEKZ = X but delivery position exists (old)' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'EKPO.LOEKZ = X but delivery position exists (old)' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'EKPO.LOEKZ = X but delivery position exists (old)' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'EKPO.LOEKZ = X but delivery position exists (old)' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez


UNION

SELECT
 -2 AS lieferungskuerzung_fg
,'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'  AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'  END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'  END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'  END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'  END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 -3 AS lieferungskuerzung_fg
,'ZLV0BEST_SHORT, EKPO.LOEKZ = X' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 -4 AS lieferungskuerzung_fg
,'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 -5 AS lieferungskuerzung_fg
,'Bestellung nicht generiert' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'Bestellung nicht generiert' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'Order not generated' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'Order not generated' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'Order not generated' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'Order not generated' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'Order not generated' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'Order not generated' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 -6 AS lieferungskuerzung_fg
,'Bestellung nicht generiert, EKPO.LOEKZ = X (mit Löschkennzeichen)' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'Bestellung nicht generiert, EKPO.LOEKZ = X (mit Löschkennzeichen)' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez


UNION

SELECT
 -8 AS lieferungskuerzung_fg
,'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge = 0' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge = 0' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez

UNION

SELECT
 8 AS lieferungskuerzung_fg
,'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge > 0' AS lieferungskuerzung_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN 'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge > 0' END) AS lieferungskuerzung_bez_de
,MAX(CASE WHEN v01.spr_id = 124 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0' END) AS lieferungskuerzung_bez_cz
,MAX(CASE WHEN v01.spr_id = 108 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0' END) AS lieferungskuerzung_bez_sk
,MAX(CASE WHEN v01.spr_id = 65 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0' END) AS lieferungskuerzung_bez_hr
,MAX(CASE WHEN v01.spr_id = 90 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0' END) AS lieferungskuerzung_bez_pl
,MAX(CASE WHEN v01.spr_id = 95 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0' END) AS lieferungskuerzung_bez_ro
,MAX(CASE WHEN v01.spr_id = 18 THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0' END) AS lieferungskuerzung_bez_bg
FROM dbp_view.v_spr_2 v01
WHERE v01.spr_id IN (22, 124, 108, 65, 90,95,18)
GROUP BY lieferungskuerzung_fg, lieferungskuerzung_bez
;
