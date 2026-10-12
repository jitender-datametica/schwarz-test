CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_AOF_PROGNOSE_VS_BESTELLUNG_1
AS
--mcie, 05/08/2019, AP0044667 - new view
--mcie, 28/08/2019, AP0044667 - added wup_id and where clause
--nwag, 04/09/2019, AP0044667 - performance optimization, logical bugfixes, redundant columns removed, where-clause now done in ETL
--nwag, 10/28/2019, AP0044667 - performance optimization, workaround bestellart (max)
--nwag, 11/08/2019, AP0044667 - new timelines instead of EKPO_1 & Co.
--nwag, 25/01/2021, INC2681557 - redesign to determine latest rundate per art_1/dat/wup_1/zeitreihe here instead of frontend
--nwag, 09/07/2021, NSR2111750 - all records but the one with the latest rundate per art_1/dat/wup_1/zeitreihe have been deleted in prod --> removed use of window function for performance
--20231122, nwag, limit to last 2 yrs - cost opt.

WITH aof AS
(SELECT
v00.mandant_id,
v00.wup_id,
v00.nb_id,
v00.art_id,
v00.dat,
v00.zeitreihenart,
v00.dat_prognoselauf,
v00.menge
--,row_number() over (partition by mandant_id,wup_id,art_id,dat,zeitreihenart order by dat_prognoselauf desc) as relevant
FROM dbp_view.v_aof_prognose_1 v00
JOIN dbp_view.v_tag_1 v01 ON v00.dat = v01.dat AND akt_kj BETWEEN -2 AND 2  --2 because + 420 days are possible!
) SELECT
v000.mandant_id,
v000.art_id,
v000.dat AS aof_dat,
-1 AS bestellart_id,
CASE
WHEN zeitreihenart1 = 'PLNGI_HIST' THEN plngihist.menge
WHEN zeitreihenart1 = 'AOF_HIST' THEN aofhist.menge
ELSE NULL END AS menge_prognose,
v000.wup_id,
v000.nb_id,
v001.zeitreihenart1 AS zeitreihenart,
v000.dat_prognoselauf,
v000.menge AS menge_best_bme
FROM aof AS v000

CROSS JOIN
(SELECT
zeitreihenart1
FROM (SELECT
'PLNGI_HIST' AS zeitreihenart1) a
UNION ALL
SELECT
zeitreihenart1
FROM  (SELECT
'AOF_HIST' AS zeitreihenart1) b) v001

JOIN aof AS plngihist
ON v000.mandant_id = plngihist.mandant_id AND v000.art_id = plngihist.art_id
AND  v000.dat = plngihist.dat AND v000.wup_id=plngihist.wup_id AND v001.zeitreihenart1=plngihist.zeitreihenart
 --and plngihist.relevant=1

JOIN
aof AS aofhist
ON v000.mandant_id = aofhist.mandant_id AND v000.art_id = aofhist.art_id
AND  v000.dat = aofhist.dat AND v000.wup_id=aofhist.wup_id AND v001.zeitreihenart1=aofhist.zeitreihenart
  --and aofhist.relevant=1

WHERE v000.zeitreihenart = 'CONS_DATA'
--and v000.relevant=1;
--and v000.relevant=1;
;