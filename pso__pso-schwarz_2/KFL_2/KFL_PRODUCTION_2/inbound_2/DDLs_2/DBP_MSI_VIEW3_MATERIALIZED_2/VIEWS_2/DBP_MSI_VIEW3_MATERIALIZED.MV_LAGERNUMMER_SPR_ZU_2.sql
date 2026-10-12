create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGERNUMMER_SPR_ZU_2(
	LAGERNUMMER_BEZ,
	LAGERNUMMER_ID,
	MANDANT_ID,
	NB_ID,
	SPR_ID,
	WUP_ID
) as 
-- AP0016637, srom0404, es gibt Lagerorte, z. B. R009 in Möckmühl_2 (6906), die keiner Lagernummer zugeordnet sind
-- Erweiterung auf '-99'
-- 15.11.2021, srom0404, INC3846494, Attribut Lagernummer ist ohne wup_id und damit nicht eindeutig. Daher hier Eindeutigkeit über lagernummer_id herstellen
-- 20.12.2021, dknop, INC4021370, removing wup_id (9825, 9205)
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
  DISTINCT v01.lagernummer_bez,
  v01.lagernummer_id,
  v01.mandant_id,
  v01.nb_id,
  v01.spr_id,
  v01.wup_id
FROM
  DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_LAGERNUMMER_SPR_ZU_2 v01
  JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
  ON v01.spr_id = v02.spr_id
WHERE
  wup_id NOT IN (9825, 9205);