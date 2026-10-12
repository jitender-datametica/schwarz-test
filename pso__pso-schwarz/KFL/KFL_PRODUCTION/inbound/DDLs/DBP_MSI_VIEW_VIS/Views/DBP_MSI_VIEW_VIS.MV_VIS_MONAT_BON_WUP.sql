CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BON_WUP (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	KJMO,
	BON_REF,
	BON_REF_KVJ,
	BON_UGS,
	BON_UGS_KVJ,
	KUNDENFAKTOR
) AS 
 -- FAKT-AGGREGAT Kunden (Bonanzahl UGS) pro Monat - WUP
 -- VORAB-VERSION als separate view
 -- 20151027 INITIAL
 -- 20160408 Erweiterung/Anpassung NB Gastro/TKS
 -- 2024-08-22 ssch0611 : Filialumgliederung + Review [P1760-DWH]

SELECT
  COALESCE(wc01.mandant_id, wc02.mandant_id) AS mandant_id
, COALESCE(wc01.nb_id, wc02.nb_id)           AS nb_id
, wup.aktuell_wup_id                         AS wup_id
, COALESCE(wc01.kjmo, (wc02.kjmo + 100))     AS kjmo
, wc01.bonanzahl                             AS bon_ref
, wc02.bonanzahl                             AS bon_ref_kvj
, CASE
	WHEN wc01.nb_id = 0 THEN wc01.bonanzahl_sug
	ELSE wc01.bonanzahl
  END AS bon_ugs
, CASE
	WHEN wc02.nb_id = 0 THEN wc02.bonanzahl_sug
	ELSE wc02.bonanzahl
  END AS bon_ugs_kvj
, COALESCE(wup.kundenfaktor, 1)       AS kundenfaktor
FROM (
	SELECT wc.mandant_id, wc.nb_id, wc.wup_id, zeit.kjmo, SUM(bonanzahl) bonanzahl, SUM(bonanzahl_sug) bonanzahl_sug
	FROM dbp_view.v_wupcal  wc
	JOIN dbp_view.v_tag  zeit
	ON zeit.dat = wc.dat AND akt_gj BETWEEN -1 AND 0
	AND nb_id IN (0, 2, 7)
	GROUP BY ALL
) wc01
 
FULL OUTER JOIN (
	SELECT wc.mandant_id, wc.nb_id, wc.wup_id, zeit.kjmo,  SUM(bonanzahl) bonanzahl, SUM(CASE WHEN kjmo > 201502 THEN bonanzahl_sug ELSE 0 END) bonanzahl_sug
	FROM dbp_view.v_wupcal  wc
	JOIN dbp_view.v_tag  zeit
	ON zeit.dat = wc.dat AND akt_gj BETWEEN -2 AND -1
	AND nb_id IN (0, 2, 7)
	GROUP BY ALL
) wc02
ON wc02.mandant_id = wc01.mandant_id
AND wc02.wup_id = wc01.wup_id
AND wc02.kjmo = (wc01.kjmo - 100)
 
JOIN dbp_view.v_wup wup
ON wup.mandant_id = COALESCE(wc01.mandant_id, wc02.mandant_id)
AND wup.wup_id =  COALESCE(wc01.wup_id, wc02.wup_id)
;