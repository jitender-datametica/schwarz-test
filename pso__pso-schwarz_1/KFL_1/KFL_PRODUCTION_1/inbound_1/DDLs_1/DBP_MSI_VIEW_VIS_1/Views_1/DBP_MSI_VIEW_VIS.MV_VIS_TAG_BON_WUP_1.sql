CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_BON_WUP_1 (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	BON_REF,
	BON_REF_WVJ,
	BON_REF_KVJ,
	BON_UGS,
	BON_UGS_WVJ,
	BON_UGS_KVJ,
	KUNDENFAKTOR
) AS
 
 -- FAKT-AGGREGAT Kunden (Bonanzahl UGS) pro Monat_1 - WUP_1
 -- VORAB-VERSION als separate view
 -- 20160301 INITIAL
 -- 20160408 Erweiterung/Anpassung NB_1 Gastro/TKS
 -- 20160606 Erweiterung um KVJ Transformation/Pass
 -- 2024-08-22 muellerpatri : Filialumgliederung + Review [P1760-DWH]
 
SELECT
  COALESCE(wc01.mandant_id, wc02.mandant_id, wc03.mandant_id)       AS mandant_id
, COALESCE(wc01.nb_id, wc02.nb_id, wc03.nb_id)                      AS nb_id
, wup.aktuell_wup_id                                                AS wup_id
, COALESCE(wc01.dat, (wc02.dat + 364), (ADD_MONTHS(wc03.dat, +12))) AS dat
, SUM(COALESCE(wc01.bonanzahl, 0))                                  AS bon_ref
, SUM(COALESCE(wc02.bonanzahl, 0))                                  AS bon_ref_wvj
, SUM(COALESCE(wc03.bonanzahl, 0))                                  AS bon_ref_kvj
, SUM(CASE wc01.nb_id WHEN 0 THEN wc01.bonanzahl_sug ELSE wc01.bonanzahl END) AS bon_ugs
, SUM(CASE wc02.nb_id WHEN 0 THEN wc02.bonanzahl_sug ELSE wc02.bonanzahl END) AS bon_ugs_wvj
, SUM(CASE wc03.nb_id WHEN 0 THEN wc03.bonanzahl_sug ELSE wc03.bonanzahl END) AS bon_ugs_kvj
, AVG(COALESCE(wup.kundenfaktor, 1))                                AS kundenfaktor
FROM (
      SELECT 
         wc.mandant_id, 
         wc.nb_id, 
         wc.wup_id, 
         zeit.dat, 
         zeit.kjmo, 
         SUM(bonanzahl) bonanzahl, 
         SUM(bonanzahl_sug) bonanzahl_sug
      FROM dbp_view.v_wupcal_1  wc
      JOIN dbp_view.v_tag_1  zeit_1
      ON zeit.dat = wc.dat AND akt_gj BETWEEN -1 AND 0
      AND nb_id IN (0, 2, 7)
      GROUP BY 
         wc.mandant_id, 
         wc.nb_id, 
         wc.wup_id, 
         zeit.dat, 
         zeit.kjmo
) wc01
 
FULL OUTER JOIN (
      SELECT 
         wc.mandant_id, 
         wc.nb_id, 
         wc.wup_id, 
         zeit.dat, 
         zeit.kjmo, 
         SUM(bonanzahl) bonanzahl, 
         SUM(CASE WHEN kjmo > 201502 THEN bonanzahl_sug ELSE 0 END) bonanzahl_sug
      FROM dbp_view.v_wupcal_1  wc
      JOIN dbp_view.v_tag_1  zeit_1
      ON zeit.dat = wc.dat AND akt_gj BETWEEN -2 AND -1
      AND nb_id IN (0, 2, 7)
      GROUP BY
          wc.mandant_id, 
         wc.nb_id, 
         wc.wup_id, 
         zeit.dat, 
         zeit.kjmo
) wc02
ON wc02.mandant_id = wc01.mandant_id
AND wc02.wup_id = wc01.wup_id
AND wc02.dat = (wc01.dat - 364)
 
FULL OUTER JOIN (
      SELECT 
         wc.mandant_id, 
         wc.nb_id, 
         wc.wup_id, 
         zeit.dat, 
         zeit.kjmo, 
         SUM(bonanzahl) bonanzahl, 
         SUM(CASE WHEN kjmo > 201502 THEN bonanzahl_sug ELSE 0 END) bonanzahl_sug
      FROM dbp_view.v_wupcal_1  wc
      JOIN dbp_view.v_tag_1  zeit_1
      ON zeit.dat = wc.dat AND akt_gj BETWEEN -2 AND -1
      AND nb_id IN (0, 2, 7)
      GROUP BY 
         wc.mandant_id, 
         wc.nb_id, 
         wc.wup_id, 
         zeit.dat, 
         zeit.kjmo
) wc03
ON wc03.mandant_id = wc01.mandant_id
AND wc03.wup_id = wc01.wup_id
AND wc03.dat = ADD_MONTHS(wc01.dat, -12)
 
JOIN dbp_view.v_wup_1 wup_1
ON wup.mandant_id = COALESCE(wc01.mandant_id, wc02.mandant_id, wc03.mandant_id)
AND wup.wup_id =  COALESCE(wc01.wup_id, wc02.wup_id, wc03.wup_id)
 
GROUP BY ALL
;