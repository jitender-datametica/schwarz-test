CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_GP_WUP_ZU_PER 
--03.08.2021 lsvi0303: SPEC0119669
(
mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,dat_von
,dat_bis
,EK_Preis_Brutto
,EK_Preis_Netto1
,EK_Preis_Netto2
,ek_kal_basis
,ek_mep
,ek_kl_preis
,logistikkostenzuschlag
,bezugsweg_id
,kjmo
,reihenfolge
)
AS
SELECT
a.mandant_id
,a.art_id
,a.gp_id
,a.wup_id
,a.nb_id
,a.dat_von
,a.dat_bis
,a.EK_Brutto
,a.EK_Netto
,a.EK_NettoNetto
,a.ek_kal_basis
,a.ek_mep
,a.einstandspreis
,a.logistikkostenzuschlag
,a.bezugsweg_id
,m.kjmo
,(CASE a.wup_id
WHEN 6907 THEN 1
WHEN 6906 THEN 2
WHEN -1 THEN 3
ELSE 4 END
) AS reihenfolge
FROM dbp_view.v_art_gp_wup_zu_per a
INNER JOIN dbp_view.v_monat m
ON m.kjmo BETWEEN 
TO_CHAR(a.dat_von, 'YYYYMM') AND TO_CHAR(a.dat_bis, 'YYYYMM')
--WHERE wup_id IN (6907, 6906, -1) AND  
WHERE m.akt_mo <= 0
AND a.mandant_id = 1
QUALIFY SUM(1) OVER (PARTITION BY a.art_id,m.kjmo ORDER BY m.kjmo, reihenfolge,a.dat_von DESC NULLS LAST ROWS UNBOUNDED PRECEDING) = 1;

