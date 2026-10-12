CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGERNUMMER_1
-- AP0016637, srom0404, es gibt Lagerorte, z. B. R009 in Möckmühl_1 (6906), die keiner Lagernummer zugeordnet sind
-- Erweiterung auf '-99'
-- AP0032009, SPEC0040130, mkub1811, 19.07.2018, Erweiterung um oug_fg aus dbe_fed_data_lis
-- 03.12.2018, mkub1811, AP0027269, Erweiterung um dummy_tor_id
-- 15.11.2021, srom0404, INC3846494, Attribut Lagernummer ist ohne wup_id und damit nicht eindeutig. Daher hier Eindeutigkeit über lagernummer_id herstellen
AS
SELECT
 v01.lagernummer_id
,v01.mandant_id
,v01.nb_id
,v01.wup_id
,v01.oug_fg
,v01.dummy_tor_id
FROM dbp_view.v_l_lagernummer_1 v01

UNION ALL

SELECT DISTINCT
 CASE WHEN mandant_id = 1  AND nb_id = -111 THEN '-'||SUBSTR(wup_id,2,4)
      WHEN mandant_id <> 1 AND nb_id = -111 THEN '-'||SUBSTR(wup_id,1,3)
      ELSE '-99'
 END AS lagernummer_id
,v02.mandant_id
,v02.nb_id
,v02.wup_id
,0 AS oug_fg
,0 AS dummy_tor_id
FROM dbp_view.v_lagernummer_spr_zu_1 v02
WHERE v02.wup_id > 1000
  AND v02.nb_id = -111;