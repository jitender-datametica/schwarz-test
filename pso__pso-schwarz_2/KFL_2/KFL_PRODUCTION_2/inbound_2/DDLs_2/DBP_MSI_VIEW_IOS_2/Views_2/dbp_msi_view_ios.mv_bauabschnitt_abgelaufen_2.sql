CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_bauabschnitt_abgelaufen_2
-- k.kaiser #616127, #616128 es sollen auch gesperrte Phasen ausgefiltert werden
-- kkaiser 1151119 gesperrte Phasen  nun wirklich ausgesperrt
(
    projekt_nr
    ,projekt_id
    ,projekt_phase_id
    --,bauabschnitt_id
    ,bauabschnitt_abgelaufen_kz
)
AS
SELECT
pr.projekt_nr
,pr.projekt_id
,ph.projekt_phase_id
,COALESCE(cll.bauabschnitt_abgelaufen_kz,0)
FROM  dbp_view.v_cpr_phase_per_2 ph

JOIN dbp_msi_view_ios.mv_cpr_projekt_2 pr
ON  (ph.projekt_id = pr.projekt_id)

JOIN dbp_msi_view_ios.mv_projekt_fg_2 fg
ON  (fg.projekt_id = pr.projekt_id)

LEFT  JOIN
(
SELECT
ph.projekt_id
,ph.projekt_phase_id
,CASE
WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND
cl.dat_termin + 30 <=  CURRENT_DATE() AND cl.dat_termin IS NOT NULL)
OR  ph.cpr_systemstatus2_id = 1
THEN 1
ELSE 0
END
AS bauabschnitt_abgelaufen_kz
FROM   dbp_msi_view_ios.mv_cpr_cl_punkt_2 cl
JOIN    dbp_view.v_cpr_phase_per_2 ph
ON ph.projekt_phase_id = cl.projekt_phase_id
AND ph.dat_bis = '9999-12-31'
AND cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
--and ph.cpr_systemstatus2_id <> 1
GROUP BY 1,2,3
)
cll
ON ph.projekt_phase_id = cll.projekt_phase_id
WHERE SUBSTR (pr.projekt_nr, 14, 2) in ('NB_2','UB','ST','RE_2','RN','RG','RX','SO','RU','TK','GA','IG','SL')
AND ph.dat_bis = '9999-12-31'
and pr.cpr_systemstatus1_id = 2
AND fg.ist_aufnahme_technik_fg < 1

AND fg.apl_nat_fg = 1
and  cll.projekt_phase_id is not null
GROUP BY 1,2,3,4;
