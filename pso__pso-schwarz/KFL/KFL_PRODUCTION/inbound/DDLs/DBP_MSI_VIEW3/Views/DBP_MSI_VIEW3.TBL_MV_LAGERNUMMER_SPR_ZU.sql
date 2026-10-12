CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_LAGERNUMMER_SPR_ZU
-- AP0016637, srom0404, es gibt Lagerorte, z. B. R009 in Möckmühl (6906), die keiner Lagernummer zugeordnet sind
-- Erweiterung auf '-99'
-- 15.11.2021, srom0404, INC3846494, Attribut Lagernummer ist ohne wup_id und damit nicht eindeutig. Daher hier Eindeutigkeit über lagernummer_id herstellen
AS
SELECT
 v01.lagernummer_bez
,v01.lagernummer_id
,v01.mandant_id
,v01.nb_id
,v01.spr_id
,v01.wup_id
FROM dbp_view.v_lagernummer_spr_zu v01

UNION ALL

SELECT DISTINCT
 'keine Zuordnung (VZ ' || TRIM(v03.wup_id) || ')' AS lagernummer_bez
,CASE WHEN mandant_id = 1  AND nb_id = -111 THEN '-'||SUBSTR(wup_id,2,4)
      WHEN mandant_id <> 1 AND nb_id = -111 THEN '-'||SUBSTR(wup_id,1,3)
      ELSE '-99'
 END AS lagernummer_id
,v03.mandant_id
,v03.nb_id
,v03.spr_id
,v03.wup_id
FROM dbp_view.v_lagernummer_spr_zu v03
WHERE v03.wup_id > 1000
  AND v03.nb_id = -111;