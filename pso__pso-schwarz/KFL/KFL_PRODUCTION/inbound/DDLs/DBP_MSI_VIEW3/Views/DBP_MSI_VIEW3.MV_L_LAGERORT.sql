CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGERORT
-- AP0016637, srom0404, es gibt Lagerorte, z. B. R009 in Möckmühl (6906), die keiner Lagernummer zugeordnet sind
-- Erweiterung auf '-99'
-- AP0006750/AP0012522, nwag2310, zus. nicht existente Lagernummern auf -99 umschlüsseln (z.B. S14 in Ilava, die bei LGORT 0004 hinterlegt ist)
-- 15.11.2021, srom0404, INC3846494, Attribut Lagernummer ist ohne wup_id und damit nicht eindeutig. Daher hier Eindeutigkeit über lagernummer_id herstellen
AS
SELECT
 v01.lagerort_id
,v01.mandant_id
,v01.nb_id
,v01.wup_id
,COALESCE(v02.lagernummer_id,CASE WHEN v01.mandant_id = 1  AND v01.nb_id = -111 THEN '-'||SUBSTR(v01.wup_id,2,4)
                                  WHEN v01.mandant_id <> 1 AND v01.nb_id = -111 THEN '-'||SUBSTR(v01.wup_id,1,3)
                                  ELSE '-99' 
                              END) AS lagernummer_id
FROM dbp_view.v_l_lagerort v01
LEFT OUTER JOIN dbp_view.v_l_lagernummer v02
  ON v01.mandant_id = v02.mandant_id
 AND v01.wup_id     = v02.wup_id
 AND v01.nb_id      = v02.nb_id
 AND v01.lagernummer_id = v02.lagernummer_id
 WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3');